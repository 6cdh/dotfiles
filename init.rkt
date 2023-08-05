#lang racket

(define (report msg)
  (eprintf "~a\n" msg))

(define (filesystem-name-exists? name)
  (or (file-exists? name) (link-exists? name) (directory-exists? name)))

(define (make-link-check old new)
  (define abs-new (path->complete-path new))
  (define abs-old (path->complete-path old))
  (cond [(not (filesystem-name-exists? abs-old))
         (report (format "[LINK ERROR] old path ~v not exists." abs-old))]
        [(filesystem-name-exists? abs-new)
         (report (format "[LINK ERROR] new path ~v exists." abs-new))]
        [else
         (displayln (format "[LINK] ~a => ~a" abs-new abs-old))
         (make-file-or-directory-link abs-old abs-new)]))

(define (subfunction-port out)
  (define last-newline? #t)

  (make-output-port
   'subfunction-port
   always-evt
   (lambda (bs start end _non_block? _breakable?)
     (for ([i (in-range start end)])
       (let ([c (bytes-ref bs i)])
         (when last-newline?
           (write-string "|  " out))
         (write-byte c out)
         (set! last-newline?
               (= c (char->integer #\newline)))))
     (- end start))
   void))

(define (run-command cmd
                     #:confirm? [confirm? #f]
                     #:show [show #f])
  (define (run cmd)
    (define p (subfunction-port (current-output-port)))
    (parameterize ([current-output-port p]
                   [current-error-port p])
      (system cmd))
    (void))

  (match confirm?
    [#f
     (displayln (format "[RUN] ~a" (if show show cmd)))
     (run cmd)]
    [#t
     (display (format "[RUN] ~a [Y/n] " (if show show cmd)))
     (flush-output)
     (match (read-char)
       [(or #\newline #\Y #\y)
        (run cmd)]
       [_ (void)])]))

(define (make-path prefix dir)
  (match prefix
    ['home (format "/home/~a/~a" (user) dir)]
    ['config (format "/home/~a/.config/~a" (user) dir)]
    ['sys (format "/~a" dir)]
    ['data (format "/home/~a/.local/share/~a" (user) dir)]
    [_ (error "unexpected prefix: " prefix)]))

(define-syntax link
  (syntax-rules (=>)
    [(link)
     (void)]
    [(link ((prefix dir) => old) rems ...)
     (begin
       (make-link-check old (make-path (quote prefix) dir))
       (link rems ...))]
    [(link (new => old) rems ...)
     (begin
       (make-link-check old new)
       (link rems ...))]))

(define (pkg pkglst)
  (when (not (null? pkglst))
    (run-command (format "sudo ~a ~a"
                         (pkg-install)
                         (string-join (map symbol->string pkglst) " "))
                 #:confirm? #t)))

(define pkg-enable? (make-parameter #f))
(define link-enable? (make-parameter #f))
(define backup-enable? (make-parameter #f))
(define user (make-parameter #f))
(define pkg-install (make-parameter #f))

(define read-password
  (let ([pass #f])
    (lambda ()
      (when (not pass)
        (set! pass (string-replace (file->string "pass.txt")
                                   "\n" "")))
      pass)))

(define (backup1 f c)
  (define ignores
    '("node_modules" ".mypy_cache" "compiled"
                     "target/debug" "target/release" ".gradle" "zig-cache" "zig-out"
                     "local/wiki_data" "wiki/extensions" "wiki/skins"))
  (define ignores-str
    (string-join
     (for/list ([d ignores])
       (format "--exclude ~a" d))
     " "))

  (define (cloud-sync f c)
    (run-command (format "rclone -c copy ~a db:~a" f c)))

  (define temp-paths (mutable-set))

  (define (process-seq f)
    (cond [(file-exists? f)
           f]
          [(directory-exists? f)
           (define temp-dir (string-append f "_temp"))
           (set-add! temp-paths temp-dir)
           (run-command (format "rsync -aq ~a ~a ~a" f temp-dir ignores-str)
                        #:show (format "rsync -aq ~a ~a --exclude ***" f temp-dir))
           temp-dir]
          [(link-exists? f)
           (error "no support link " f)]
          [(not (path-get-extension f))
           (error "no file " f)]
          [else
           (set-add! temp-paths f)
           (define ext (path-get-extension f))
           (define last-f (process-seq (path->string (path-replace-extension f ""))))
           (match ext
             [#".zst"
              (run-command (format "zstd ~a -f --no-progress" last-f))]
             [#".tar"
              (run-command (format "tar -cf ~a ~a" f last-f))]
             [#".gpg"
              (run-command
               (format "gpg --batch --yes --passphrase ~a -c ~a"
                       (read-password)
                       last-f)
               #:show (format "gpg --batch --yes --passphrase *** -c ~a" last-f))]
             [_ (error "unknown ext " ext)])
           f]))

  (cloud-sync (process-seq f) c)
  (for ([t temp-paths])
    (delete-directory/files t)))

(define-syntax backup
  (syntax-rules (<->)
    [(_)
     (void)]
    [(_ (file <-> cloud) rems ...)
     (begin
       (backup1 file cloud)
       (backup rems ...))]))

(define (main)
  (for ([cmd (current-command-line-arguments)])
    (match cmd
      ["link" (link-enable? #t)]
      ["backup" (backup-enable? #t)]
      [_ (error "unknown argument: " cmd)]))

  (user 'lcdh)
  (pkg-install "dnf install")

  (when (pkg-enable?)
    (pkg '(keepassxc zsh docker docker-compose
                     dnscrypt-proxy kitty)))

  (when (link-enable?)
    (link ((home ".ssh") => "private/ssh")
          ((config "cmus") => "private/cmus")
          ((config "rclone") => "private/rclone")
          ((config "nvim") => "editor/nvim")
          ((config "doom") => "editor/emacs")
          ((home ".zshcfg") => "shell/zsh/.zshcfg")
          ((home ".zshrc") => "shell/zsh/.zshrc")
          ((config "kitty") => "terminal/kitty")
          ((config "starship.toml") => "shell/starship.toml")
          ((config "efm-langserver") => "editor/efm-langserver")
          ((config "alacritty") => "terminal/alacritty")
          ((home ".gitconfig") => "private/gitconfig")
          ((config "home-manager") => "sys/home-manager")
          ((data "fonts") => "gui/fonts")
          ((home ".tmux.conf") => "shell/tmux.conf")
          ((home "work") => "work")))

  (when (backup-enable?)
    (backup ("private.tar.zst.gpg" <-> "backup")
            ("docker.tar.zst.gpg" <-> "backup")
            ("work.tar.zst" <-> "backup"))))

(main)


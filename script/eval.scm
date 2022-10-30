#!guile -s
!#
;; utility

(define (printf fmt . arg)
  (apply format #t fmt arg))

(define (fmt fmtstr . arg)
  (apply format #f fmtstr arg))

(define (println str)
  (display str)
  (newline))


(define (assert condition msg)
  (when (not condition)
        (println msg))
  condition)


(define (msg level fmtstr . arg)
  (apply fmt (string-append "~a: " fmtstr) level arg))

;; soft link

(define-syntax soft-link
  (syntax-rules (=>)
    [(soft-link) '()]
    [(soft-link source => target rest ...)
     (begin
      (try-create-link source target)
      (soft-link rest ...))]))

(define (try-create-link source target)
  (define (link-invalid? link)
    "return #t if `link` doesn't exist or `link` is broken
            #f otherwise"
    (or (not (file-exists? link))
        (catch 'system-error
               (λ () (not (->bool (readlink link))))
               (const #t))))

  (define (create-link-force src tgt)
    "create link src => tgt.
    `src` and `tgt` are absolute path."
    (println (msg 'LINK "~a => ~a" src tgt))
    (catch 'system-error
           (lambda () (delete-file src))
           (const #t))
    (symlink tgt src))


  (when (and (assert (link-invalid? source)
                     (msg 'SKIP "source \"~a\" exists." source))
             (assert (file-exists? target)
                     (msg 'ERROR "target \"~a\" doesn't exist." target)))
    (let ([tgt (relative->absolute target)])
      (create-link-force source tgt))))


(define (relative->absolute str)
  (canonicalize-path str))

(define (home . path)
  (apply string-append
         (passwd:dir
            (getpw
              (symbol->string *user*))) 
         "/" path))

(define (root . path)
  (apply string-append path))

(define (xdg/config path)
  (home ".config/" path))

(define (xdg/data path)
  (home ".local/share/" path))

;; fetch-github

(define-syntax fetch-github
  (syntax-rules (=>)
    ((fetch-github) '())
    ((fetch-github (repo => path arg ...) rest ...)
     (begin (github-clone repo path arg ...)
            (fetch-github rest ...)))))


(define (github-clone repo path . arg)
  (clone-from "https://github.com/" repo path arg))


(define (clone-from url-prefix repo path arg)
  (define (process-arg arg)
    (let-syntax ([append-argstr!
                  (syntax-rules ()
                    ((append-argstr argstr new)
                     (set! argstr (string-append argstr new))))])
      (let ([arg-str ""])
        (when (not (memv 'deep arg))
          (append-argstr! arg-str " --depth 1"))
        (when (memv 'quiet arg)
          (append-argstr! arg-str " --quiet"))
        arg-str)))

  (when (assert (not (file-exists? path))
                (msg 'SKIP "git dir \"~a\" exists." path))
    (let ([cmd (fmt "git clone ~a ~a ~a"
                 (string-append url-prefix repo)
                 path
                 (process-arg arg))])
      (println (msg 'CLONE cmd))
      (system cmd))))


;; TODO: ensure-install

(define-syntax ensure-install
  (syntax-rules ()
    ((ensure-install pkgs ...) '())))

;; TODO: service

(define-syntax service
  (syntax-rules ()
    ((service services ...) '())))


(define *user* '6cdh)

(define (user name)
  (set! *user* name))

;; eval user config

(define (repl port)
  (let ([form (read port)])
       (when (not (eof-object? form))
             (primitive-eval form)
             (repl port))))

(let ([argv (program-arguments)])
  (if (> (length (program-arguments)) 1)
     (repl (open-input-file (list-ref argv 1)))))

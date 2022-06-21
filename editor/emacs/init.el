;; -*- lexical-binding: t; -*-

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell nil)

(setq make-backup-files nil
      delete-old-versions t
      version-control nil)

(setq gc-cons-threshold (round 1e8))
(setq read-process-output-max (* 1024 1024))

(column-number-mode)
(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook
		help-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-face-attribute 'default nil :font "CamingoCode Nerd Font" :height 130)
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Cantarell" :height 150))))
 '(fixed-pitch ((t (:family "CamingoCode Nerd Font" :height 130)))))

(setq url-proxy-services '(("no_proxy" . "localhost")
			   ("http" . "localhost:4097")
			   ("https" . "localhost:4097")))

;; straight.el package manager ;;

(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; pkgs ;;

(straight-use-package 'use-package)

(defmacro my-use-pkg (name &rest args)
  "custom use-package
(currently defaults to straight.el)."
  (append `(use-package ,name
	     :straight t)
	  args))

(my-use-pkg doom-themes
	    :config
	    (progn
	      (require 'doom-themes)
	      (setq doom-themes-enable-bold t
		    doom-themes-enable-italic t)

	      (load-theme 'doom-one-light t)
	      (doom-themes-visual-bell-config)))

(my-use-pkg command-log-mode)

(my-use-pkg vertico :init (vertico-mode))

(my-use-pkg savehist
	    :init (savehist-mode))

(my-use-pkg orderless
	    :init
	    (setq completion-styles '(orderless basic)
		  completion-category-defaults nil
		  completion-category-overrides '((file (styles partial-completion)))))

(my-use-pkg company
	    :custom
	    (company-idle-delay 0.2)
	    :config (add-hook 'after-init-hook 'global-company-mode))

(my-use-pkg yasnippet
	    :config
	    (add-hook 'prog-mode-hook 'yas-minor-mode)
	    (add-hook 'text-mode-hook 'yas-minor-mode))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(global-set-key [tab] 'tab-indent-or-complete)

(my-use-pkg yasnippet-snippets
	    :after (yasnippet))

(my-use-pkg doom-modeline
	    :init (doom-modeline-mode 1))

(my-use-pkg all-the-icons)

(my-use-pkg rainbow-delimiters
	    :hook (prog-mode . rainbow-delimiters-mode))

(my-use-pkg which-key
	    :config (progn
		      (setq which-key-idle-delay 0.2)
		      (which-key-mode)))

(my-use-pkg markdown-mode)

;; god mode

(my-use-pkg god-mode)

(setq god-mode-alist '((nil . "C-") ("m" . "M-") ("M" . "C-M-")))
(global-set-key (kbd "<escape>") #'god-mode-all)

(defun god-mode-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
			'box
		      'bar)))

(add-hook 'post-command-hook #'god-mode-cursor)

(require 'god-mode-isearch)
(define-key isearch-mode-map (kbd "<escape>") #'god-mode-isearch-activate)
(define-key god-mode-isearch-map (kbd "<escape>") #'god-mode-isearch-disable)

(defvar my-current-layout 'colemak)
(defvar my-keymap t)

(defmacro my-map (-kbd -fn)
  `(define-key god-local-mode-map (kbd ,-kbd) ,-fn))

(defun my-delete ()
  (interactive)
  (if mark-active
      (command-execute #'kill-region)
    (command-execute #'delete-char)))

(defun my-join-line ()
  (interactive)
  (command-execute #'next-line)
  (command-execute #'join-line))

(defun my-change ()
  (interactive)
  (my-delete)
  (god-mode))

(defun my-select-word ()
  (interactive)
  (command-execute #'forward-word)
  (command-execute #'backward-word)
  (command-execute #'mark-word))

(defun my-select-sexp ()
  (interactive)
  (command-execute #'forward-sexp)
  (command-execute #'backward-sexp)
  (command-execute #'mark-sexp))

(when my-keymap
  (my-map "." #'repeat)
  ;; copy/cut/delete
  (my-map "d" #'my-delete)
  (my-map "c" #'my-change)
  (my-map "D" #'kill-line)
  (my-map "y" #'copy-region-as-kill)
  (my-map "p" #'yank)
  (my-map "J" #'my-join-line)
  ;; select - vim visual mode
  (my-map "v" #'set-mark-command)	; or use SPC to set/unset
  ;; select text object
  (my-map "C-t C-l" "a v e")
  ;; semantic
  (my-map "C-x C-;" #'comment-line)
  ;; others
  (my-map "a" #'move-beginning-of-line)
  (my-map "0" #'back-to-indentation)
  (my-map "e" #'move-end-of-line)
  (my-map "b" #'left-word)
  (my-map "w" #'right-word)
  ;; undo/redo
  (my-map "C-u C-u" #'undo)
  (my-map "C-u C-r" #'undo-redo)
  ;; search
  (my-map "/" #'isearch-forward)
  (my-map "?" #'isearch-backward)
  ;; basic move - vim like
  (my-map "j" #'next-line)
  (my-map "k" #'previous-line)
  (my-map "h" #'backward-char)
  (my-map "l" #'forward-char)
  ;; control
  (my-map "C-x C-q" #'quit-window)
  (my-map "C-x C-b" #'switch-to-buffer)
  (my-map "C-x C-w" #'other-window)
  (my-map "C-x C-f" #'find-file)
  (my-map "C-x C-s" #'save-buffer)
  (my-map "C-x C-x" #'execute-extended-command))

;; god mode end

(my-use-pkg projectile
	    :config (progn
		      (projectile-mode 1))
	    :bind-keymap ("C-c p" . projectile-command-map))

(my-use-pkg magit)

;; org mode

(setq org-hide-emphasis-markers t
      org-startup-indented t
      org-src-tab-acts-natively t
      org-cycle-level-faces nil
      org-highlight-latex-and-related '(native latex script entities))

(my-use-pkg org-bullets
	    :config (add-hook 'org-mode-hook
			      (lambda ()
				(org-bullets-mode 1)
				visual-line-mode)))

(custom-theme-set-faces
 'user
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-property-value        ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-verbatim              ((t (:inherit (shadow fixed-pitch))))))

(my-use-pkg racket-mode)
(my-use-pkg paredit)
(my-use-pkg flycheck)

;; lsp

(my-use-pkg lsp-mode
	    :custom
	    (lsp-eldoc-render-all t)
	    (lsp-idle-delay 0.6))

(my-use-pkg lsp-ui
	    :custom
	    (lsp-ui-peek-always-show t)
	    (lsp-ui-sideline-show-hover t)
	    (lsp-ui-doc-enable nil)
	    (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(my-use-pkg expand-region
	    :bind ("C-=" . er/expand-region))

(load "lang")

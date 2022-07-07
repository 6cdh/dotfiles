;; -*- lexical-binding: t; -*-

(setq url-proxy-services '(("no_proxy" . "localhost")
			   ("http" . "localhost:4097")
			   ("https" . "localhost:4097")))

;; straight.el

(defvar bootstrap-version)

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; straight.el END

(straight-use-package 'use-package)

(defmacro my-use-pkg (name &rest args)
  "custom use-package (currently defaults to straight.el)."
  (append `(use-package ,name
	     :straight t)
	  args))

(my-use-pkg gcmh
	    :config (gcmh-mode 1))

;; options

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(setq visible-bell nil)

(setq make-backup-files nil
      delete-old-versions t
      version-control nil
      auto-save-default t)

(setq read-process-output-max (* 1024 1024))

(column-number-mode)
(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(dolist (mode '(org-mode-hook
		markdown-mode-hook
		term-mode-hook
		vterm-mode-hook
		eshell-mode-hook
		help-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-face-attribute 'default nil :font "CamingoCode Nerd Font" :height 120)
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Cantarell" :height 150))))
 '(fixed-pitch ((t (:family "CamingoCode Nerd Font" :height 130)))))

;; options END

(load "godmode")

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

(my-use-pkg marginalia
	    :init (marginalia-mode))

(my-use-pkg savehist
	    :init (savehist-mode))

(my-use-pkg orderless
	    :init
	    (setq completion-styles '(orderless basic)
		  completion-category-defaults nil
		  completion-category-overrides '((file (styles partial-completion)))))

;; company

(my-use-pkg company
	    :custom
	    (company-idle-delay 0.1)
	    (company-minimum-prefix-length 2)
	    (company-require-match nil)
	    (company-tooltip-align-annotations t)
	    (company-tooltip-offset-display 'lines)
	    :config
	    (add-hook 'after-init-hook 'global-company-mode)
	    (add-hook 'after-init-hook 'company-tng-mode))

(defun my/company-always-enable (bks)
  "add always enabled backends 'bks' into 'company-backends'"
  (defun add-each (ori-bk)
    (if (listp ori-bk)
	(append ori-bk (cons :with bks))
      (cons ori-bk (cons :with bks))))
  (setq company-backends
	(append (mapcar #'add-each company-backends)
		(list bks))))

(my-use-pkg yasnippet
	    :config
	    (add-to-list 'yas-snippet-dirs "~/.config/emacs/snippets")
	    (add-hook 'prog-mode-hook 'yas-minor-mode)
	    (define-key yas-minor-mode-map (kbd "<tab>") nil)
	    (define-key yas-minor-mode-map (kbd "TAB") nil)
	    (add-hook 'text-mode-hook 'yas-minor-mode))

(my-use-pkg company-tabnine)

(my/company-always-enable '(company-tabnine company-yasnippet))

(my-use-pkg yasnippet-snippets
	    :after (yasnippet))

(setq company-transformers '(company-sort-by-occurrence
			     company-sort-prefer-same-case-prefix
			     delete-consecutive-dups))

;; company END

(my-use-pkg doom-modeline
	    :init (doom-modeline-mode 1))

(my-use-pkg all-the-icons)

(my-use-pkg rainbow-delimiters
	    :hook (prog-mode . rainbow-delimiters-mode))

(my-use-pkg which-key
	    :config (progn
		      (setq which-key-idle-delay 0.2)
		      (which-key-mode)))

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

;; orgmode END

(my-use-pkg smartparens
	    :config
	    (require 'smartparens-config)
	    (add-hook 'prog-mode-hook #'smartparens-strict-mode))

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

;; lsp END

(my-use-pkg editorconfig
	    :config (editorconfig-mode 1))

(my-use-pkg expand-region
	    :bind ("C-=" . er/expand-region))

(my-use-pkg vterm)

(my-use-pkg avy)

(load "lang")

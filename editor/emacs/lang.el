;; lisp
(dolist (hook '(emacs-lisp-mode-hook
		scheme-mode-hook
		clojure-mode-hook
		common-lisp-mode-hook
		racket-mode-hook))
  (add-hook hook #'paredit-mode))

;; racket

;; (add-hook 'racket-mode-hook #'lsp)

;; rust

(my-use-pkg rustic
	    :config
	    (setq lsp-eldoc-hook nil)
	    (setq lsp-enable-symbol-highlighting nil)
	    (setq lsp-signature-auto-activate nil)
	    (setq rustic-format-on-save t))

(add-hook 'rust-mode-hook #'lsp)
(remove-hook 'rustic-mode-hook 'flycheck-mode)

;; nix

(my-use-pkg nix-mode
	    :mode "\\.nix\\'")

(add-hook 'nix-mode-hook #'lsp)

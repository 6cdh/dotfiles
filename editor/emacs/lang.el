;; c++

(add-hook 'c++-mode-hook #'lsp)

;; python

(add-hook 'python-mode-hook #'lsp)

;; racket

(my-use-pkg racket-mode
	    :hook
	    ((racked-mode . racket-xp-mode)))

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

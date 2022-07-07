;; -*- lexical-binding: t; -*-

;; c++

(add-hook 'c++-mode-hook #'lsp)

;; lisp

(my-use-pkg slime
	    :config
	    (slime-setup '(slime-fancy slime-quicklisp slime-asdf))
	    (setq inferior-lisp-program "sbcl"))

;; markdown

(my-use-pkg markdown-mode
	    :custom
	    (markdown-code-block-braces t)
	    (markdown-enable-highlighting-syntax t)
	    (markdown-enable-math t))

;; nix

(my-use-pkg nix-mode
	    :mode "\\.nix\\'")

(add-hook 'nix-mode-hook #'lsp)

;; php

(my-use-pkg php-mode)

;; python

(add-hook 'python-mode-hook #'lsp)

;; racket

;; put it above 'racket-mode' because 'geiser-racket'
;; set racket file as scheme mode
(my-use-pkg geiser-racket)

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

;; yaml

(my-use-pkg yaml-mode)

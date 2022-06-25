;; -*- lexical-binding: t; -*-

;; improvements for startup time

;; copy from doomemacs
;; https://github.com/doomemacs/doomemacs/blob/master/early-init.el

;; disable gc temporarily and use package 'gcmh' later
(setq gc-cons-threshold most-positive-fixnum)

;; disable package.el
(setq package-enable-at-startup nil)

(unless (or (daemonp) noninteractive init-file-debug)
  (setq-default inhibit-redisplay t)
  
  (add-hook 'window-setup-hook
	    (lambda ()
	      (setq-default inhibit-redisplay nil)
	      (redisplay))))

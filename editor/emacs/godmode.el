(my-use-pkg god-mode
	    :config
	    (add-hook 'prog-mode-hook #'god-local-mode)
	    (add-hook 'text-mode-hook #'god-local-mode))

(setq god-mode-alist '((nil . "C-") ("m" . "M-") ("M" . "C-M-")))
(global-set-key (kbd "<escape>") #'god-local-mode)

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
  (god-local-mode))

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

(defun my-new-next-line ()
  (interactive)
  (command-execute #'move-end-of-line)
  (command-execute #'newline))

(defun my-new-prev-line ()
  (interactive)
  (command-execute #'previous-line)
  (my-new-next-line))

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
  (my-map "C-t C-s" #'my-select-sexp)
  ;; semantic
  (my-map "C-x C-;" #'comment-line)
  ;; code action
  (my-map "C-z C-r" #'sp-raise-sexp)
  (my-map "C-z C-p" #'sp-add-to-previous-sexp)
  (my-map "C-z C-w" #'sp-wrap-round)
  ;; others
  (my-map "a" #'move-beginning-of-line)
  (my-map "0" #'back-to-indentation)
  (my-map "e" #'move-end-of-line)
  (my-map "b" #'left-word)
  (my-map "w" #'right-word)
  (my-map "o" #'my-new-next-line)
  (my-map "O" #'my-new-prev-line)
  ;; undo/redo
  (my-map "C-u C-u" #'undo)
  (my-map "C-u C-r" #'undo-redo)
  ;; search
  (my-map ":" #'avy-goto-char)
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

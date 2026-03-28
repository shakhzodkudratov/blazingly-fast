(in-package :lem-user)
(use-package :lem-vi-mode)

(vi-mode)
(load-theme "gruvbox-dark-pale")

;; AstroNvim like keybindings
(define-key *normal-keymap* "Space w" 'save-current-buffer)
(define-key *normal-keymap* "Space q" 'exit-lem)
(define-command open-init-file () ()
  (find-file "~/blazingly-fast/lem/init.lisp"))
(define-key *normal-keymap* "Space C" 'open-init-file)
(define-key *normal-keymap* "Space /" 'lem/language-mode:comment-or-uncomment-region)
(define-key *visual-keymap* "Space /" 'lem/language-mode:comment-or-uncomment-region)
(define-key *normal-keymap* "Space e" 'lem/filer::filer)
(define-key *normal-keymap* "Space o" 'next-window)
(define-key *normal-keymap* "Space b" 'lem/list-buffers:list-buffers)
(define-command kill-buffer-and-delete-window () ()
  (let ((buf (current-buffer)))
    (unless (one-window-p)
      (delete-active-window))
    (kill-buffer buf)))
(define-key *normal-keymap* "Space c" 'kill-buffer-and-delete-window)
(define-key *normal-keymap* "Space L" 'lem-lisp-mode:start-lisp-repl)

;; Remove paredit bindings that conflict with vi motions
(undefine-key lem-paredit-mode:*paredit-mode-keymap* ")")
(undefine-key lem-paredit-mode:*paredit-mode-keymap* "(")
(undefine-key lem-paredit-mode:*paredit-mode-keymap* "[")
(undefine-key lem-paredit-mode:*paredit-mode-keymap* "]")
(undefine-key lem-paredit-mode:*paredit-mode-keymap* "{")
(undefine-key lem-paredit-mode:*paredit-mode-keymap* "}")

;; Re-add them only in vi insert mode where they make sense
(define-key lem-vi-mode:*insert-keymap* ")" 'lem-paredit-mode:paredit-close-parenthesis)
(define-key lem-vi-mode:*insert-keymap* "(" 'lem-paredit-mode:paredit-insert-paren)
(define-key lem-vi-mode:*insert-keymap* "[" 'lem-paredit-mode:paredit-insert-bracket)
(define-key lem-vi-mode:*insert-keymap* "]" 'lem-paredit-mode:paredit-close-bracket)
(define-key lem-vi-mode:*insert-keymap* "{" 'lem-paredit-mode:paredit-insert-brace)
(define-key lem-vi-mode:*insert-keymap* "}" 'lem-paredit-mode:paredit-close-brace)

;; Loads (setf lem-lisp-mode/internal::*file-conversion-map*) with proper sources, since it comes from Nix
(let ((path #P"~/.lem-source.lisp"))
  (handler-case
      (if (probe-file path)
          (load path)
          (show-message (format nil "Warning: ~a not found" path)))
    (error (e)
      (show-message (format nil "Error loading ~a: ~a" path e)))))

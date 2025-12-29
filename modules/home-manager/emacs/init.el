(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)
(setq scroll-margin 8)
(setq scroll-conservatively 101)
(setq scroll-preserve-screen-position t)
(setq auto-window-vscroll nil)
(setq custom-file "~/.emacs.custom")
(load custom-file 'noerror)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(load-theme 'gruvbox-dark-medium t)

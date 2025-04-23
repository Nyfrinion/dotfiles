;; ~/.emacs.d/modules/ui.el
(use-package doom-themes
  :config (load-theme 'doom-dracula t))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(set-frame-font "JetBrainsMono Nerd Font 13" nil t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

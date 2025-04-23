;; ~/.emacs.d/init.el
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'core)
(require 'ui)
(require 'editing)

;; Vim keybindings
(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)

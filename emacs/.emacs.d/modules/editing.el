;; ~/.emacs.d/modules/editing.el
(use-package which-key
  :init (which-key-mode))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

;; ~/.emacs.d/modules/org.el

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode))
  :config
  (setq org-directory "~/notes")  ;; Your Obsidian-style vault
  (setq org-default-notes-file (expand-file-name "inbox.org" org-directory))
  (setq org-hide-emphasis-markers t)
  (setq org-startup-indented t)
  (setq org-startup-folded 'content)
  (setq org-ellipsis " ⤵")

  ;; Logging & todo behavior
  (setq org-log-done 'time)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "WAIT(w)" "HOLD(h)" "|" "CANCELLED(c)")))

  ;; Enable code blocks (babel)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
     (python . t)))

  ;; Don't ask before evaluating code blocks
  (setq org-confirm-babel-evaluate nil))

;; Org capture templates
(use-package org-capture
  :after org
  :config
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/notes/inbox.org" "Tasks")
           "* TODO %?\n  %U\n  %a"))))

;; Agenda setup
(use-package org-agenda
  :after org
  :config
  (setq org-agenda-files '("~/notes/inbox.org"
                           "~/notes/projects.org"
                           "~/notes/schedule.org")))

;; Optional: Roam-like navigation
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/notes/roam"))
  :config
  (org-roam-db-autosync-mode)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n d" . org-roam-dailies-capture-today)))

;; Images + paste support
(use-package org-download
  :after org
  :config
  (setq org-download-image-dir "images"
        org-download-heading-lvl nil
        org-download-timestamp "%Y%m%d-%H%M%S_")
  (add-hook 'dired-mode-hook 'org-download-enable))

;; Beautify bullets
(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("◉" "○" "✿" "▷")))

;; Export settings (optional)
(setq org-export-with-toc t
      org-export-with-section-numbers t
      org-html-htmlize-output-type 'css)

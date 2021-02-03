(use-package project
  :ensure t
  :bind
  ("C-x p v" . my-project-magit)
  :config
  (defun my-project-magit ()
    (interactive)
    (magit-status (project-root (project-current t))))
  :custom
  (project-list-file (concat user-emacs-directory "/auto-save-list/project-list.file")))

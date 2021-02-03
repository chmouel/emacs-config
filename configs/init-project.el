(use-package project
  :ensure t
  :bind
  ("C-x p v" . project-vc-dir)
  :custom
  (project-list-file (concat user-emacs-directory "/auto-save-list/project-list.file")))

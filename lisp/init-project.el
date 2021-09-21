;; Projects

(defun my-project-and-dired()
  (interactive)
  (let ((project-switch-commands 'project-dired))
    (call-interactively 'project-switch-project)))

(defun my-project-and-find-file()
  (interactive)
  (let ((project-switch-commands 'project-find-file))
    (call-interactively 'project-switch-project)))

(use-package project
  :ensure t
  :bind
  ("C-c b" . project-switch-to-buffer)
  ("C-c o" . my-project-and-find-file)
  ("C-c p" . my-project-and-dired)
  ("C-c f" . project-find-file)
  ("C-c u" . project-or-external-find-regexp)
  :custom
  (project-list-file (locate-user-emacs-file "auto-save-list/project-list.file")))

(provide 'init-project)

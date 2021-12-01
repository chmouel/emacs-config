;; Projects
(use-package project
  :ensure t
  :bind
  ("C-c b" . project-switch-to-buffer)
  ("C-x p o" . (lambda ()
                 (interactive)
                 (let ((project-switch-commands 'project-find-file))
                   (call-interactively 'project-switch-project))))
  ("C-x p p" . (lambda ()
                 (interactive)
                 (let ((project-switch-commands 'project-dired))
                   (call-interactively 'project-switch-project))))
  ("C-x p P" . project-switch-project)
  ("C-c f" . project-find-file)
  ("C-c h" . project-find-regexp)
  :custom
  (project-list-file (locate-user-emacs-file "auto-save-list/project-list.file")))

(provide 'init-project)

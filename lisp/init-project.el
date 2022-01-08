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
                 (let ((project-switch-commands 'my-project-dirvish))
                   (call-interactively 'project-switch-project))))
  ("C-x p P" . project-switch-project)
  ("C-c f" . project-find-file)
  ("C-c h" . project-find-regexp)
  :config
  (defun my-project-dirvish ()
    (interactive)
    (dirvish (project-root (project-current t))))
  :custom
  (project-list-file (locate-user-emacs-file "auto-save-list/project-list.file")))

(defvar project-x-location
  (expand-file-name
   (concat "auto-save-list/modes/project-x") user-emacs-directory))
(use-package project-x
  :after project
  :if (file-directory-p project-x-location)
  :load-path project-x-location
  :custom
  (project-x-window-list-file
   (expand-file-name
    (concat "auto-save-list/project-window-list") user-emacs-directory))
  :init
  (require 'project-x)
  (setq project-x-save-interval 600)    ;Save project state every 10 min
  (project-x-mode 1)) 

(provide 'init-project)

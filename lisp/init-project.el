(defun my-projectile-and-dired()
  (interactive)
  (let ((projectile-switch-project-action 'projectile-dired))
    (projectile-switch-project)))

(defun my-projectile-mode-line ()
  (let ((project-name (projectile-project-name)))
    (if (not (string= project-name "-"))
        (format
         " %s"
         (propertize
          project-name 'face '(:foreground "Light Blue" :weight bold))))))

(defun my-projectile-and-find-file()
  (interactive)
  (let ((projectile-switch-project-action 'my-projectile-find-file))
    (projectile-switch-project)))

(defun my-projectile-and-ripgrep()
  (interactive)
  (let ((consult-preview-key 'any)
        (projectile-switch-project-action 'consult-ripgrep))
    (projectile-switch-project)))

(defun my-projectile-find-file()
  (interactive)
  (let* ((project-root (projectile-ensure-project (projectile-project-root)))
         (files
          (if (boundp 'my-project-ignore-files)
              (--filter (not (string-match my-project-ignore-files it))
                        (projectile-project-files project-root))
            (projectile-project-files project-root)))
         (file (completing-read "Find file: " (sort files #'string<))))
    (when file
      (funcall 'find-file (expand-file-name file project-root))
      (run-hooks 'projectile-find-file-hook))))

(use-package project
  :ensure t
  ;; :bind
  ;; ("C-c u" . project-find-regexp)
  :custom
  (project-list-file (locate-user-emacs-file "auto-save-list/project-list.file")))

;; projectile
(use-package projectile
  :hook (after-init . projectile-mode)
  :commands (projectile-ensure-project projectile-project-root)
  :custom
  (projectile-cache-file (locate-user-emacs-file "auto-save-list/projectile.cache"))
  (projectile-known-projects-file
   (locate-user-emacs-file "auto-save-list/projectile-bookmarks.eld"))
  (projectile-mode-line-prefix "")
  (projectile-sort-order 'recentf)
  (projectile-switch-project-action 'projectile-dired)
  (projectile-mode-line-function 'my-projectile-mode-line)
  (projectile-sort-order 'recently-active)
  (frame-title-format
   '(""
     "%b"
     (:eval
      (let ((project-name (projectile-project-name)))
        (unless (string= "-" project-name)
          (format " ⏤ %s" project-name))))))
  :bind (("C-c b" . projectile-switch-to-buffer)
         ("C-c B" . projectile-ibuffer)
         ("C-c o" . my-projectile-and-find-file)
         ("C-c i" . my-projectile-and-ripgrep)
         ("C-c \\" . projectile-recentf)
         ("C-c u" . (lambda() (interactive)(let ((projectile-use-git-grep t)) (projectile-grep))))
         ("C-c f" . projectile-find-file)
         ("C-c P" . projectile-commander)
         ("M-<return>" . projectile-test-project)
         ("C-c <return>" . projectile-switch-open-project)
         ("C-c p" . my-projectile-and-dired)))

(provide 'init-project)

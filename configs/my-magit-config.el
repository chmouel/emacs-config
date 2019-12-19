(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :bind (("C-x v v" . my-magit-commit-buffer)
         ("C-x v +" . magit-pull)
         ("s-1" . magit-status)
         ("C-c g" . magit-status))
  :commands (magit-process-file magit-list-repos-uniquify)
  :config
  (setq magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
  (global-git-commit-mode)
  (magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

(defun my-magit-commit-buffer()
  (interactive)
  (if (not (magit-anything-modified-p nil (list (buffer-file-name))))
      (message "Fileset is up-to-date")
    (let ((default-directory (magit-toplevel)))
      (magit-run-git-with-editor
       "commit" (list "-v" (buffer-file-name))))))

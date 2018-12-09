(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :bind (("C-x v v" . my-magit-commit-buffer)
         ("s-g" . magit-status))
  :commands (magit-list-repos-uniquify)
  :config
  (setq magit-display-buffer-function 'my-magit-display-buffer)
  (global-git-commit-mode)
  (magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

;;
(defun my-magit-display-buffer (buffer)
  (or (get-buffer-window buffer)
      (if (one-window-p)
          (let ((new-win (split-window-vertically)))
            (set-window-buffer new-win buffer)
            new-win)
        (let ((new-win (get-lru-window)))
          (set-window-buffer new-win buffer)
          new-win))))

(defun my-magit-commit-buffer()
  (interactive)
  (if (not (magit-anything-modified-p nil (list (buffer-file-name))))
      (message "Fileset is up-to-date")
    (let ((default-directory (magit-toplevel)))
      (magit-run-git-with-editor
       "commit" (list "-v" (buffer-file-name))))))

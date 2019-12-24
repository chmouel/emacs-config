(setq forge-database-file
      (expand-file-name "~/.emacs.d/auto-save-list/forge.database"))

(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :bind (("C-x v v" . my-magit-commit-buffer)
         ("C-x v +" . magit-pull)
         ("s-1" . magit-status)
         ("s-2" . magit-show-refs)
         ("C-c g" . magit-status))
  :bind (:map magit-refs-mode-map
              ("K" . magit-branch-delete)
              ("k" . magit-section-backward)
              ("j" . magit-section-forward)
              ("." . (lambda () (interactive) (magit-checkout (magit-branch-at-point)))))
  :commands (magit-process-file magit-list-repos-uniquify)
  :config
  (setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-topleft-v1)
  (global-git-commit-mode)
  (magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

(defun my-magit-commit-buffer()
  (interactive)
  (if (not (magit-anything-modified-p nil (list (buffer-file-name))))
      (message "Fileset is up-to-date")
    (let ((default-directory (magit-toplevel)))
      (magit-run-git-with-editor
       "commit" (list "-v" (buffer-file-name))))))

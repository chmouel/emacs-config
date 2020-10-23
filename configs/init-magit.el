(setq forge-database-file
      (expand-file-name "~/.emacs.d/auto-save-list/forge.database"))
(use-package forge
  :bind (:map
         forge-topic-mode-map
         ("C-c C-l" . my-forge-show-pullreq-diff)
         :map magit-mode-map
         ("C-c C-l" . my-forge-show-pullreq-diff))
  :after magit)

(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :bind (;; ("C-x v v" . my-magit-commit-buffer)
         ("C-x v -" . magit-pull-from-pushremote)
         ("C-x v =" . my-diff-current-unstaged-file)
         ("C-x v s-=" . vc-diff)
         ("C-x v P" . magit-push-current-to-pushremote)
         ("<f5>" . magit-status)
         ("C-<f5>" . magit-show-refs)
         ("C-c g" . magit-status))
  :bind (:map magit-refs-mode-map
              ("K" . magit-branch-delete)
              ("k" . magit-section-backward)
              ("j" . magit-section-forward)
              ("." . (lambda ()
                       (interactive)
                       (magit-checkout (magit-branch-at-point)))))
  :commands (magit-process-file magit-list-repos-uniquify)
  :hook
  (magit-status-mode-hook my-magit-status-mode-hook)
  :config
  (defun my-magit-status-mode-hook ()
    (local-set-key '[(control =)] 'magit-commit-create))
  (setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-topleft-v1)
  (global-git-commit-mode)
  (magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

(defun my-diff-current-unstaged-file (&optional many)
  (interactive)
  (if (and
       (buffer-file-name)
       (vc-registered (buffer-file-name)))
      (if (magit-anything-unstaged-p
           nil `(,(file-name-nondirectory (buffer-file-name))))
          (magit-diff-unstaged '() `(,(magit-file-relative-name)))
        (message "no unstaged changes"))
    (message "buffer is not registered in GIT")))

(defun my-magit-commit-buffer()
  (interactive)
  (if (not (magit-anything-modified-p nil (list (buffer-file-name))))
      (message "Fileset is up-to-date")
    (let ((default-directory (magit-toplevel)))
      (magit-run-git-with-editor
       "commit" (list "-v" (buffer-file-name))))))

(defun my-forge-show-pullreq-diff ()
  (interactive)
  (let ((remote-upstream
         (if (member "upstream" (magit-list-remotes))
             "upstream" "origin"))
        (pullreq-number
         (oref (forge-current-topic) number)))
    (magit-show-commit
     (format "%s/pr/%s" remote-upstream pullreq-number))))


(provide 'init-magit)

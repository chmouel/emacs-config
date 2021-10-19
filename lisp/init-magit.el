(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :bind (("C-x v s-v" . my-magit-commit-buffer)
         ("C-x v -" . magit-pull-from-pushremote)
         ("C-x v =" . magit-diff-buffer-file)
         ("C-x v l" . magit-log-buffer-file)
         ("C-x v P" . magit-push-current-to-pushremote)
         ("<f5>" . magit-status)
         ("C-<f5>" . magit-show-refs)
         ("C-c G" . magit-file-dispatch)
         ("C-c g" . magit-status))
  :bind (:map magit-refs-mode-map
              ;; ("K" . magit-branch-delete)
              ;; ("k" . magit-section-backward)
              ;; ("j" . magit-section-forward)
              ("." . (lambda ()
                       (interactive)
                       (magit-checkout (magit-branch-at-point)))))
  :commands (magit-process-file magit-list-repos-uniquify)
  :hook
  (magit-status-mode-hook my-magit-status-mode-hook)
  :custom
  (transient-history-file (locate-user-emacs-file "auto-save-list/transient.history.el"))
  (transient-values-file (locate-user-emacs-file "auto-save-list/transient.values.el"))
  (transient-levels-file (locate-user-emacs-file "auto-save-list/transient.levels.el"))
  (magit-display-buffer-function 'magit-display-buffer-fullframe-status-topleft-v1)
  :config
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
  (defun my-magit-status-mode-hook ()
    (local-set-key '[(control =)] 'magit-commit-create))
  (global-git-commit-mode))


(use-package smerge-mode
  :bind ("s-m" . hydra-smerge/body)
  :init
  (defun my-smerge-first ()
    (interactive)
    (progn
      (goto-char (point-min))
      (smerge-next)))
  (defhydra
    hydra-smerge
    (:quit-key "C-g")
    "smerge"
    ("f" my-smerge-first "First")
    ("n" smerge-next "Next")
    ("p" smerge-prev "Previous")
    ("u" smerge-keep-upper "Keep Upper")
    ("l" smerge-keep-lower "Keep Lower")
    ("b" smerge-keep-all "Keep Both")))

(provide 'init-magit)

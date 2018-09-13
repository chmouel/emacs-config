(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :bind (("C-S-q"  . magit-status))
  :config
  (global-git-commit-mode)
  (magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

(defun my-magit-and-ag ()
  "Open quickly a magit directory and open a grep file in there"
  (interactive)
  (let ((default-directory (magit-read-repository nil)))
    (call-interactively 'my-ag-here)))
(global-set-key (read-kbd-macro "C-S-i") 'my-magit-and-ag)

;;open files for projects.
(defun my-magit-open-directory-and-files ()
  "Open quickly a magit directory and open a git file in there"
  (interactive)
  (let ((default-directory (magit-read-repository nil)))
    (magit-find-file-completing-read)))
(global-set-key (read-kbd-macro "C-S-o") 'my-magit-open-directory-and-files)

(defun my-magit-open-repository ()
  "Open quickly a magit directory."
  (interactive)
  (dired (magit-read-repository nil)))
(global-set-key (read-kbd-macro "C-S-p") 'my-magit-open-repository)

;;Find find in GIT repo
(use-package magit-find-file
  :bind
  (("C-S-f" . magit-find-file-completing-read))
  :config
  (setq my-magit-find-file-skip-vendor-pattern nil)
  (defun my-magit-find-file-without-vendor (res)
    (--remove
     (and
      my-magit-find-file-skip-vendor-pattern
      (string-match
       my-magit-find-file-skip-vendor-pattern it))
     res))
  (advice-add 'magit-find-file-files :filter-return #'my-magit-find-file-without-vendor)
  (add-hook
   'magit-mode-hook
   '(lambda () (interactive)
      (local-set-key '[(\`)] 'magit-find-file-completing-read))))

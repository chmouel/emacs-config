(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :chords (("op" . my-magit-open-directory-and-files)
           ("oi" . my-magit-open-repository))
  :bind (("s-S-v" . my-magit-stage-all-and-commit)
         ("s-i" . my-magit-and-ag)
         ("s-o" . my-magit-open-directory-and-files)
         ("s-p" . my-magit-open-repository)
         ("s-g" . magit-status))
  :config
  (global-git-commit-mode)
  (magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

(defun my-magit-stage-all-and-commit()
  (interactive)
  (magit-stage-file (buffer-file-name))
  (condition-case nil
      (magit-commit nil)
    (error nil))
  (magit-push-current-to-pushremote nil))

(defun my-magit-and-ag ()
  "Open quickly a magit directory and open a grep file in there"
  (interactive)
  (let ((default-directory (magit-read-repository nil)))
    (call-interactively 'my-ag-here)))

;;open files for projects.
(defun my-magit-open-directory-and-files ()
  "Open quickly a magit directory and open a git file in there"
  (interactive)
  (let ((default-directory (magit-read-repository nil)))
    (magit-find-file-completing-read)))

(defun my-magit-open-repository ()
  "Open quickly a magit directory."
  (interactive)
  (dired (magit-read-repository nil)))

;;Find find in GIT repo
(use-package magit-find-file
  :bind
  (("C-S-f" . my-project-find-file-or-recent))
  :config
  (defun my-project-find-file-or-recent(&optional argument)
    (interactive "P")
    (let ((toplevel (magit-toplevel)))
      (unless toplevel (error "error: not a git project"))
      (if argument
          (progn
            (setq toplevel
                  (s-replace-regexp (s-concat "/\\(home\\|Users\\)/" user-login-name) "~" (magit-toplevel)))
            (message toplevel)
            (find-file (ido-completing-read
                        "Recent in project: "
                        (-distinct (--filter (s-prefix-p toplevel it) file-name-history)))))
        (magit-find-file-completing-read))))
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

(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :chords (("op" . my-magit-open-directory-and-files)
           ("oi" . my-magit-open-repository))
  :bind (("C-x v v" . my-magit-commit-buffer)
         ("s-i" . my-magit-and-ag)
         ("s-o" . my-magit-open-directory-and-files)
         ("s-p" . my-magit-open-repository)
         ("s-g" . magit-status))
  :commands (magit-list-repos-uniquify)
  :config
  (global-git-commit-mode)
  (magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

(defun my-magit-commit-buffer()
  (interactive)
  (if (magit-anything-modified-p nil (list (buffer-file-name)))
      (let ((default-directory (magit-toplevel)))
        (magit-run-git-with-editor "commit" (list "-v" (buffer-file-name))))))

(defun my-magit-and-ag ()
  "Open quickly a magit directory and open a grep file in there"
  (interactive)
  (let ((default-directory (my-magit-read-repository)))
    (call-interactively 'my-ag-here)))

;;open files for projects.
(defun my-magit-open-directory-and-files ()
  "Open quickly a magit directory and open a git file in there"
  (interactive)
  (let ((default-directory (my-magit-read-repository)))
    (magit-find-file-completing-read)))

(setq my-magit-read-repositories nil)
(setq my-magit-repos-history nil)

;; read the magit repos but keep the chose one at the top of the lsit
(defun my-magit-read-repository ()
  (let* ((repos
          (if (not my-magit-read-repositories)
              (magit-list-repos-uniquify
               (--map (cons (file-name-nondirectory
                             (directory-file-name it))
                            it)
                      (magit-list-repos)))
            my-magit-read-repositories))
         (reply (ido-completing-read "Git repository: " repos nil nil nil my-magit-repos-history)))
    (setq my-magit-read-repositories (remove (assoc reply repos) repos))
    (add-to-list 'my-magit-read-repositories (assoc reply repos))
    (file-name-as-directory
     (or (cdr (assoc reply repos))
         (if (file-directory-p reply)
             (expand-file-name reply)
           (user-error "Not a repository or a directory: %s" reply))))))

(defun my-magit-open-repository ()
  "Open quickly a magit directory."
  (interactive)
  (dired (my-magit-read-repository)))

;;Find find in GIT repo
(use-package magit-find-file
  :bind
  (("C-S-f" . my-project-find-file-or-recent))
  :config
  (defun my-project-find-file-or-recent(&optional argument)
    (interactive "P")
    (let ((toplevel (magit-toplevel)))
      (unless toplevel (user-error "error: not a git project"))
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

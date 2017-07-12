;Magit
(Package 'magit
  (autoload 'magit-read-repository "magit" nil t)
  (autoload 'magit-toplevel "magit" nil t)
  (global-set-key (read-kbd-macro "C-c g") 'magit-status)

  (eval-after-load "magit"
    '(magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

  ;; Adapted from https://gist.github.com/ieure/883725 for magit-log
  (eval-after-load "magit"
    '(progn
       (defun magit-log-browse-github-commit (commit)
         "Open a browser pointing to the current commit on GitHub.

        With prefix argument, go to the commit HEAD is at."
         (interactive "p")
         (let* ((branch (magit-get-current-branch))
                (remote (and branch (magit-get "branch" branch "remote")))
                (remote-url (magit-get "remote" remote "url"))
                (current-commit (magit-commit-at-point)))

           (browse-url
            (cond ((string-match "git@github\\.com" remote-url)
                   (replace-regexp-in-string
                    "^git@github.com:\\(.*?\\)\\(\\.git\\)?$"
                    (format "https://github.com/\\1/commit/%s" current-commit)
                    remote-url))
                  ((string-match "https?://github\\.com" remote-url)
                   (replace-regexp-in-string
                    "^\\(https?://github\\.com/.*?\\)\\(\\.git\\)?$"
                    (format "\\1/commit/%s" current-commit) remote-url))
                  (t (error "Tracked branch is not on GitHub."))))))

       (define-key magit-log-mode-map "\C-cb" 'magit-log-browse-github-commit)))

  (setq magit-last-seen-setup-instructions "1.4.0")

  ;; Magit and git quick open files for projects.
  (defun my-magit-open-directory-and-files ()
    "Open quickly a magit directory and open a git file in there"
    (interactive)
    (let ((default-directory (magit-read-repository nil)))
      (magit-find-file-completing-read)))
  (global-set-key (read-kbd-macro "C-S-i") 'my-magit-open-directory-and-files)


  (defun my-magit-open-repository ()
    "Open quickly a magit directory."
    (interactive)
    (dired (magit-read-repository nil)))
  (global-set-key (read-kbd-macro "C-S-o") 'my-magit-open-repository))

;;Find find in GIT repo
(Package 'magit-find-file
  (eval-after-load "magit-find-file"
    '(progn
       (setq my-magit-find-file-skip-vendor-pattern nil)
       (defun my-magit-find-file-without-vendor (res)
         (--remove
          (and
           my-magit-find-file-skip-vendor-pattern
           (string-match
            my-magit-find-file-skip-vendor-pattern it))
          res))
       (advice-add 'magit-find-file-files :filter-return
                   #'my-magit-find-file-without-vendor)))
  (add-hook
   'magit-mode-hook
   '(lambda () (interactive)
      (local-set-key '[(\`)] 'magit-find-file-completing-read)))
  (global-set-key (kbd "C-S-f") 'magit-find-file-completing-read))

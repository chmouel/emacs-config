;Magit
(Package 'magit
  (autoload 'magit-read-repository "magit" nil t)
  (autoload 'magit-toplevel "magit" nil t)
  (global-set-key (read-kbd-macro "C-c g") 'magit-status)

  (eval-after-load "magit"
    '(magit-define-popup-switch 'magit-log-popup ?m "Omit merge commits" "--no-merges"))

  (setq magit-last-seen-setup-instructions "1.4.0")

  ;; Magit and git quick open files for projects.
  (defun my-magit-open-directory-and-files ()
    "Open quickly a magit directory and open a git file in there"
    (interactive)
    (let ((default-directory (magit-read-top-dir nil)))
      (magit-find-file-completing-read)))
  (global-set-key (read-kbd-macro "C-S-i") 'my-magit-open-directory-and-files)


  (defun my-magit-open-repository ()
    "Open quickly a magit directory."
    (interactive)
    (dired (magit-read-repository nil)))
  (global-set-key (read-kbd-macro "C-S-o") 'my-magit-open-repository))

;;Find find in GIT repo
(Package 'magit-find-file
  (add-hook 'magit-mode-hook '(lambda () (interactive) (local-set-key '[(\`)] 'magit-find-file-completing-read)))
  (global-set-key (kbd "C-S-f") 'magit-find-file-completing-read))

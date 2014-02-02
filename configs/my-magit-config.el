;Magit
(Package 'magit
  (autoload 'magit-read-top-dir "magit" nil t)
  (global-set-key (read-kbd-macro "C-c g") 'magit-status)

  ;; Full screen magit.
  (defadvice magit-status (around magit-fullscreen activate)
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-windows))

  (defadvice magit-quit-window (around magit-restore-screen activate)
    ad-do-it
    (jump-to-register :magit-fullscreen))

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
    (dired (magit-read-top-dir nil)))
  (global-set-key (read-kbd-macro "C-S-o") 'my-magit-open-repository))

;Find find in GIT repo
(Package 'magit-find-file
  (global-set-key (read-kbd-macro "C-`") 'magit-find-file-completing-read)
  (global-set-key (kbd "C-S-f") 'magit-find-file-completing-read))

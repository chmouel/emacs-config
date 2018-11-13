(use-package magit
  :commands (magit-read-repository magit-toplevel)
  :chords (("op" . my-magit-open-directory-and-files)
           ("oi" . my-magit-open-repository))
  :bind (("C-x v v" . my-magit-commit-buffer)
         ("s-b" . my-switch-buffer-in-project)
         ("s-i" . my-magit-and-ag)
         ("s-o" . my-magit-open-directory-and-files)
         ("s-p" . my-magit-open-repository)
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
    (my-magit-find-file-completing-read)))

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
  :commands (magit-find-file-files)
  :chords ("p[" . my-magit-find-file-completing-read)
  :bind (("C-S-f" . my-magit-find-file-completing-read)
         ("s-f" . my-magit-find-file-completing-read)))

(setq my-magit-find-files-last nil)
(defun my-magit-find-file-completing-read()
  (interactive)
  (let ((toplevel (magit-toplevel))
        (files (magit-find-file-files)))
    (when (and my-magit-find-files-last
               (string= toplevel (cdr my-magit-find-files-last)))
      (setq files (remove (car my-magit-find-files-last) files))
      (add-to-list 'files my-magit-find-files-last))
    (setq my-magit-find-files-last
          (cons
           (magit-completing-read
            (format "Find file in %s" (abbreviate-file-name default-directory))
            files)
           toplevel)
          ))
  (magit-with-toplevel
    (find-file (car my-magit-find-files-last))))

(defun my-switch-buffer-in-project ()
  (interactive)
  (when-let ((toplevel (magit-toplevel)))
    (ido-completing-read
     "Switch to buffer in project: "
     (mapcar
      (lambda (arg)
        (s-replace-regexp
         (s-concat "/\\(home\\|Users\\)/" user-login-name)
         "~" (buffer-file-name arg)))
      (--filter (s-prefix-p toplevel (buffer-file-name it)) (buffer-list))))))

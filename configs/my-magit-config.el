;Magit
(my-ensure-installed 'magit)
(autoload 'magit-read-top-dir "magit" nil t)
(global-set-key (read-kbd-macro "C-c g") 'magit-status)
(eval-after-load "vc-git"
  '(progn
     (define-derived-mode vc-git-log-edit-mode log-edit-mode "Log-Edit/git"
       (require 'git-commit-mode)
       (setq font-lock-defaults '(git-commit-mode-font-lock-keywords t))
       (set (make-local-variable 'font-lock-multiline) t)
       (git-commit-font-lock-diff)
       ;; Filling according to the guidelines
       (setq fill-column 72)
       (turn-on-auto-fill)
       ;; Recognize changelog-style paragraphs
       (set (make-local-variable 'paragraph-start)
            (concat paragraph-start "\\|*\\|("))
       ;; Do not remember point location in commit messages
       (when (fboundp 'toggle-save-place)
         (toggle-save-place 0)))))

;; Magit and git quick open files for projects.
(defun my-magit-open-directory-and-file ()
  "Open quickly a magit directory and open a git file in there"
  (interactive)
  (let ((default-directory (magit-read-top-dir nil)))
    (find-file-in-git-repo)))
(global-set-key (read-kbd-macro "C-S-p") 'my-magit-open-directory-and-file)

(defun my-magit-open-repository ()
  "Open quickly a magit directory."
  (interactive)
  (dired (magit-read-top-dir nil)))
(global-set-key (read-kbd-macro "C-S-o") 'my-magit-open-repository)

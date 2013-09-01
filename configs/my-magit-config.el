;Magit
(Package 'magit
 (autoload 'magit-read-top-dir "magit" nil t)
 (global-set-key (read-kbd-macro "C-c g") 'magit-status)
 (define-key global-map (kbd "C-S-g") 'magit-grep))
 )

; Make vc-git commit mode have the fancy stuff from git-commit
; mode. there is prob a better way to do that.
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

(defun my-magit-status-mode-hook()
  (local-set-key (read-kbd-macro "C-^")
                 (lambda()
                   (interactive)
                   (magit-show-commit
                    (magit-git-output
                     '("log" "--no-merges" "-n1" "--pretty=format:%h"))))))
(add-hook 'magit-status-mode-hook 'my-magit-status-mode-hook)

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
(global-set-key (read-kbd-macro "C-S-o") 'my-magit-open-repository)

;Find find in GIT repo
(Package 'magit-find-file
  (global-set-key (read-kbd-macro "C-`") 'magit-find-file-completing-read)
  (global-set-key (kbd "C-S-f") 'magit-find-file-completing-read))

; Adapted from anything-git-goto for helm (i.e: sed)
(require 'helm)
(require 'vc-git)

;;; --------------------------------------------------------------------
;;; - Customization
;;;
(defvar *helm-git-goto-buffer-name*
  "*Helm git-goto*")

(defvar git-goto-cmd
  "cd %s && git       \
  --no-pager ls-files \
  -cmo                \
  --exclude-standard  \
  --directory")

(defun helm-git-goto-find-git-repo (dir)
  "Recursively search for a .git/ directory."
  (if (string= "/" dir)
      nil ;; not in a git repo
    (if (file-exists-p (expand-file-name ".git/" dir))
        dir
      (helm-git-goto-find-git-repo (expand-file-name "../" dir)))))

(defun helm-git-goto-file  (file-content)
  "Visit the source for the file result."
  (setq full-file-path
           (expand-file-name file-content
                             (expand-file-name
                              (helm-git-goto-find-git-repo file-content)
                              (helm-attr 'pwd))))
  (if (file-exists-p full-file-path)
      (find-file full-file-path))
  (kill-buffer *helm-git-goto-buffer-name*))

(defvar helm-c-source-git-goto
  '((name . "Git goto")
    (init . (lambda ()
              (let ((git-root
                     (helm-git-goto-find-git-repo  default-directory)))
                (and git-root
                    (call-process-shell-command
                     (format git-goto-cmd
                             (helm-git-goto-find-git-repo  default-directory))
                     nil (helm-candidate-buffer 'global))))))
    (candidate-number-limit . 9999)
    (candidates-in-buffer)
    (action . helm-git-goto-file))
  "Git goto.")

;;;###autoload
(defun helm-git-goto ()
  "Git Find files."
  (interactive)
  (if (helm-git-goto-find-git-repo  default-directory)
      (helm-other-buffer
       '(helm-c-source-git-goto) *helm-git-goto-buffer-name*)
    (message "Not in a git repo")))

(provide 'helm-git-goto)


;;; helm-git-goto.el ends here

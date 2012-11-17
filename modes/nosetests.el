;; Author: Chmouel Boudjnah <chmouel@chmouel.com>
;;
;; Provide two function to help with running nosetests. One
;; `nosetests-get-command` that would copy your yank ring the current
;; test to feed to nose on the shell and the other `nosetests-compile`
;; that would launch the current test with nose in a compile buffer.

(defvar nosetests-arg "-sx")

(defun inner-testable ()
  (save-excursion
    (re-search-backward
     "^ \\{0,4\\}\\(class\\|def\\)[ \t]+\\([a-zA-Z0-9_]+\\)" nil t)
    (buffer-substring-no-properties (match-beginning 2) (match-end 2))))

(defun outer-testable ()
  (save-excursion
    (re-search-backward
     "^\\(class\\|def\\)[ \t]+\\([a-zA-Z0-9_]+\\)" nil t)
    (let ((result
            (buffer-substring-no-properties (match-beginning 2) (match-end 2))))

      (cons
       (buffer-substring-no-properties (match-beginning 1) (match-end 1))
       result))))

(defun nose-py-testable ()
  (let* ((inner-obj (inner-testable))
         (outer (outer-testable))
         ;; elisp can't return multiple values
         (outer-def (car outer))
         (outer-obj (cdr outer)))
    (cond ((equal outer-def "def") outer-obj)
          ((equal inner-obj outer-obj) outer-obj)
          (t (format "%s.%s" outer-obj inner-obj)))))

(defun nosetests-get-command (&optional withcd)
  (let (topdir test-path current-function cmd)
    (setq topdir (file-truename (or (locate-dominating-file
                                     (buffer-file-name) "setup.py") "./")))
    (setq test-path (substring (file-truename
                                (buffer-file-name))
                               (length topdir)))
    (setq current-function (nose-py-testable))
    (if (not current-function)
        (error "No function at point"))

    (setq cmd "")
    (if withcd
        (setq cmd (concat "cd " topdir ";")))
    (concat cmd "nosetests "
            nosetests-arg " " test-path ":"
            current-function)))

(defun nosetests-compile ()
  (interactive)
  (let (cmd)
    (setq cmd (nosetests-get-command t))
    (compile cmd)))

(defun nosetests-copy-shell-comand ()
  (interactive)
  (let (cmd)
    (setq cmd (nosetests-get-command))
    (kill-new cmd)
    (message cmd)))

(provide 'nosetests)

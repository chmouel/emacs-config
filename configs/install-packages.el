;;; my-packages.el --- Package Initialization.
;; Copyright  Irfan Shah
;; Author: Irfan Shah
;; URL: http://github.com/irfn/my-packages
;; Version: 0.1.0

;; save my package names to file on install.  So
;; that i can bootstrap using the same config on a different machine.


(require 'package)

(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(defun read-lines (filePath)
  "Return a list of lines of a file at FILEPATH."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun my-packages ()
  (condition-case nil
      (read-lines "~/.emacs.d/packages.txt")
    (error nil)))

(defun my-packages-install ()
  (condition-case nil
      (dolist (p (my-packages))
        (when (not (package-installed-p (intern p)))
          (package-install (intern p))))
    (error nil)))

(my-packages-install)
(provide 'my-packages)

;;; my-packages.el ends here

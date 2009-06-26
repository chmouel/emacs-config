;(require 'python-mode nil t)
;;   (Work
;;    (setq ipython-command "/usr/bin/ipython")
 ;  (require 'ipython))

(if (file-exists-p "/usr/bin/pychecker")
  (setq python-check-command "/usr/bin/pychecker -e --stdlib"))

(if (file-exists-p "/usr/bin/pylint")
  (setq python-check-command "/usr/bin/pylint --output-format=parseable"))

(defun my-python-mode-hook()
  (set (make-local-variable 'my-compile-command) (concat python-check-command " \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat "python  \"" buffer-file-name "\""))
  (my-programming-common-hook)
  (highlight-parentheses-mode)
  (c-subword-mode)
  (eldoc-mode 1)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

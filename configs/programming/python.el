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

(define-abbrev-table 'python-mode-abbrev-table ())
  (snippet-with-abbrev-table 'python-mode-abbrev-table
                             ("pp"  .  "$>from pprint import pprint as p")
                             ("sy" . "$>sys.exit($${0})")
                             ("try"   . "$>try:\nexcept($${Exception}}):\n$>")
                             ("def"  .  "def $${function}():\n$>")
                             ("defs"  .  "def $${function}(self):\n$>")			   
                             ("cl"  .  "class $${class}(object):\n$>def __init__(self):\n$>")
                             ("ifm" . "if __name__ == \"__main__\":\n$>")
                             )

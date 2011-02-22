(if (file-exists-p "/usr/bin/pychecker")
  (setq python-check-command "/usr/bin/pychecker -e --stdlib"))

(if (file-exists-p "/usr/bin/pylint")
  (setq python-check-command "/usr/bin/pylint --output-format=parseable"))

(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
   (when (not (file-remote-p (buffer-file-name)))
      (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                         'flymake-create-temp-inplace)) 
             (local-file (file-relative-name 
                          temp-file 
                          (file-name-directory buffer-file-name)))) 
        (list "flake8" (list local-file)))))
  (push '("\\.py\\'" flymake-pyflakes-init) flymake-allowed-file-name-masks)) 

(defun my-python-mode-hook()
  (which-func-mode 't)
  (local-set-key '[(meta q)] 'python-fill-paragraph)
  (set (make-local-variable 'my-compile-command) (concat python-check-command " \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat python-command " \"" buffer-file-name "\""))
  (my-programming-common-hook)
  ;; (local-set-key '[(control meta p)] (lambda () (interactive) (progn (insert "self."))))
  (local-set-key '[(control shift return)] (lambda () (interactive) (compile (concat "pep8.py \"" buffer-file-name "\""))))
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

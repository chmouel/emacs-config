(setq python-command (executable-find "python"))

(dolist (x '("flake8" "pychecker" "pylint"))
  (if (executable-find x)
      (setq python-check-command (executable-find x)))
  )

(require 'nosetests)
(require 'flymake)
(defun flymake-pyflakes-init ()
  (when (not (file-remote-p (buffer-file-name)))
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "flake8" (list local-file)))))
(push '("\\.py\\'" flymake-pyflakes-init) flymake-allowed-file-name-masks)
(push '("bin/swift\\'" flymake-pyflakes-init) flymake-allowed-file-name-masks)

(defun my-python-mode-hook()
  (when "highlight-80+" (highlight-80+-mode))
  ;(when "highlight-indentation" (highlight-indentation))
  (flymake-mode 't)
  (local-set-key '[(control c)(\[)] 'flymake-goto-prev-error)
  (local-set-key '[(control c)(\])] 'flymake-goto-next-error)
  (local-set-key (kbd "C-S-t") 'nosetests-copy-shell-comand)
  (local-set-key (kbd "C-S-r") 'nosetests-compile)
  (which-func-mode 't)
  (local-set-key '[(meta q)] 'python-fill-paragraph)
  (set (make-local-variable 'my-compile-command) (concat python-check-command " \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat (executable-find python-command) " -E \"" buffer-file-name "\""))
  (my-programming-common-hook)
  (local-set-key '[(control meta p)] (lambda () (interactive) (progn (insert "self."))))
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

(Package 'fill-column-indicator)
(Package 'anaconda-mode)
(Package 'hungry-delete)

(autoload 'pan-switch-test-func "pan")
(autoload 'pan-run-all-until-fail "pan")
(autoload 'pan-run-current-test "pan")

(Package 'company-anaconda
  (eval-after-load 'company
    '(add-to-list 'company-backends 'company-anaconda)))

;; Ipython
(setq
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(defun my-python-mode-hook()
  ;;(py-yapf-enable-on-save)
  (fci-mode)
  (flycheck-mode)
  (anaconda-mode)
  (company-mode)
  (eldoc-mode)
  (hungry-delete-mode)

  (local-set-key '[(meta q)] 'fill-paragraph)

  (local-set-key (kbd "C-S-y") 'pan-run-all-until-fail)
                                        ;(local-set-key (read-kbd-macro "C-S-t") 'pan-choose-test-to-run)
  (local-set-key (read-kbd-macro "C-\\") 'pan-switch-test-func)
  (local-set-key (kbd "C-S-r") 'pan-run-current-test)
  (local-set-key (kbd "C-S-w") (lambda () (interactive) (kill-new (python-info-current-defun))))

  (local-set-key '[(control c)(\[)] 'flycheck-previous-error)
  (local-set-key '[(control c)(\])] 'flycheck-next-error)

  (set (make-local-variable 'my-compile-run-command) (concat "python -E \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-command) (concat "flake8 \"" buffer-file-name "\""))

  (my-programming-common-hook)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

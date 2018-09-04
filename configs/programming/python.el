(use-package fill-column-indicator)
(use-package anaconda-mode
  :diminish (anaconda-mode . "🐍")
  :init
  (setq anaconda-mode-installation-directory
        (locate-user-emacs-file "auto-save-list/anaconda-mode")))
(use-package hungry-delete :diminish hungry-delete-mode)

(autoload 'pan-switch-test-func "pan")
(autoload 'pan-run-all-until-fail "pan")
(autoload 'pan-run-current-test "pan")

(use-package company-anaconda
  :config
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
  (fci-mode)
  (flycheck-mode)
  (anaconda-mode)
  (company-mode)
  (eldoc-mode)
  (hungry-delete-mode)

  (local-set-key '[(meta q)] 'fill-paragraph)

  (local-set-key (kbd "C-S-y") 'pan-run-all-until-fail)
  (local-set-key (read-kbd-macro "C-\\") 'pan-switch-test-func)
  (local-set-key (kbd "C-S-r") 'pan-run-current-test)
  (local-set-key (kbd "C-S-w") (lambda () (interactive) (kill-new (python-info-current-defun))))

  (local-set-key '[(control c)(\[)] 'flycheck-previous-error)
  (local-set-key '[(control c)(\])] 'flycheck-next-error)

  (setq-local compile-command (concat python-shell-interpreter " -E \"" buffer-file-name "\""))
  (local-set-key '[(control return)] 'recompile)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

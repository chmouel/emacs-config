(Package 'outline-magic)
(Package 'fill-column-indicator)

;Ipython3
(setq

 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(defun my-python-mode-hook()
  (outline-minor-mode t)
  (fci-mode)
  (flycheck-mode)

  (define-key outline-minor-mode-map [M-down] 'outline-move-subtree-down)
  (define-key outline-minor-mode-map [M-up] 'outline-move-subtree-up)

  (local-set-key '[(meta q)] 'fill-paragraph)
  
  (local-set-key (kbd "C-S-y") 'tox-current-class)
  (local-set-key (kbd "C-S-t") 'nosetests-copy-shell-comand)
  (local-set-key (kbd "C-S-r") 'tox-current-test)
  (local-set-key (kbd "C-S-w") (lambda () (interactive) (kill-new (python-info-current-defun))))
  
  (local-set-key '[(control c)(control k)] 'outline-mark-subtree)
  
  (local-set-key '[(control c)(\[)] 'flycheck-previous-error)
  (local-set-key '[(control c)(\])] 'flycheck-next-error)
  
  (set (make-local-variable 'my-compile-run-command) (concat "python -E \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-command) (concat "flake8 \"" buffer-file-name "\""))
  
  (local-set-key '[(control meta p)] (lambda () (interactive) (progn (insert "self."))))
  
  (my-programming-common-hook)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

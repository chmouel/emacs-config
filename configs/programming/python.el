(require 'nosetests)
(require 'outline-magic)

;Ipython3
(setq
 python-shell-interpreter "ipython3"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(defun my-python-mode-hook()
  (set (make-local-variable 'my-compile-command) (concat "flake8 \"" buffer-file-name "\""))
  ;(flyspell-prog-mode)
  (outline-minor-mode t)
  (setq outline-regexp "[ \t]*# \\|[ \t]+\\(class\\|def\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|with\\) ")
  (setq outline-level 'py-outline-level)
  (define-key outline-minor-mode-map [M-down] 'outline-move-subtree-down)
  (define-key outline-minor-mode-map [M-up] 'outline-move-subtree-up)
  (when "highlight-80+" (highlight-80+-mode))
  (local-set-key '[(control c)(control k)] 'outline-mark-subtree)
  (local-set-key (kbd "C-S-y") 'nosetests-compile-module)
  (local-set-key (kbd "C-C C-f") 'github-browse-file)
  (local-set-key (kbd "C-S-t") 'nosetests-copy-shell-comand)
  (local-set-key (kbd "C-S-r") 'nosetests-compile)
  (local-set-key (kbd "C-S-w") (lambda () (interactive) (kill-new (python-info-current-defun))))
  (flycheck-mode)
  (local-set-key '[(control c)(\[)] 'flycheck-previous-error)
  (local-set-key '[(control c)(\])] 'flycheck-next-error)
  (local-set-key '[(meta q)] 'fill-paragraph)
  (set (make-local-variable 'my-compile-command) (concat python-check-command " \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat python-shell-interpreter " -E \"" buffer-file-name "\""))
  (my-programming-common-hook)
  (local-set-key '[(control meta p)] (lambda () (interactive) (progn (insert "self."))))
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

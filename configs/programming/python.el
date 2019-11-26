(use-package python-docstring :config (python-docstring-install))
(use-package fill-column-indicator)
(use-package anaconda-mode
  :init (setq anaconda-mode-installation-directory
              (locate-user-emacs-file "auto-save-list/anaconda-mode")))
;; (use-package hungry-delete :diminish hungry-delete-mode)
(use-package blacken)
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

;; Insert an import
(defun my-py-insert-import (arg import)
  (save-excursion
    (goto-char (point-min))
    (unless
        (re-search-forward
         (concat "^\\(import\\|from.*import\\) " import) nil t)
      (goto-char (point-min))
      (when (re-search-forward "^\\([^#]\\)" nil t)
        (beginning-of-line)
        (insert
         (concat
          "import " import
          (if arg (concat " as " (read-from-minibuffer "Import as: "))))
         "\n")))))

(defun my-py-import-add (arg import)
  (interactive
   (list
    current-prefix-arg
    (read-from-minibuffer "Package: " )))
  (my-py-insert-import arg import))

(reformatter-define yapf :program "yapf")
(defun my-python-mode-hook()
  (setq flycheck-python-flake8-executable python-shell-interpreter)
  (yapf-on-save-mode)
  (fci-mode)
  (flycheck-mode)
  (anaconda-mode)
  (company-mode)
  (eldoc-mode)
  (hungry-delete-mode)

  (local-set-key '[(meta q)] 'fill-paragraph)
  (local-set-key (kbd "C-'") 'toggle-quotes)

  (local-set-key '[(control c)(i)] 'my-py-import-add)
  (local-set-key '[(control c)(\[)] 'flycheck-previous-error)
  (local-set-key '[(control c)(\])] 'flycheck-next-error)

  (setq-local compile-command (concat python-shell-interpreter " -E \"" buffer-file-name "\""))
  (local-set-key '[(control return)] 'my-recompile))
(add-hook 'python-mode-hook 'my-python-mode-hook)

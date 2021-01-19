;; (use-package python-docstring :config (python-docstring-install))
(use-package fill-column-indicator :ensure t)
(use-package py-isort :ensure t)
(use-package python-docstring :ensure t)
(use-package pytest :ensure t)
(use-package yapfify :ensure t)
(use-package hungry-delete :ensure t)

(defun my-py-insert-import (arg import)
  (save-excursion
    (goto-char (point-min))
    (while (or (python-info-current-line-comment-p)
               (python-info-docstring-p))
      (forward-line))
    (insert
     (concat
      "import " import
      (if arg (concat " as " (read-from-minibuffer "Import as: "))))
     "\n")))

(defun my-py-import-add (arg import)
  (interactive
   (list
    current-prefix-arg
    (read-from-minibuffer "Package: " )))
  (my-py-insert-import arg import)
  (py-isort-buffer))

(defun my-python-mode-hook()
  (setq flycheck-python-flake8-executable python-shell-interpreter)
  (yapf-mode)
  (fci-mode)
  (hungry-delete-mode)
  (python-docstring-mode)
  ;; (anaconda-mode)
  ;; (anaconda-eldoc-mode)
  ;; (company-mode-on)
  (highlight-indentation-mode)
  (local-set-key '[(meta q)] 'fill-paragraph)
  (local-set-key (kbd "C-'") 'toggle-quotes)
  (local-set-key (kbd "C-c t") 'ff-find-other-file)
  (if (and buffer-file-name
           (string-match "\\(^test_\\|_test$\\)"
                         (file-name-base (file-name-sans-extension buffer-file-name))))
      (progn
        (local-set-key '[(control return)] 'pytest-one)
        (local-set-key (kbd "C-S-r") 'pytest-one))
    (local-set-key '[(control return)] 'my-recompile))

  (local-set-key '[(meta return)] 'compile)
  (local-set-key '[(control c)(i)] 'my-py-import-add)
  (local-set-key '[(control c)(\[)] 'flycheck-previous-error)
  (local-set-key '[(control c)(\])] 'flycheck-next-error)
  (flycheck-mode)
  (lsp-deferred)
  (setq-local compile-command (concat python-shell-interpreter " -E \"" buffer-file-name "\"")))

(add-hook 'python-mode-hook 'my-python-mode-hook)

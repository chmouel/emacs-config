;; (use-package python-docstring :config (python-docstring-install))
(use-package fill-column-indicator
  :diminish
  :after python-mode)
(use-package py-isort :ensure t
  :diminish
  :after python-mode)
(use-package python-docstring :ensure t
  :diminish
  :after python-mode)
(use-package pytest :ensure t
  :after python-mode)
(use-package yapfify
  :ensure t
  :diminish
  :config
  (diminish 'yapf-mode)
  :after python-mode)
(use-package hungry-delete :ensure t
  :diminish
  :after python-mode)

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

(use-package python
  :custom
  (flycheck-python-flake8-executable "python3")
  :bind (:map python-mode-map
              ("C-'" . toggle-quotes)
              ("C-c t" . ff-find-other-file)
              ("M-q" . fill-paragraph)
              ("M-<return>" . compile)
              ("C-c i" . my-py-import-add)
              ("C-c \[" . flycheck-previous-error)
              ("C-c \]" . flycheck-next-error))
  :hook ((python-mode . yapf-mode)
         (python-mode . lsp-deferred)
         (python-mode . flycheck-mode)
         (python-mode . highlight-indentation-mode)
         (python-mode . highlight-indentation-mode)
         (python-mode . my-python-mode-hook)))

(defun my-python-mode-hook()
  (if (and
       buffer-file-name
       (string-match
        "\\(^test_\\|_test$\\)"
        (file-name-base (file-name-sans-extension buffer-file-name))))
      (progn
        (local-set-key '[(control return)] 'pytest-one)
        (local-set-key (kbd "C-S-r") 'pytest-one))
    (local-set-key '[(control return)] 'my-recompile))
  (setq-local
   compile-command
   (concat python-shell-interpreter " -E \"" buffer-file-name "\"")))

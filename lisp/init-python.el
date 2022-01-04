(use-package lsp-pyright
  :custom
  (lsp-pyright-typechecking-mode "off")
  :ensure t)

(use-package py-isort
  :diminish
  :after python-mode)

(use-package python-docstring
  :diminish
  :after python-mode)

(use-package pytest 
  :after python-mode)

(use-package yapfify
  :after python-mode)

(use-package hungry-delete
  :diminish
  :after python-mode)

(use-package python
  :custom
  (python-shell-interpreter "python3")
  (flycheck-python-flake8-executable "python3")
  :bind (:map python-mode-map
              ("C-c t" . ff-find-other-file)
              ("M-q" . fill-paragraph)
              ("M-<return>" . multi-compile-run)
              ("C-c i" . my-py-import-add)
              ("C-c \[" . flycheck-previous-error)
              ("C-c \]" . flycheck-next-error))
  :config
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
    (require 'lsp-pyright)
    (lsp)
    (flycheck-add-next-checker 'lsp '(warning . python-pylint))
    (if (and
	     buffer-file-name
	     (string-match
          "\\(^test_\\|_test$\\)"
          (file-name-base (file-name-sans-extension buffer-file-name))))
	    (progn
          (local-set-key '[(control return)] 'my-recompile)
          (local-set-key (kbd "C-S-r") 'pytest-one))))
  
  (add-to-list 'multi-compile-alist '(python-mode . (("pyhon-run" . "python3 -E %path"))))
  
  :hook ((python-mode . yapf-mode)
	     (python-mode . flycheck-mode)
	     (python-mode . hungry-delete-mode)
	     (python-mode . highlight-indentation-mode)
	     (python-mode . my-python-mode-hook)))


(provide 'init-python)

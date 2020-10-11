(use-package python-docstring :config (python-docstring-install))
(use-package fill-column-indicator)
(use-package py-isort)
(use-package anaconda-mode
  :init (setq anaconda-mode-installation-directory
              (locate-user-emacs-file "auto-save-list/anaconda-mode")))
;; (use-package hungry-delete :diminish hungry-delete-mode)
(use-package blacken)

(use-package company-anaconda
  :ensure t
  :init (require 'rx)
  :after (company)
  :config
  (add-to-list 'company-backends 'company-anaconda))

(use-package company-quickhelp
  :ensure t
  :config
  (company-quickhelp-mode))

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
  (my-py-insert-import arg import)
  (py-isort-buffer))

(defun my-python-mode-hook()
  (setq flycheck-python-flake8-executable python-shell-interpreter)
  (yapf-mode)
  (fci-mode)
  (flycheck-mode)
  (hungry-delete-mode)
  (anaconda-mode)
  (anaconda-eldoc-mode)
  (company-mode-on)
  (local-set-key '[(meta q)] 'fill-paragraph)
  (local-set-key (kbd "C-'") 'toggle-quotes)

  (local-set-key (kbd "s-t") 'ff-find-other-file)
  (if (and buffer-file-name
           (string-match "^test_"
                         (file-name-base (file-name-sans-extension buffer-file-name))))
      (progn
        (local-set-key '[(control return)] 'pytest-one)
        (local-set-key (kbd "C-S-r") 'pytest-one))
    (local-set-key '[(control return)] 'my-recompile))

  (local-set-key '[(meta return)] 'compile)
  (local-set-key '[(control c)(i)] 'my-py-import-add)
  (local-set-key '[(control c)(\[)] 'flycheck-previous-error)
  (local-set-key '[(control c)(\])] 'flycheck-next-error)

  (setq-local compile-command (concat python-shell-interpreter " -E \"" buffer-file-name "\"")))

(add-hook 'python-mode-hook 'my-python-mode-hook)

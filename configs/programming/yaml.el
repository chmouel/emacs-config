(use-package yaml-mode :ensure t
  :hook
  (yaml-mode . my-yaml-mode-hook)
  (yaml-mode . whitespace-mode)
  (yaml-mode . highlight-indentation-mode)
  (yaml-mode . my-programming-common-hook)
  (yaml-mode . lsp-deferred)
  :config
  (font-lock-add-keywords
   'yaml-mode
   '(("\\($(\\(workspaces\\|context\\|params\\)\.[^)]+)\\)" 1 'font-lock-constant-face prepend)
     ("kind:\s*\\(.*\\)\n" 1 'font-lock-keyword-face prepend)))
  :bind
  (:map yaml-mode-map
        ("C-<return>" . imenu-list-smart-toggle)
        ("C--" . (lambda () (interactive) (call-interactively 'highlight-indentation-current-column-mode)))
        ("C-=" . whitespace-cleanup)))


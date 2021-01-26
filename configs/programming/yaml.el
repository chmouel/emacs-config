(use-package yaml-mode :ensure t
  :hook
  (yaml-mode-hook . my-yaml-mode-hook)
  (yaml-mode-hook . whitespace-mode)
  (yaml-mode-hook . highlight-indentation-mode)
  (yaml-mode-hook . my-programming-common-hook)
  (yaml-mode-hook . lsp-deferred)
  :config
  (font-lock-add-keywords
   'yaml-mode
   '(("\\($(\\(workspaces\\|context\\|params\\)\.[^)]+)\\)" 1 'font-lock-constant-face prepend)
     ("kind:\s*\\(.*\\)\n" 1 'font-lock-keyword-face prepend)))
  :bind
  (:map yaml-mode-map
        ("C-<ret>" . imenu-list-smart-toggle)
        ("C--" . (lambda () (interactive) (call-interactively 'highlight-indentation-current-column-mode)))
        ("C-=" . whitespace-cleanup)))


(use-package yaml-mode :ensure t
  :hook
  (yaml-mode . format-all-mode)
  (yaml-mode . highlight-indentation-mode)
  (yaml-mode . electric-pair-local-mode)
  (yaml-mode . highlight-indentation-mode)
  :config
  (font-lock-add-keywords
   'yaml-mode
   '(("\\($(\\(workspaces\\|context\\|params\\)\.[^)]+)\\)" 1 'font-lock-constant-face prepend)
     ("kind:\s*\\(.*\\)\n" 1 'font-lock-keyword-face prepend)))
  :bind
  (:map yaml-mode-map
        ("C-<return>" . imenu-list-smart-toggle)
        ("C--" . (lambda () (interactive) (call-interactively 'highlight-indentation-current-column-mode)))
        ("C-S-f" . format-all-buffer)
        ("C-=" . whitespace-cleanup)))


(provide 'init-yaml)

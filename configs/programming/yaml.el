(use-package yaml-mode :ensure t
  :hook
  (yaml-mode-hook . my-yaml-mode-hookx)
  :config
  (font-lock-add-keywords
   'yaml-mode
   '(("\\($(\\(workspaces\\|context\\|params\\)\.[^)]+)\\)" 1 'font-lock-constant-face prepend)
     ("kind:\s*\\(.*\\)\n" 1 'font-lock-keyword-face prepend)))
  (defun my-yaml-mode-hook ()
    (local-set-key '[(control ret)] 'imenu-list-smart-toggle)
    (local-set-key '[(control =)] 'whitespace-cleanup)
    (local-set-key '[(control -)] (lambda () (interactive) (call-interactively 'highlight-indentation-current-column-mode)))
    (lsp-deferred)
    (whitespace-mode)
    (highlight-indentation-mode)
    (my-programming-common-hook))
  )

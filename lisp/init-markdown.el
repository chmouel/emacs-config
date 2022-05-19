(use-package markdown-mode
  :hook
  (markdown-mode . abbrev-mode)
  (markdown-mode . smartparens-mode))

(use-package poly-markdown :after markdown-mode)

(provide 'init-markdown)

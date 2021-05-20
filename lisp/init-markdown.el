(use-package markdown-mode
  :hook
  (markdown-mode . smartparens-mode)
  (before-save . (lambda ()
                   (interactive)
                   (when (or (derived-mode-p 'markdown-mode))
                     (delete-trailing-whitespace)))))

(use-package poly-markdown :after markdown-mode)

(provide 'init-markdown)

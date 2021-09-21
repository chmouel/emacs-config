(use-package make-mode
  :bind
  (:map makefile-mode-map
        ("C-=" . whitespace-cleanup))
  :hook
  (makefile-mode . indent-tabs-mode)
  (makefile-mode . my-makefile-mode-hook))

(provide 'init-makefile)

(use-package make-mode
  :bind
  (:map makefile-mode-map
        ("C-=" . whitespace-cleanup))
  :hook
  (makefile-mode . my-makefile-mode-hook)
  (makefile-mode . my-programming-common-hook)
  (makefile-mode . whitespace-mode))

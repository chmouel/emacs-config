(use-package jsfmt)

(use-package js2-mode
  :hook
  (js2-mode . lsp)
  :mode "\\.js\\'"
  :ensure t
  :config
  (setq js2-basic-offset 4))

(provide 'init-javascript)

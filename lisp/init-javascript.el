(use-package jsfmt)

(use-package js2-mode
  :hook
  (js2-mode . lsp)
  (js2-mode . format-all-mode)
  (js2-mode . format-all-ensure-formatter)
  :mode "\\.js\\'"
  :ensure t
  :config
  (setq js2-basic-offset 2))

(provide 'init-javascript)

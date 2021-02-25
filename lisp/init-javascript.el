(use-package jsfmt)

(use-package js2-mode
  :mode "\\.js\\'"
  :ensure t
  :custom
  (js2-basic-offset 2))

(provide 'init-javascript)

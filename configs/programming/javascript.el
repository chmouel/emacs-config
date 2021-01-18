(use-package jsfmt   :ensure t)

(use-package js2-mode
  :mode "\\.js\\'"
  :ensure t
  :config
  (add-hook 'js-mode-hook 'my-js-mode-hook)
  (add-hook 'js2-mode-hook 'my-js-mode-hook)
  (setq js2-basic-offset 2))

(defun my-js-mode-hook()
  (auto-complete-mode)
  (my-programming-common-hook))

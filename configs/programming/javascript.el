(defun my-js-mode-hook()
  (auto-complete-mode)
  (my-programming-common-hook))
(use-package jsfmt)

(use-package jsx-mode
  :mode "\\.jsx\\'"
  :commands (jsx-mode))

(use-package js2-mode :mode "\\.js\\'"
  :config
  (add-hook 'js-mode-hook 'my-js-mode-hook)
  (add-hook 'js2-mode-hook 'my-js-mode-hook)
  (setq js2-basic-offset 2))

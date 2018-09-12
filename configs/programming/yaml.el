(defun my-yaml-mode-hook ()
  (local-set-key
   '[(control =)]
   (lambda () (interactive) (call-interactively 'highlight-indentation-current-column-mode)))
  (my-programming-common-hook))
(add-hook 'yaml-mode-hook 'my-yaml-mode-hook)

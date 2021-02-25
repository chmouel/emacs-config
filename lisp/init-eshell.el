(use-package eshell
  :custom
  (eshell-directory-name (locate-user-emacs-file "auto-save-list/eshell/")))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

(use-package eshell-toggle
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command "ls")
  (eshell-toggle-init-function #'eshell-toggle-init-eshell)
  :bind
  ("C-`" . eshell-toggle))

(provide 'init-eshell)

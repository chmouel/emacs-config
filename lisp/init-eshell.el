(use-package eshell
  :defer t
  :custom
  (eshell-directory-name (locate-user-emacs-file "auto-save-list/eshell/")))

(use-package esh-autosuggest
  :after eshell
  :hook (eshell-mode . esh-autosuggest-mode))

(use-package eshell-toggle
  :defer t
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-run-command "ls")
  (eshell-toggle-init-function #'eshell-toggle-init-eshell)
  :bind
  ("C-`" . eshell-toggle))

(use-package esh-module
  :defer t
  :ensure nil
  :custom
  (eshell-modules-list
   '(eshell-alias
     eshell-banner
     eshell-basic
     eshell-cmpl
     eshell-dirs
     eshell-glob
     eshell-hist
     eshell-ls
     eshell-pred
     eshell-prompt
     eshell-script
     ;; eshell-smart
     eshell-term
     eshell-unix
     )))


(use-package eshell-syntax-highlighting
  :defer t
  :ensure t
  :hook (eshell-mode . eshell-syntax-highlighting-mode))

(provide 'init-eshell)

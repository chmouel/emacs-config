(use-package eshell
  :defer t
  :custom
  (eshell-directory-name (locate-user-emacs-file "auto-save-list/eshell/")))

(use-package eshell-toggle
  :disabled
  :defer t
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-run-command "ls")
  (eshell-toggle-init-function #'eshell-toggle-init-eshell))

(use-package vterm-toggle
  :config
  (setq vterm-always-compile-module 't)
  (if (fboundp 'evil-ex-set-initial-state)
      (evil-set-initial-state 'vterm-mode 'emacs))
  :bind
  ("C-c RET" . vterm-toggle))

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

;Eldoc-Mode
(Package 'smartparens
  (set-face-attribute 'sp-pair-overlay-face nil
                      :background "steelblue3"
                      :foreground "white"
                      :box nil)  )

(defun my-emacs-lisp-mode-hook ()
  (smartparens-mode)
  (company-mode)
  (local-set-key (read-kbd-macro "C-x C-e") 'eval-buffer)
  (eldoc-mode t)
  (my-programming-common-hook)
  )
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

;Eldoc-Mode
(defun my-emacs-lisp-mode-hook ()
  (company-mode)
  (local-set-key (read-kbd-macro "C-x C-e") 'eval-buffer)
  (eldoc-mode t)
  (my-programming-common-hook)
  )
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

;Eldoc-Mode

(defun my-emacs-lisp-mode-hook ()
  (eldoc-mode t)
  (my-programming-common-hook)
  )
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

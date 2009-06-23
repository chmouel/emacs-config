;Eldoc-Mode

(defun my-emacs-lisp-mode-hook ()
  (eldoc-mode t)
  (highlight-parentheses-mode)
  )
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

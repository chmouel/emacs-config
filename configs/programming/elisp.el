;Eldoc-Mode

(defun my-emacs-lisp-mode-hook ()
  (auto-complete-mode-maybe)
  (local-set-key (read-kbd-macro "C-x C-e") 'eval-buffer)
  (eldoc-mode t)
  (my-programming-common-hook)
  )
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

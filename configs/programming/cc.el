(setq my-c++-compiler-program "c++")


(defun my-c++-mode-hook()
  (set (make-local-variable 'my-compile-command) "make")
  (my-programming-common-hook)
  (c-subword-mode)
  (c-toggle-auto-newline)
  (c-set-style "cc-mode")
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

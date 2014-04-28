(setq my-c++-compiler-program "c++")

(defun my-c++-mode-hook()
  (set (make-local-variable 'my-compile-command) (concat "make " (file-name-sans-extension (buffer-file-name))))
  (set (make-local-variable 'my-compile-run-command) (concat my-compile-command ";" (file-name-sans-extension (buffer-file-name))))

  (my-programming-common-hook)
  (c-toggle-auto-newline)
  (c-set-style "cc-mode")
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c++-mode-hook)

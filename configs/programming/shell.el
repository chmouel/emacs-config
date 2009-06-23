(defun my-sh-mode-hook()
  (set (make-local-variable 'my-compile-command) (concat "bash -n \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat "bash \"" buffer-file-name "\""))
  
  (my-programming-common-hook)

  )
(add-hook 'sh-mode-hook 'my-sh-mode-hook)

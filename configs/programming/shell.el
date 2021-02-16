(use-package sh-script
  :hook
  (sh-mode . my-programming-common-hook)
  (sh-mode . my-sh-mode-hook)
  :config
  (defun my-sh-mode-hook()
    (set (make-local-variable 'my-compile-command) (concat "bash -n \"" buffer-file-name "\""))
    (set (make-local-variable 'my-compile-run-command) (concat "bash \"" buffer-file-name "\""))))

(add-hook 'sh-mode-hook 'my-sh-mode-hook)

(eval-after-load "go-mode"
  '(require 'flymake-go))

(defun my-go-mode-hook ()
  (set (make-local-variable 'my-compile-command) (concat "go test \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat "go run \"" buffer-file-name "\""))
  (my-programming-common-hook)
  )


(add-hook 'go-mode-hook 'my-go-mode-hook)

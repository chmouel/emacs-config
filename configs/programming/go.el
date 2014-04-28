(defun my-go-mode-hook ()
  (local-set-key (kbd "C-c i") 'go-goto-imports)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)

  (set (make-local-variable 'my-compile-command) (concat "go test \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat "go run \"" buffer-file-name "\""))
  (my-programming-common-hook)
  )


(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'my-go-mode-hook)

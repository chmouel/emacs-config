(setq my-c++-compiler-program "c++")

(defun my-gcc-command()
  (interactive)
  (concat ("gcc -o /tmp/" (file-name-nondirectory (buffer-file-name)) (buffer-file-name))))


(defun my-c++-mode-hook()
  (set (make-local-variable 'my-compile-command) "make")
  (set (make-local-variable 'my-compile-run-command) 'my-gcc-command)
  (my-programming-common-hook)
  (c-toggle-auto-newline)
  (c-set-style "cc-mode")
  (yas/minor-mode 't)
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c++-mode-hook)

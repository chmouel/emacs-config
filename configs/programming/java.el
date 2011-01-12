(setq my-java-compiler-command "javac")
(setq my-java-command "java")

(defun my-java-mode-hook()
  (c-toggle-auto-newline 't)
  (c-toggle-hungry-state 't)
  (subword-mode 1)
  (set (make-local-variable 'my-compile-command) 'my-compile-run-command)
  (set (make-local-variable 'my-compile-run-command) (concat "\"" my-java-compiler-command "\" \"" buffer-file-name "\" && " "\"" my-java-command "\" \"" (file-name-sans-extension (file-name-nondirectory (buffer-file-name))) "\""))
  (my-programming-common-hook)
  )
(add-hook 'java-mode-hook 'my-java-mode-hook)

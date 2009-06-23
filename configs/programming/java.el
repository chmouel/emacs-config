(setq my-java-compiler-command "javac")
(setq my-java-command "java")
(if (file-executable-p (expand-file-name "c:/Program Files/Java/jdk1.6.0_03/bin/javac.exe"))
    (setq my-java-compiler-command (expand-file-name "c:/Program Files/Java/jdk1.6.0_03/bin/javac.exe"))
  )


(defun my-java-mode-hook()
  (set (make-local-variable 'my-compile-command) (concat "\"" my-java-compiler-command "\" \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat "\"" my-java-command "\" \"" buffer-file-name "\""))
  (my-programming-common-hook)
  (c-subword-mode)
  )
(add-hook 'java-mode-hook 'my-java-mode-hook)

(define-abbrev-table 'python-mode-abbrev-table ())

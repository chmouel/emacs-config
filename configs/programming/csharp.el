(defun my-csharp-mode-hook ()
  (or (file-exists-p "makefile") (file-exists-p "Makefile")
      (set (make-local-variable 'compile-command)
	   (concat "mcs /nologo /target:exe \"" buffer-file-name "\"")
	   ))
  (set (make-local-variable 'compile-run-command) 'compile-command)

  (my-programming-common-hook)

  (local-set-key '[(f9)]
		 (lambda () (interactive)
		   (compile compile-command)
		   (sleep-for 2)
		   (eshell-command
		    (concat "./" (file-name-nondirectory(file-name-sans-extension(buffer-file-name))) ".exe"))
		   ))

  (local-set-key '[(control p)] (lambda () (interactive) (progn (insert "System.Console.WriteLine(  );")(backward-char 3))))
  (c-toggle-auto-state 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda () (not (eq (get-text-property (point) 'face) 'font-lock-comment-face))))

  (define-abbrev-table 'csharp-mode-abbrev-table ())
  )

;Csharp
(use-package csharp-mode
  :commands (csharp-mode)
  :mode "\\.cs\\'"
  :config
  (add-hook 'csharp-mode-hook 'my-csharp-mode-hook))

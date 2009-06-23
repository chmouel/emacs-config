(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)

(when (fboundp 'ruby-mode)
  (setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
  (autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
  (autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

  (defun my-ruby-mode-hook()
    (inf-ruby-keys)
    (set (make-local-variable 'my-compile-command)
         (concat "ruby -c \"" buffer-file-name "\"")
         )
    (or (file-exists-p "makefile") (file-exists-p "Makefile")
        (set (make-local-variable 'my-compile-run-command)
             (concat "ruby \"" buffer-file-name "\"")
             ))

    (local-set-key '[(control meta b)] 'bookmark-jump)
    (local-set-key '[(return)] 'ruby-reindent-then-newline-and-indent)  

    (my-programming-common-hook)

    )
  (add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

  (setq 
   ruby-program-name "irb --inf-ruby-mode --simple-prompt"
   interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist)
   inferior-ruby-first-prompt-pattern ">> "
   inferior-ruby-prompt-pattern ">> "
   )
)

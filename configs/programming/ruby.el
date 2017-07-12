(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)

(defun my-ruby-mode-hook()
  (inf-ruby-keys)
  (set (make-local-variable 'my-compile-command)
       (concat "ruby -c \"" buffer-file-name "\""))
  (or (file-exists-p "makefile") (file-exists-p "Makefile")
      (set (make-local-variable 'my-compile-run-command)
           (concat "ruby \"" buffer-file-name "\"")))
  (local-set-key '[(control meta b)] 'bookmark-jump)
  (my-programming-common-hook))

(setq ruby-program-name "irb --inf-ruby-mode --simple-prompt"
      interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist)
      inferior-ruby-first-prompt-pattern ">> "
      inferior-ruby-prompt-pattern ">> " )

(use-package ruby-mode
  :config
  (setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
  (add-hook 'ruby-mode-hook 'my-ruby-mode-hook)
  (use-package inf-ruby
    :commands (run-ruby inf-ruby-keys)))

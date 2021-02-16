(use-package inf-ruby
  :hook
  (ruby-mode . inf-ruby-keys)
  :after ruby-mode
  :commands (run-ruby inf-ruby-keys))

(use-package ruby-mode
  :mode "\\.rb\\'"
  :interpreter "ruby"  
  :custom
  (ruby-program-name "irb --inf-ruby-mode --simple-prompt")
  (interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))
  (inferior-ruby-first-prompt-pattern ">> ")
  (inferior-ruby-prompt-pattern ">> ")  
  :hook
  (ruby-mode . my-ruby-mode-hook)
  (ruby-mode . my-programming-common-hook)
  :bind
  (:map ruby-mode-map ("C-M-b" . bookmark-jump))
  :config
  (defun my-ruby-mode-hook()
    (set (make-local-variable 'my-compile-command)
         (concat "ruby -c \"" buffer-file-name "\""))
    (or (file-exists-p "makefile") (file-exists-p "Makefile")
        (set (make-local-variable 'my-compile-run-command)
             (concat "ruby \"" buffer-file-name "\"")))))

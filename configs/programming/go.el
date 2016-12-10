(Package 'go-playground
  (setq go-playground-ask-for-file-name t)
  (setq go-playground-basedir "~/tmp/goplay"))

(defun my-go-mode-hook ()
  (local-set-key (kbd "C-c i") 'go-goto-imports)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (local-set-key (kbd "C-c d") 'godoc-at-point)
  (local-set-key (kbd "C-S-r") 'go-test-current-test)

  (add-to-list 'company-backends 'company-go)
  (company-mode)

  (Package 'go-eldoc
    (go-eldoc-setup))

  (Package 'go-guru
    (go-guru-hl-identifier-mode))

  (set (make-local-variable 'flycheck-disabled-checkers) '(go-golint))

  (local-set-key (kbd "M-.") 'godef-jump)

  (set (make-local-variable 'my-compile-command) (concat "go test -v"))
  (set (make-local-variable 'my-compile-run-command) (concat "go run *.go"))
  (my-programming-common-hook))

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'my-go-mode-hook)

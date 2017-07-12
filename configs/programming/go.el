(Package 'go-playground
  (setq go-playground-ask-file-name t)
  (setq go-playground-basedir "~/tmp/goplay"))

(defun my-go-mode-hook ()
  (autoload 'go-test--get-current-test-info "gotest" "" nil)

  (local-set-key (kbd "C-c i") 'go-goto-imports)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (local-set-key (kbd "C-c d") 'godoc-at-point)
  (local-set-key (kbd "C-S-w") (lambda () (interactive) (kill-new (go-test--get-current-test))))
  (local-set-key (kbd "s-t") 'ff-find-other-file)
  (if (and buffer-file-name (string-match "_test\\'" (file-name-sans-extension buffer-file-name)))
      (local-set-key (kbd "C-S-r") '(lambda ()(interactive)(compile (concat "go test -run " (cadr (go-test--get-current-test-info)) "$")))))
  (add-to-list 'company-backends 'company-go)

  (company-mode)

  (Package 'go-eldoc
    (go-eldoc-setup))

  (Package 'go-guru
    (go-guru-hl-identifier-mode))

  (set (make-local-variable 'flycheck-disabled-checkers) '(go-golint))

  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key '[(control return)] 'recompile)
  (my-programming-common-hook)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'my-go-mode-hook)

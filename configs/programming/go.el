(use-package gotest
  :custom
  ((go-test-verbose t)))

(use-package go-playground
  :init
  (setq go-playground-ask-file-name t)
  (setq go-playground-basedir "~/tmp/goplay"))

(defun my-go-mode-hook ()
  ;; (setq gofmt-command "goimports")
  (local-set-key (kbd "C-c a")
                 (lambda ()
                   (interactive)
                   (go-import-add nil (read-from-minibuffer "Import: "))))
  (local-set-key (kbd "C-M-<up>")
                 (lambda ()
                   (interactive)
                   (re-search-backward go-func-regexp nil t)))
  (local-set-key (kbd "C-M-<down>")
                 (lambda ()
                   (interactive)
                   (re-search-forward go-func-regexp nil t)))

  (local-set-key (kbd "C-S-w")
                 (lambda ()
                   (interactive)
                   (kill-new (go-test--get-current-test))))
  (when (and
         buffer-file-name
         (string-match "_test\\'" (file-name-sans-extension buffer-file-name)))
    (local-set-key (kbd "C-S-a") 'go-test-current-project)
    (local-set-key (kbd "C-S-y") 'go-test-current-file)
    (local-set-key (kbd "C-S-r") 'go-test-current-test))

  (local-set-key (kbd "C-c i") 'go-goto-imports)
  (local-set-key (kbd "C-c d") 'godoc-at-point)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (local-set-key (kbd "s-t") 'ff-find-other-file)
  (my-programming-common-hook)
  (subword-mode)
  (local-set-key (kbd "s-.")  'lsp-describe-thing-at-point)
  (local-set-key (kbd "s-?")  'lsp-ivy-workspace-symbol)

  (lsp-deferred)

  ;; (local-set-key (kbd "M-.") 'godef-jump)
  ;; (add-to-list 'company-backends 'company-go)
  ;; (company-mode)
  )


(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'before-save-hook 'gofmt-before-save)

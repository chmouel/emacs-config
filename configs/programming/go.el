(use-package go-playground
  :init
  (setq go-playground-ask-file-name t)
  (setq go-playground-basedir "~/tmp/goplay"))

(defun my-go-import-add ()
  (interactive)
  (go-import-add nil (read-from-minibuffer "Import: ")))

(defun my-go-next-function()
  (interactive)
  (re-search-forward go-func-regexp nil t)
  )

(defun my-go-prev-function()
  (interactive)
  (re-search-backward go-func-regexp nil t)
  )

(defun my-go-mode-hook ()
  (autoload 'go-test--get-current-test-info "gotest" "" nil)
  (setq gofmt-command "goimports")

  (local-set-key (kbd "C-c a") 'my-go-import-add)
  (local-set-key (kbd "C-c i") 'go-goto-imports)
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  (local-set-key (kbd "C-M-<up>") 'my-go-prev-function)
  (local-set-key (kbd "C-M-<down>") 'my-go-next-function)
  (local-set-key (kbd "C-c d") 'godoc-at-point)
  (local-set-key (kbd "C-S-w") (lambda () (interactive) (kill-new (go-test--get-current-test))))
  (local-set-key (kbd "C-c t") 'ff-find-other-file)
  (if (and buffer-file-name
           (string-match "_test\\'"
                         (file-name-sans-extension buffer-file-name)))
      (progn
        (local-set-key (kbd "C-S-a") 'go-test-current-project)
        (local-set-key (kbd "C-S-y") 'go-test-current-file)
        (local-set-key (kbd "C-S-r") 'go-test-current-test)))

  (add-to-list 'company-backends 'company-go)
  (subword-mode)
  (company-mode)

  (local-set-key '[(control return)] 'my-recompile)
  (local-set-key '[(control meta return)] 'multi-compile-run)
  (my-programming-common-hook))

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'before-save-hook 'gofmt-before-save)

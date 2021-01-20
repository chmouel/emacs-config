(use-package go-playground
  :ensure t
  :after go-mode
  :init
  (setq go-playground-ask-file-name t)
  (setq go-playground-basedir "~/tmp/goplay"))

(use-package go-mode
  :ensure t
  :custom
  (gofmt-command "goimports")
  :bind (:map go-mode-map
              ("C-c a" . my-go-import-add)
              ("C-c i" . go-goto-imports)
              ("C-c C-r" . go-remove-unused-imports)
              ("C-M-<up>" . my-go-prev-function)
              ("C-M-<down>" . my-go-next-function)
              ("C-c d" . godoc-at-point)
              ("C-S-w" . (lambda () (interactive) (kill-new (go-test--get-current-test))))
              ("C-<return>" . my-recompile)
              ("C-M-<return>" . multi-compile-run)
              ("C-c t" . ff-find-other-file))
  :hook ((go-mode . lsp-deferred)
         (go-mode . subword-mode)
         (go-mode . my-go-mode-hook)
         (go-mode . my-programming-common-hook)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports))
  :config
  (defun my-go-import-add ()
    (interactive)
    (go-import-add nil (read-from-minibuffer "Import: ")))

  (defun my-go-next-function()
    (interactive)
    (re-search-forward go-func-regexp nil t))

  (defun my-go-prev-function()
    (interactive)
    (re-search-backward go-func-regexp nil t)))

(defun my-go-mode-hook ()
  (autoload 'go-test--get-current-test-info "gotest" "" nil)
  (setq gofmt-command "goimports")
  (if (and buffer-file-name
           (string-match "_test\\'"
                         (file-name-sans-extension buffer-file-name)))
      (progn
        (local-set-key (kbd "C-S-a") 'go-test-current-project)
        (local-set-key (kbd "C-S-y") 'go-test-current-file)
        (local-set-key (kbd "C-S-r") 'go-test-current-test))))


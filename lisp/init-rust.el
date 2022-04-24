(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("C-c r" . rustic-cargo-run))
  :custom
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (setq rustic-format-on-save t))

(use-package rust-playground
  :config
  (defun my-rust-playground-dir-name(fpath)
    (let ((base (file-name-nondirectory (directory-file-name fpath)))
          (snippet-name (read-string "Snippet Name: ")))
      (format "%s/%s-%s/" rust-playground-basedir snippet-name base )))
  (advice-add 'rust-playground-dir-name :filter-return #'my-rust-playground-dir-name)
  :init
  (setq rust-playground-basedir "~/Sync/rustplay"))


(provide 'init-rust)

(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("C-S-r". (lambda ()
                          (interactive)
                          (let ((test (concat rustic-default-test-arguments " "
                                              (substring-no-properties (cdr (rustic-cargo--get-current-fn-name))))))
                            (setq my-rustic-current-test-compile test)
                            (rustic-cargo-test-run test))))
              ("C-c C-a" . rustic-cargo-add)
              ("C-c r" . rustic-cargo-run))
  :custom
  (lsp-rust-analyzer-server-display-inlay-hints nil)
  (rustic-default-test-arguments "-q --benches --tests --all-features")
  (rustic-format-display-method 'ignore)  
  (rustic-lsp-format t)
  (rustic-format-on-save nil)  
  :config
  (defvar my-rustic-current-test-compile nil))

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

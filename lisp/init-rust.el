(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("C-S-r". (lambda ()
                          (interactive)
                          (let ((test (concat rustic-default-test-arguments " "
                                              (substring-no-properties (cdr (rustic-cargo--get-current-fn-name))))))
                            (setq my-rustic-current-test-compile test)
                            (rustic-cargo-test-run test))))
              ("C-c c a" . rustic-cargo-add)
              ("C-c c R" . lsp-workspace-restart)
              ("C-c c t" . lsp-rust-analyzer-open-cargo-toml)
              ("C-c c r" . rustic-cargo-run))
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
  (defun my-jump-rust-playground-snippet (snippet)
    (interactive
     (list
      (completing-read
       "Snippet: "
       (mapcar
        (lambda (x)
          (f-base x))
        (f-directories rust-playground-basedir)))))
    (find-file
     (concat
      rust-playground-basedir "/" snippet "/src/main.rs")))
  (defun my-rust-playground-dir-name(fpath)
    (let ((base (file-name-nondirectory (directory-file-name fpath)))
          (snippet-name (read-string "Snippet Name: ")))
      (format "%s/%s-%s/" rust-playground-basedir snippet-name base )))
  (advice-add 'rust-playground-dir-name :filter-return #'my-rust-playground-dir-name)
  :bind (:map rustic-mode-map
              ("C-c ," . my-jump-rust-playground-snippet))
  :init
  (setq rust-playground-basedir "~/Sync/rustplay"))

(provide 'init-rust)

(use-package gotest
  :config
  (autoload 'go-test--get-current-test-info "gotest" "" nil))

(use-package go-playground
  :after go-mode
  :bind (:map
         go-mode-map
         ("C-c ," . my-jump-go-playground-snippet))
  :config
  (defun my-jump-go-playground-snippet (snippet)
    (interactive
     (list
      (completing-read
       "Snippet: "
       (mapcar
        (lambda (x)
          (f-base x))
        (f-directories go-playground-basedir)))))
    (find-file
     (concat
      go-playground-basedir "/" snippet "/"
      (s-replace-regexp "-at.*" "" snippet) ".go")))
  :custom
  (go-playground-ask-file-name t)
  (go-playground-init-command "go mod init github.com/chmouel/%file-sans")
  (go-playground-basedir "~/tmp/goplay"))

(use-package go-mode
  :custom
  (gofmt-command "goimports")
  :hydra (hydra-golang (:timeout 10)
                       ""
                       ("a" my-go-import-add "Add Import")
                       ("pp" (lambda () (interactive) (go-import-add nil "github.com/kr/pretty")) "ImpPrety")
                       ("r" go-run "Run")
                       ("v" (lambda () (interactive) (compile "go mod vendor")) "vendor")
                       ("t" (lambda () (interactive) (compile "go mod tidy")) "tidy")
                       ("q" nil "quit"))
  :bind (:map go-mode-map
              ("s-." . hydra-golang/body)
              ("C-c a" . my-go-import-add)
              ("C-c i" . go-goto-imports)
              ("C-c C-r" . go-remove-unused-imports)
              ("C-M-<up>" . my-go-prev-function)
              ("C-M-<down>" . my-go-next-function)
              ("C-c d" . godoc-at-point)
              ("C-S-r" . go-run)
              ("C-M-<return>" . (lambda () (interactive) (compile "go mod vendor")(lsp-workspace-restart)))
              ("C-S-w" . (lambda () (interactive) (kill-new (go-test--get-current-test))))
              ("C-c t" . ff-find-other-file))
  :hook ((go-mode . lsp)
         (go-mode . subword-mode)
         (go-mode . (lambda ()
                      (interactive)
                      (require 'dap-go)(dap-go-setup)))
         (go-mode . my-go-mode-hook))
  :config
  (add-to-list 'multi-compile-alist '(go-mode . (("go-run" . "go run %path"))))

  (defun my-go-mode-hook ()
    (setq gofmt-command "goimports")
    (if (and buffer-file-name
             (string-match "_test\\'"
                           (file-name-sans-extension buffer-file-name)))
        (progn
          (local-set-key (kbd "C-S-a") 'go-test-current-project)
          (local-set-key (kbd "C-S-y") 'go-test-current-file)
          (local-set-key (kbd "C-S-r") 'go-test-current-test))))
  (defun my-go-import-add ()
    (interactive)
    (go-import-add nil (read-from-minibuffer "Import: ")))

  (defun my-go-next-function()
    (interactive)
    (re-search-forward go-func-regexp nil t))

  (defun my-go-prev-function()
    (interactive)
    (re-search-backward go-func-regexp nil t)))

(provide 'init-go)

(use-package lsp-mode
  :ensure t
  :diminish
  :commands (lsp lsp-deferred lsp-organize-imports)
  :custom
  (lsp-auto-guess-root t)
  (lsp-prefer-flymake nil)
  (lsp-document-highlight-delay 2.0 t)
  (lsp-session-file (locate-user-emacs-file "auto-save-list/lsp-session"))
  (lsp-eldoc-enable-hover nil)
  (lsp-eldoc-render-all nil)
  (lsp-enable-file-watchers nil)
  (lsp-pyls-plugins-flake8-enabled t)
  (lsp-pyls-plugins-flake8-max-line-length 200)
  (lsp-enable-symbol-highlighting nil)
  (lsp-enable-links t)
  (lsp-enable-snippet t)
  (lsp-file-watch-threshold 500)
  (lsp-gopls-complete-unimported t t)
  (lsp-gopls-staticcheck t t)
  (lsp-prefer-flymake nil t)
  (lsp-idle-delay 1)
  (lsp-treemacs-sync-mode nil)
  (read-process-output-max (* 1024 1024))
  (lsp-completion-provider :capf)
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-modeline-code-actions-mode)
         (lsp-mode . lsp-headerline-breadcrumb-mode)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))

;; optional - provides fancy overlay information
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :custom  ;; disable inline documentation
  ((lsp-ui-sideline-enable nil)
   (lsp-ui-doc-max-height 15)
   (lsp-ui-doc-max-width 30)
   (lsp-ui-flycheck-enable t t)
   (lsp-ui-imenu-enable t)
   (lsp-ui-peek-enable t)
   (lsp-ui-sideline-delay 0.5)
   (lsp-ui-doc-enable nil)))


(provide 'init-lsp)

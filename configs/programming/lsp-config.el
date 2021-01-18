(use-package company
  :ensure t
  ;; :init
  ;; (add-to-list 'company-backends 'company-capf)
  :bind
  (:map company-mode-map
        ("<backtab>" . company-yasnippet)
        :map company-active-map
        ("C-p" . company-select-previous)
        ("C-n" . company-select-next)
        ("<tab>" . company-complete-common-or-cycle)
        ("<backtab>" . my-company-yasnippet)
        :map company-search-map
        ("C-p" . company-select-previous)
        ("C-n" . company-select-next)))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

(use-package lsp-mode
  :ensure t
  ;; uncomment to enable gopls http debug server
  ;; :custom (lsp-gopls-server-args '("-debug" "127.0.0.1:0"))
  :commands (lsp lsp-deferred)
  :custom ((lsp-auto-guess-root t)
           (lsp-document-highlight-delay 2.0 t)
           (lsp-eldoc-enable-hover nil)
           (lsp-eldoc-render-all nil)
           (lsp-enable-file-watchers nil)
           (lsp-pyls-plugins-flake8-enabled t)
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
           (lsp-completion-provider :capf))
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-modeline-code-actions-mode)
         (lsp-mode . lsp-headerline-breadcrumb-mode))

  :config (progn
            ;; use flycheck, not flymake
            (setq lsp-prefer-flymake nil)))

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

(use-package company
  :ensure t
  :config (progn
            ;; don't add any dely before trying to complete thing being typed
            ;; the call/response to gopls is asynchronous so this should have little
            ;; to no affect on edit latency
            (setq company-idle-delay 0)
            ;; start completing after a single character instead of 3
            (setq company-minimum-prefix-length 1)
            ;; align fields in completions
            (setq company-tooltip-align-annotations t)
            )
  )

;; optional package to get the error squiggles as you edit
(use-package flycheck
  :ensure t)

(provide 'lsp-config)

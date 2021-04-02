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


(use-package company
  :diminish
  :ensure t
  :custom
  (company-dabbrev-downcase nil "Don't downcase returned candidates.")
  (company-show-numbers t "Numbers are helpful.")
  (company-tooltip-limit 20 "The more the merrier.")
  (company-tooltip-idle-delay 0.4 "Faster!")
  (company-async-timeout 20 "Some requests can take a long time. That's fine.")
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-format-margin-function #'company-vscode-light-icons-margin)
  :config
  ;; Use the numbers 0-9 to select company completion candidates
  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x)
                        `(lambda () (interactive) (company-complete-number ,x))))
          (number-sequence 0 9)))
  (add-to-list 'company-backends 'company-capf)
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
  :disabled
  :diminish
  :ensure t
  :hook (company-mode . company-box-mode))

(provide 'init-lsp)

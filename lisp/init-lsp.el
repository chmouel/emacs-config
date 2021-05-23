(use-package lsp-mode
  :ensure t
  :diminish
  :commands (lsp lsp-deferred lsp-organize-imports)
  :custom
  (lsp-server-install-dir (locate-user-emacs-file "auto-save-list/lsp"))
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
  (lsp-yaml-format-enable t)
  (lsp-gopls-staticcheck t t)
  (lsp-prefer-flymake nil t)
  (lsp-idle-delay 1)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (read-process-output-max (* 1024 1024))
  (lsp-completion-provider :capf)
  :config
  (setq centaur-lsp-format-on-save-ignore-modes '(c-mode c++-mode markdown-mode yaml-mode python-mode))
  :bind
  (:map prog-mode-map
        ("C-c ! L" . lsp-ui-flycheck-list)
        ("C-c ?" . lsp-ui-doc-show))
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-modeline-code-actions-mode)
         (lsp-mode . lsp-headerline-breadcrumb-mode)
         (lsp-mode . (lambda ()
                       ;; Integrate `which-key'
                       ;; (lsp-enable-which-key-integration)
                       ;; Format and organize imports
                       (unless (apply #'derived-mode-p centaur-lsp-format-on-save-ignore-modes)
                         (add-hook 'before-save-hook #'lsp-format-buffer t t)
                         (add-hook 'before-save-hook #'lsp-organize-imports t t))))))


;; optional - provides fancy overlay information
(use-package lsp-ui
  :commands lsp-ui-mode
  :custom  ;; disable inline documentation
  ((lsp-ui-sideline-enable nil)
   (lsp-ui-doc-max-height 15)
   (lsp-ui-doc-max-width 30)
   (lsp-ui-doc-show-with-cursor nil)
   (lsp-ui-doc-position 'bottom)
   (lsp-ui-flycheck-enable t t)
   (lsp-ui-imenu-enable t)
   (lsp-ui-peek-enable t)
   (lsp-ui-sideline-delay 0.5)
   (lsp-ui-doc-enable nil)))

(use-package dap-mode
  :disabled
  :after lsp
  :custom
  (lsp-enable-dap-auto-configure nil)
  :preface
  (setq dap-breakpoints-file (locate-user-emacs-file "auto-save-list/dap-breakpoints")
        dap-utils-extension-path (locate-user-emacs-file "auto-save-list/lsp-extensions"))
  :config
  (dap-mode t)
  (dap-ui-mode t)
  :commands dap-debug)

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

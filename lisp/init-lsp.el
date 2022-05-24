(use-package lsp-mode
  :ensure t
  :diminish
  :commands (lsp lsp-deferred lsp-organize-imports)
  :custom
  (lsp-server-install-dir (locate-user-emacs-file "auto-save-list/lsp"))
  (lsp-completion-default-behaviour :insert)
  (lsp-auto-guess-root t)
  (lsp-prefer-flymake nil)
  (lsp-document-highlight-delay 2.0 t)
  (lsp-session-file (locate-user-emacs-file "auto-save-list/lsp-session"))
  (lsp-eldoc-enable-hover nil)
  (lsp-eldoc-render-all nil)
  (lsp-enable-file-watchers nil)
  (lsp-enable-symbol-highlighting nil)
  (lsp-enable-links t)
  (lsp-enable-snippet t)
  (lsp-file-watch-threshold 500)
  (lsp-gopls-complete-unimported t t)
  (lsp-yaml-format-enable t)
  (lsp-gopls-staticcheck t t)
  (lsp-prefer-flymake nil t)
  (lsp-idle-delay 1)
  (lsp-lens-enable nil)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (read-process-output-max (* 1024 1024))
  (lsp-completion-provider :capf)
  (lsp-go-use-gofumpt t)
  (lsp-go-analyses '((nilfunc . t)
                     (lostcancel . t)
                     (loopclosure . t)
                     (infertypeargs . t)
                     (ifaceassert . t)
                     (httpresponse . t)
                     ;; (fieldalignment . t)
                     (errorsas . t)
                     (unusedwrite . t)
                     (nilness . t)))
  (lsp-register-custom-settings '(("gopls.experimentalWorkspaceModule" t t)
                                  ("gopls.experimentalPostfixCompletions" t t)
                                  ("gopls.staticcheck" t t)))
  :init (setq lsp-keymap-prefix "C-c l")
  :config
  (setq centaur-lsp-format-on-save-ignore-modes '(c-mode c++-mode markdown-mode yaml-mode python-mode))
  :bind
  (:map prog-mode-map
        ("C-c a" . lsp-execute-code-action)
        ("<f2>" . lsp-rename)
        ("C-c ?" . lsp-describe-thing-at-point))
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

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred

;; optional - provides fancy overlay information
(use-package lsp-ui
  :commands lsp-ui-mode
  :after lsp-mode flycheck
  :custom
  ((lsp-ui-sideline-enable nil)
   (lsp-ui-doc-max-height 15)
   (lsp-ui-doc-max-width 30)
   (lsp-ui-sideline-ignore-duplicate t)
   (lsp-ui-doc-show-with-cursor nil)
   (lsp-ui-doc-position 'bottom)
   (lsp-ui-flycheck-enable t t)
   (lsp-ui-imenu-enable t)
   (lsp-ui-peek-enable t)
   (lsp-ui-sideline-delay 0.5)
   (lsp-ui-doc-enable nil)))

(use-package lsp-treemacs
  :custom
  (lsp-treemacs-error-list-current-project-only t)
  :bind
  (:map prog-mode-map
        ("C-c ! L" . lsp-treemacs-errors-list)
        ("<f11>" . lsp-treemacs-errors-list)))

(use-package dap-mode
  :after lsp
  :hook
  (dap-stopped-hook . (lambda (arg) (call-interactively #'dap-hydra)))
  :preface
  (setq dap-breakpoints-file (locate-user-emacs-file "auto-save-list/dap-breakpoints")
        dap-utils-extension-path (locate-user-emacs-file "auto-save-list/lsp-extensions"))
  :config
  (dap-mode t)
  (dap-ui-mode t)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  :commands dap-debug)

(use-package corfu
  :bind
  (:map corfu-map
        ("C-n" . corfu-next)
        ("C-p" . corfu-previous)
        ("<escape>" . corfu-quit)
        ("<return>" . corfu-insert)
        ("C-d"  . corfu-show-documentation)
        ("C-l"  . corfu-show-location))
  :custom
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match t)
  (corfu-cycle t)
  (corfu-auto-delay 0.25)
  (corfu-scroll-margin 4)
  (corfu-auto t)
  (corfu-preselect-first t)
  (corfu-min-width 20)
  (corfu-max-width 100)
  :init
  (setq lsp-completion-provider :none)
  (defun corfu-lsp-setup ()
    (setq-local completion-styles '(orderless)
                corfu-auto-prefix 2
                completion-category-defaults nil))
  (add-hook 'lsp-mode-hook #'corfu-lsp-setup)
  (global-corfu-mode t))

(use-package corfu-doc
  :init
  (add-hook 'corfu-mode-hook #'corfu-doc-mode)
  :config
  (define-key corfu-map (kbd "C-c") #'corfu-quit) ;; corfu-next
  (define-key corfu-map (kbd "M-p") #'corfu-doc-scroll-down) ;; corfu-next
  (define-key corfu-map (kbd "M-n") #'corfu-doc-scroll-up)  ;; corfu-previous
  (define-key corfu-map (kbd "M-d") #'corfu-doc-toggle))

(provide 'init-lsp)

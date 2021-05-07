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
  (lsp-gopls-staticcheck t t)
  (lsp-prefer-flymake nil t)
  (lsp-idle-delay 1)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (lsp-treemacs-sync-mode nil)
  (read-process-output-max (* 1024 1024))
  (lsp-completion-provider :capf)
  :bind
  (:map prog-mode-map
        ("C-c ?" . lsp-ui-doc-show))
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-modeline-code-actions-mode)
         (lsp-mode . lsp-headerline-breadcrumb-mode)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))

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

(use-package lsp-treemacs
  :disabled
  :after (lsp-mode treemacs))

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

(eval-after-load "company"
  '(progn
     (require 'company)
     (require 'all-the-icons)

     (defface company-icon+ `((t (:inherit company-tooltip)))
       "Face for the margin icon in the `company-mode' tooltip."
       :group 'company-faces)

     (defface company-current-icon+ `((t (:inherit company-tooltip-selection)))
       "Face for the margin icon for the current candidate in the `company-mode' tooltip."
       :group 'company-faces)

     (defconst all-the-icons-lsp-kinds+
       (apply
        #'cons
        (cl-loop
         for parent-face in '(company-icon+ company-current-icon+)
         collect `((text        . ,(all-the-icons-material "text_fields"                 :face parent-face))
                   (method      . ,(all-the-icons-material "functions" :face `(:inherit (all-the-icons-lyellow ,parent-face))))
                   (function    . ,(all-the-icons-material "functions" :face `(:inherit (all-the-icons-lyellow ,parent-face))))
                   (constructor . ,(all-the-icons-material "create"                    :face parent-face))
                   (field       . ,(all-the-icons-material "adjust" :face `(:inherit (all-the-icons-lorange ,parent-face))))
                   (variable    . ,(all-the-icons-material "adjust"                      :face parent-face))
                   (class       . ,(all-the-icons-material "class" :face `(:inherit (all-the-icons-lred ,parent-face))))
                   (interface   . ,(all-the-icons-material "settings_input_component"    :face parent-face))
                   (module      . ,(all-the-icons-material "view_module"                 :face parent-face))
                   (property    . ,(all-the-icons-material "settings"                    :face parent-face))
                   (unit        . ,(all-the-icons-material "straighten"                  :face parent-face))
                   (value       . ,(all-the-icons-material "filter_1"                    :face parent-face))
                   (enum        . ,(all-the-icons-material "plus_one" :face `(:inherit (all-the-icons-lorange ,parent-face))))
                   (keyword     . ,(all-the-icons-material "filter_center_focus"         :face parent-face))
                   (snippet     . ,(all-the-icons-material "short_text"                  :face parent-face))
                   (template    . ,(all-the-icons-material "short_text"                  :face parent-face))
                   (color       . ,(all-the-icons-material "palette"                     :face parent-face))
                   (file        . ,(all-the-icons-material "insert_drive_file"           :face parent-face))
                   (folder      . ,(all-the-icons-material "folder"                      :face parent-face))
                   (reference   . ,(all-the-icons-material "collections_bookmark"        :face parent-face))
                   (struct      . ,(all-the-icons-material "streetview"                  :face parent-face)))))
       "Association between `eglot' LSP kinds and annotation icons for `company-mode'.
To reduce the amount of redundant processing in the margin function, this is defined
as a cons cell of icon alists, with the car alist being for regular candidates in the
company popup and the cdr alist for the current-candidate.

This structure means you don't have to do any processing, or propertising to pick an
icon for a candidate. A simple alist lookup is all you need... it might be worth
turning this into a hashset.")

     (defconst all-the-icons-default-completion-icon+
       (cons (all-the-icons-faicon "leaf" :face 'company-icon+)
             (all-the-icons-faicon "leaf" :face 'company-current-icon+)))

     (setq company-format-margin-function
           (defun company-format-margin-function+ (candidate selected)
             (concat
              (make-string company-tooltip-margin ? )
              (or
               (when-let ((kind (company-call-backend 'kind candidate)))
                 (alist-get kind
                            (if selected
                                (cdr all-the-icons-lsp-kinds+)
                              (car all-the-icons-lsp-kinds+))))
               (if selected
                   (cdr all-the-icons-default-completion-icon+)
                 (car all-the-icons-default-completion-icon+))))))))

(provide 'init-lsp)

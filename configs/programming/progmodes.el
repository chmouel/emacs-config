(use-package highlight-numbers)
(use-package toggle-quotes)
(use-package multi-compile)

;;Company mode
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package company-lsp
  :ensure t
  :commands company-lsp)

(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  (lsp-gopls-staticcheck t)
  (lsp-eldoc-render-all t)
  (lsp-gopls-complete-unimported t)
  (lsp-enable-snippet nil)
  (lsp-enable-links nil)
  (lsp-ui-sideline-delay 2.0)
  (lsp-ui-doc-max-width 30)
  (lsp-ui-doc-max-height 15)
  (lsp-document-highlight-delay 2.0)
  (lsp-auto-guess-root t)
  (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  :hook
  ((python-mode) . lsp)
  ((go-mode) . lsp))


(defun my-recompile (args)
  (interactive "P")
  (cond
   (args (call-interactively 'compile))
   ((get-buffer "*compilation*")
    (progn
      (pop-to-buffer "*compilation*")
      (recompile)))
   ((multi-compile--fill-command-list (buffer-file-name))
    (call-interactively 'multi-compile-run))
   (compile-command (call-interactively 'recompile))
   ((call-interactively 'compile))))

(defun my-programming-common-hook()
  (if (fboundp 'global-undo-tree-mode) (global-undo-tree-mode nil))
  (highlight-numbers-mode 1)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-set-key (kbd "C-'") 'toggle-quotes)
  (local-set-key '[(meta return)] 'compile)

  ;; (if (fboundp 'my-compile-command)
  ;;     (local-set-key '[(control meta return)] (lambda () (interactive) (compile my-compile-command))))
  ;; (if (fboundp 'my-compile-run-command)
  ;;     (local-set-key '[(control return)] (lambda () (interactive) (compile my-compile-run-command)))
  (local-set-key '[(control meta return)] 'multi-compile-run)
  (local-set-key '[(control return)] 'my-recompile)
  )

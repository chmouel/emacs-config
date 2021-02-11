(use-package highlight-numbers :ensure t)
(use-package toggle-quotes :ensure t)
(use-package multi-compile :ensure t)
(use-package treemacs
  :ensure t
  :bind
  (:map treemacs-mode-map
        ("f" . projectile-find-file)))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package imenu-list   :ensure t)

;; Eldoc-Mode
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :bind
  ("C-M-a" . sp-backward-sexp)
  ("C-M-e" . sp-forward-sexp)
  :config
  (bind-key
   "C-c s"
   (defhydra smartparens-hydra ()
     "Smartparens"
     ("k" sp-previous-sexp "Prev")
     ("j" sp-next-sexp "Next")
     ("u" sp-backward-up-sexp "Up")
     ("a" sp-backward-down-sexp "Down")
     ;; ("f" sp-forward-sexp "Forward")
     ;; ("b" sp-backward-sexp "Backward")
     ;; ("k" sp-kill-sexp "Kill")
     ("q" nil "Quit" :color blue))
   smartparens-mode-map)
  :hook
  (python-mode . smartparens-mode)
  (go-mode-hook . smartparens-mode)
  (lisp-interaction-mode-hook . smartparens-mode)
  (scheme-mode-hook . smartparens-mode)
  (emacs-lisp-mode-hook . smartparens-mode)
  (org-mode-hook . smartparens-mode))

(setq-default compile-command "")
(defun my-recompile (args)
  (interactive "P")
  (cond
   (args (call-interactively 'compile))
   ((get-buffer "*Go Test*")
    (progn
      (pop-to-buffer "*Go Test*")
      (recompile)))
   ((get-buffer "*compilation*")
    (progn
      (pop-to-buffer "*compilation*")
      (recompile)))
   ((multi-compile--fill-command-list (buffer-file-name))
    (call-interactively 'multi-compile-run))
   ((not (string= "" compile-command)) (call-interactively 'recompile))
   ((call-interactively 'compile))))


(defun my-programming-common-hook()
  (electric-pair-local-mode +1)
  (highlight-numbers-mode +1)
  (if (fboundp 'global-undo-tree-mode)(global-undo-tree-mode nil))
  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-set-key (kbd "C-'") 'toggle-quotes))

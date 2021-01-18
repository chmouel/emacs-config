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
  (if (fboundp 'global-undo-tree-mode)(global-undo-tree-mode nil))
  (highlight-numbers-mode 1)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-set-key (kbd "C-'") 'toggle-quotes))

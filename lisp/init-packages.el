(use-package gcmh
  :demand
  :config
  (gcmh-mode 1))

; Browse Kill Ring 
(use-package browse-kill-ring
  :custom
  (browse-kill-ring-show-preview nil)
  :bind (("C-c k" . browse-kill-ring)))

(use-package multiple-cursors
  :bind (("C-c ." . mc/mark-all-dwim))
  :custom
  (mc/list-file (locate-user-emacs-file "auto-save-list/multi-curor-list.el")))

(use-package expand-region
  :config (setq er/try-expand-list (remove 'er/mark-comment er/try-expand-list))
  :bind (("M-<up>" . er/expand-region)
         ("M-<down>" . er/contract-region)))

(use-package easy-kill
  :bind (([remap kill-ring-save] . easy-kill)))

(use-package comment-dwim-2
  :bind (([remap comment-dwim] . comment-dwim-2)))

(use-package smart-shift
  :config (global-smart-shift-mode))

(use-package zygospore
  :bind
  (("C-1" . zygospore-toggle-delete-other-windows)
   ("C-x 1" . zygospore-toggle-delete-other-windows)))

(use-package google-this
  :bind (("C-c ?" . google-this)))

(use-package dumb-jump
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :bind
  (("C-S-d" . xref-find-definitions)))

(use-package drag-stuff
  :config (drag-stuff-global-mode 1)
  :bind (([(control x) (down)] . drag-stuff-down)
         ([(control x) (up)] . drag-stuff-up)))

(use-package crux
  :bind (("C-k" . crux-smart-kill-line)
         ("C-M-l" . crux-switch-to-previous-buffer)
         ("C-M-j" . crux-top-join-line)
         ("C-M-d" . crux-duplicate-current-line-or-region)
         ([remap move-beginning-of-line] . crux-move-beginning-of-line)
         ([remap open-line] . crux-smart-open-line-above)
         ("C-\\" . crux-recentf-find-file)
         ("C-S-<return>" . crux-smart-open-line-above)
         ("S-<return>" . crux-smart-open-line)))

(use-package anzu
  :bind (([remap query-replace] . anzu-query-replace)
         ([remap query-replace-regexp] . anzu-query-replace-regexp)
         :map isearch-mode-map
         ([remap isearch-query-replace] . anzu-isearch-query-replace)
         ([remap isearch-query-replace-regexp] . anzu-isearch-query-replace-regexp))
  :custom
  (anzu-replace-to-string-separator " 👉 ")
  :hook (after-init . global-anzu-mode))

(use-package deadgrep
  :config
  (defun my-deadgrep-no-project()
    "Don't use project only current dir"
    (deadgrep--lookup-override default-directory))
  :bind
  (("C-S-g" . (lambda ()
				(interactive)
				(setq-local deadgrep-project-root-function 'my-deadgrep-no-project)
				(call-interactively 'deadgrep)))
   :map deadgrep-mode-map
   ("C-e" . deadgrep-edit-mode)))

(use-package which-key
  :init
  (which-key-mode +1))

(use-package diff-hl
  :after magit
  :custom-face
  (diff-hl-change ((t (:background nil :foreground "green"))))
  (diff-hl-margin-unknown ((t (:background nil :foreground "yellow"))))
  (diff-hl-margin-ignored ((t (:background nil :foreground "magenta"))))
  (diff-hl-delete ((t (:background nil :foreground "red"))))

  :hook ((dired-mode . diff-hl-dired-mode))
  :config
  ;; Highlight on-the-fly
  (diff-hl-margin-mode)
  (diff-hl-flydiff-mode 1)
  ;; Integration with magit
  (with-eval-after-load 'magit
    (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
    (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)))

(use-package good-scroll
  :hook
  (after-init . good-scroll-mode))

(use-package helpful
  :bind
  (([remap describe-function] . helpful-callable)
   ([remap describe-command] . helpful-command)
   ([remap describe-variable] . helpful-variable)
   ([remap describe-key] . helpful-key)
   :map emacs-lisp-mode-map
   ("C-h F" . helpful-function)
   ("C-c C-d" . helpful-at-point)))

(use-package ctrlxo
  :bind
  (("C-x o" . ctrlxo)
   ("C-<tab>" . ctrlxo)
   :map ctrlxo-map
   ("<tab>" . ctrlxo-forward)
   ("<S-tab>" . ctrlxo-backward)))

(use-package ripgrep)

(use-package restart-emacs)

(use-package ibuffer-projectile
  :hook
  (ibuffer . (lambda ()
               (ibuffer-projectile-set-filter-groups)
               )))

(use-package wgrep
  :custom
  (wgrep-enable-key "e")
  (wgrep-auto-save-buffer t)
  :hook (grep-setup . wgrep-setup))

(provide 'init-packages)

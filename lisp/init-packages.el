(use-package password-store)

(use-package gcmh
  :demand
  :config
  (gcmh-mode 1))

(use-package hydra)

(use-package smooth-scrolling
  :hook (after-init . smooth-scrolling-mode))

(use-package whitespace-cleanup
  :disabled
  :hook (after-init . global-whitespace-cleanup-mode))

(use-package bufler
  :bind
  ("C-x C-b" . bufler))

;;; Browse Kill Ring 
(use-package browse-kill-ring
  :custom
  (browse-kill-ring-show-preview nil)
  :bind (("C-c k" . browse-kill-ring)))

(use-package ace-jump-mode
  :bind ("C-0" . ace-jump-word-mode))

(use-package multiple-cursors
  :bind (("C-c ." . mc/mark-all-dwim))
  :custom
  (mc/list-file (locate-user-emacs-file "auto-save-list/multi-curor-list.el")))

(use-package expand-region
  :config (setq er/try-expand-list (remove 'er/mark-comment er/try-expand-list))
  :hydra (hydra-expand-region
          (:timeout 10)
          ""
          ("C-." er/expand-region "Increase")
          ("<return>" copy-region-as-kill "Copy")
          ("<delete>" kill-region "Cut")
          ("-" er/contract-region "Decrease")
          ("q" nil "quit"))
  :bind
  (("C-c <up>" . er/expand-region)
   ("C-." . hydra-expand-region/body)))

(use-package easy-kill
  :config
  ;; M-w ^ for begin and M-w $ for end of line
  (defun easy-kill-on-path (_n)
    (easy-kill-adjust-candidate 'path (file-name-directory (buffer-file-name))))
  (add-to-list 'easy-kill-alist '(?P path "\n\n"))
  ;; M-w ^ for begin and M-w $ for end of line
  (defun easy-kill-on-eol (_n)
    (easy-kill-adjust-candidate 'eol (point) (line-end-position)))
  (add-to-list 'easy-kill-alist '(?$ eol "\n\n"))
  (defun easy-kill-on-bol (_n)
    (easy-kill-adjust-candidate 'bol (point) (line-beginning-position)))
  (add-to-list 'easy-kill-alist '(?^ bol "\n\n"))
  (defun easy-kill-on-go-path (_n)
    (pcase (if (s-contains?
                (concat (getenv "GOPATH") "/src/github.com")
                (buffer-file-name))
               (directory-file-name
                (file-name-directory
                 (s-replace
                  (concat (getenv "GOPATH") "/src/")
                  "" (buffer-file-name)))))
      (`nil (easy-kill-echo "No `gopath' at point"))
      (name (easy-kill-adjust-candidate 'go-name name))))
  (add-to-list 'easy-kill-alist '(?G go-path "\n\n"))
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
  :bind (("M-<up>" . drag-stuff-up)
         ("M-<down>" . drag-stuff-down)))

(use-package crux
  :bind (("C-k" . crux-smart-kill-line)
         ("C-S-k" . crux-kill-whole-line)
         ("C-l" . crux-switch-to-previous-buffer)
         ("C-S-l" . crux-other-window-or-switch-buffer)
         ("C-M-j" . crux-top-join-line)
         ("C-a" . crux-move-beginning-of-line)
         ("M-S-<down>" . crux-duplicate-current-line-or-region)
         ("M-S-<up>" . (lambda (arg)
                         (interactive "P")
                         (call-interactively 'crux-duplicate-current-line-or-region)
                         (previous-logical-line)))
         ([remap open-line] . crux-smart-open-line-above)
         ("S-<return>" . crux-smart-open-line)
         ("C-x 4 t" . (lambda (arg)
                        (interactive "p")
                        (crux-transpose-windows arg)
                        (other-window arg)))))

(use-package anzu
  :bind (([remap query-replace] . anzu-query-replace)
         ([remap query-replace-regexp] . anzu-query-replace-regexp)
         ("C-S-h" . anzu-query-replace-regexp)
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
  (defun my-deadgrep-project-el()
    "Use projectel root"
    (project-root (project-current t)))
  :bind
  (("C-S-g" . (lambda ()
				(interactive)
				(setq-local deadgrep-project-root-function 'my-deadgrep-no-project)
				(call-interactively 'deadgrep)))
   ("C-c u" . (lambda ()
				(interactive)
				(setq-local deadgrep-project-root-function 'my-deadgrep-project-el)
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

(use-package helpful
  :bind
  (([remap describe-function] . helpful-callable)
   ([remap describe-command] . helpful-command)
   ([remap describe-variable] . helpful-variable)
   ([remap describe-key] . helpful-key)
   :map emacs-lisp-mode-map
   ("C-h F" . helpful-function)
   ("C-c C-d" . helpful-at-point)))

(use-package ripgrep)

(use-package restart-emacs)

(use-package wgrep
  :custom
  (wgrep-enable-key "e")
  (wgrep-auto-save-buffer t)
  :hook (grep-setup . wgrep-setup))

;; Direnv
(use-package direnv
  :ensure t
  :custom
  (direnv-always-show-summary t)
  (direnv-show-paths-in-summary nil)
  :config
  (direnv-mode))

(use-package buffer-move
  :disabled
  :bind
  ("M-S-<left>" . buf-move-left)
  ("M-S-<right>" . buf-move-right)
  ("M-S-<up>" . buf-move-up)
  ("M-S-<down>" . buf-move-down))

(use-package circe
  :custom
  (circe-reduce-lurker-spam t)
  (circe-format-say "{nick:-16s} {body}")
  :config
  (setq lui-track-bar-behavior 'before-switch-to-buffer)
  (enable-lui-track-bar)
  (enable-circe-color-nicks)
  (setq
   lui-time-stamp-position 'right-margin
   lui-fill-type nil)
  (setq circe-format-self-say "<{nick}> {body}")
  (defvar my-circe-bot-list '("fsbot" "rudybot"))
  (defun my-circe-message-option-bot (nick &rest ignored)
    (when (member nick my-circe-bot-list)
      '((text-properties . (face circe-fool-face
                                 lui-do-not-track t)))))
  (add-hook 'circe-message-option-functions 'my-circe-message-option-bot)
  (defun my-circe-via-pass (server)
    (require 'password-store)
    (password-store-get (concat "irc/" server))))

(use-package resize-window
  :bind
  ("C-c ;" . resize-window))

(use-package rainbow-mode)

(provide 'init-packages)

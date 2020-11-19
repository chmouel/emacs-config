;; Dimnish commnand line
(use-package diminish)

;; Yassnippet
(defun yas--expand-by-uuid (mode uuid)
  "Exapnd snippet template in MODE by its UUID"
  (yas/expand-snippet
   (yas--template-content
    (yas--get-template-by-uuid mode uuid))))

(defun yas--magit-email-or-default ()
  "Get email from GIT or use default"
  (require 'magit-process)
  (if (magit-toplevel ".")
      (magit-get "user.email")
    user-mail-address))

(use-package yasnippet
  :custom
  ((auto-insert-query nil)
   (yas-prompt-functions '(yas/dropdown-prompt)))
  :config
  (yas/global-mode 1)
  (require 'autoinsert)
  (auto-insert-mode)
  (define-auto-insert "\.py"
    '(lambda () (yas--expand-by-uuid 'python-mode "header")))
  (use-package dropdown-list))
(use-package yasnippet-snippets)

;; RegexTool
(use-package regex-tool :commands (regex-tool))

;; Hightly more than 80
(use-package highlight-80+ :commands  (highlight-80+))

;; Multiple cursors
(use-package multiple-cursors
  :bind (("C-c ." . mc/mark-all-dwim))
  :custom
  (mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el"))


;; Expand Region
(use-package expand-region
  :config (setq er/try-expand-list (remove 'er/mark-comment er/try-expand-list))
  :bind (("M-<up>" . er/expand-region)
         ("M-<down>" . er/contract-region)))

;; Popup for auto-complete and others
(use-package popup)

;; Auto complete in words.
(use-package auto-complete)

;; JSON Mode
(use-package json-mode :mode "\\.json\\'")

;; window-number-meta-mode
(use-package window-number
  :config (window-number-meta-mode 1))

;; Yascroll
(use-package yascroll :config (global-yascroll-bar-mode 't))

;;
(use-package powerline
  :custom
  (powerline-display-mule-info nil)
  (powerline-display-buffer-size nil))

;;Ido Vertical mode
(use-package ido-vertical-mode
  :custom
  (ido-max-prospects 5)
  :config
  (ido-vertical-mode 1))

;; smex - IDO completion for M-x
(use-package smex
  :custom
  (smex-save-file (locate-user-emacs-file "auto-save-list/smex-items"))
  :bind (("M-x" . smex)))

;; Counsel
;; (use-package counsel
;;   :bind (("M-x" . counsel-M-x)))

;; Ivy
(use-package ivy
  :config
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy))))

;; FZF
(use-package fzf
  :init (setenv "FZF_DEFAULT_COMMAND" "fd --type f")
  :commands (fzf/start fzf)
  :bind
  (("C-c F" . fzf)))

;; RG
(use-package rg
  :custom
  (rg-ignore-case 'smart))

;; AG
(use-package ag
  :bind (("C-c h" . ag-project))
  :commands (ag/read-from-minibuffer)
  :custom
  (ag-reuse-buffers t)
  :config
  (add-to-list 'ag-arguments "-z"))

;; flx-ido - advanced flex matching for ido
(use-package flx-ido
  :custom
  (ido-enable-flex-matching t)
  (ido-use-faces nil)
  :config
  (flx-ido-mode 1))

;; Flycheck
(use-package flycheck
  :config
  (defun my-flycheck-mode-line-status-text (&optional status)
    (let ((text (pcase (or status flycheck-last-status-change)
                  (`not-checked "")
                  (`no-checker "")
                  (`running "🏃🏽‍♂️")
                  (`errored "😱")
                  (`finished
                   (let-alist (flycheck-count-errors flycheck-current-errors)
                     (cond
                      (.error (format "😱 %s/%s" (or .error 0) (or .warning 0)))
                      (.warning (format "🤨 %s/%s" (or .error 0) (or .warning 0)))
                      t " ")
                     ))
                  (`interrupted "✋")
                  (`suspicious "🤔"))))
      (concat " " flycheck-mode-line-prefix text)))

  :custom
  (
   (flycheck-mode-line '(:eval (my-flycheck-mode-line-status-text)))
   (flycheck-mode-line-prefix "FC ")
   (flycheck-disabled-checkers
    '(go-unconvert
      go-staticcheck go-errcheck
      go-fmt go-build go-vet
      html-tidy xml-xmlint
      emacs-lisp emacs-lisp-checkdoc))
   (flycheck-display-errors-delay 0.2)
   (flycheck-highlighting-mode 'lines))
  :init
  (global-flycheck-mode t))

(use-package flycheck-yamllint
  :ensure t
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))))

(use-package flycheck-color-mode-line
  :disabled
  :ensure t
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))))

;;
(use-package rich-minority
  :defer t
  :ensure nil
  :init
  (rich-minority-mode)
  :custom
  ((rm-whitelist
    (format "^ \\(%s\\)$"
            (mapconcat #'identity
                       '("FC.*")
                       "\\|")))))

;; Comment dwim
(use-package comment-dwim-2 :bind (("M-;" . comment-dwim-2)))

;; Smartshift
(use-package smart-shift :config (global-smart-shift-mode))

;; Isearch
(use-package isearch-dabbrev
  :bind (:map isearch-mode-map ("<tab>" . isearch-dabbrev-expand)))

;; Toggle control-x-1 to restore after
(use-package zygospore :bind
  (("C-1" . zygospore-toggle-delete-other-windows)
   ("C-x 1" . zygospore-toggle-delete-other-windows)))

;;
(use-package google-this :bind (("C-c -" . google-this)))

;;
(use-package highlight-indentation)

;; change ag interactivity
(use-package wgrep-ag :commands (wgrep-ag-setup wgrep-ag-setup))

;; dumb-jump everywhere move into stuff
(use-package dumb-jump
  :bind
  (("C-S-d" . dumb-jump-go)))

;; Drag stuff up and down
(use-package drag-stuff
  :ensure t
  :init (drag-stuff-global-mode 1)
  :bind (([(control x) (down)] . drag-stuff-down)
         ([(control x) (up)] . drag-stuff-up)))

;; emojis 😅
(use-package emojify
  :disabled
  :config
  (advice-add #'format-mode-line :filter-return #'emojify-string))

;; Dockerfilemode
(use-package dockerfile-mode)

;; crux
(use-package crux
  :bind (("C-k" . crux-smart-kill-line)
         ("C-o" . crux-smart-open-line-above)
         ([shift return] . crux-smart-open-line )))


(use-package amx
  :init
  (amx-initialize)
  :custom
  ((amx-save-to-file
    (locate-user-emacs-file
     (concat "auto-save-list/amx-items")))))

;; Eshell
(use-package eshell
  :config
  (setq eshell-prompt-function
        (lambda ()
          (concat
           (propertize "┌─[" 'face `(:foreground "grey91"))
           (propertize (user-login-name) 'face `(:foreground "red"))
           (propertize "@" 'face `(:foreground "grey91"))
           (propertize (system-name) 'face `(:foreground "lightblue"))
           (propertize "]──[" 'face `(:foreground "grey91"))
           (propertize (format-time-string "%H:%M" (current-time)) 'face `(:foreground "yellow"))
           (propertize "]──[" 'face `(:foreground "grey91"))
           (propertize (concat (eshell/pwd)) 'face `(:foreground "white"))
           (propertize "]\n" 'face `(:foreground "grey91"))
           (propertize "└─>" 'face `(:foreground "grey91"))
           (propertize (if (= (user-uid) 0) " # " " $ ") 'face `(:foreground "grey91"))
           ))
        eshell-visual-commands '("htop" "vi" "screen" "top" "less"
                                 "more" "lynx" "ncftp" "pine" "tin" "trn" "elm"
                                 "vim")

        eshell-visual-subcommands '("git" "log" "diff" "show" "ssh"))
  :init
  (setq eshell-scroll-to-bottom-on-input 'all
        eshell-error-if-no-glob t
        eshell-hist-ignoredups t
        eshell-save-history-on-exit t
        eshell-prefer-lisp-functions nil
        eshell-destroy-buffer-when-process-dies t))

(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode)
  ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
  ;; line below instead:
  ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
  :ensure t)

;; Reformatter
(use-package reformatter)

;; Markdown mode


(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :bind (:map markdown-mode-map
              ("C-`" . markdown-insert-code))
  :init (setq markdown-command "multimarkdown"))

;; Direnv
(use-package direnv
  :custom
  (direnv-always-show-summary t)
  (direnv-show-paths-in-summary nil)
  :config
  (direnv-mode))

;; Anzu
(use-package anzu
  :bind (([remap query-replace] . anzu-query-replace)
         ([remap query-replace-regexp] . anzu-query-replace-regexp)
         :map isearch-mode-map
         ([remap isearch-query-replace] . anzu-isearch-query-replace)
         ([remap isearch-query-replace-regexp] . anzu-isearch-query-replace-regexp))
  :hook (after-init . global-anzu-mode))

(use-package info-colors
  :hook (Info-selection-hook . info-colors-fontify-node))

(use-package deadgrep
  :config
  (defun my-deadgrep-no-project()
    "Don't use project only current dir"
    (deadgrep--lookup-override default-directory))
  :bind
  (("C-c u" . 'deadgrep)
   ("C-S-g" . (lambda () (interactive) (setq-local deadgrep-project-root-function 'my-deadgrep-no-project) (call-interactively 'deadgrep)))))

;; Which key
(use-package which-key
  :config
  (which-key-mode))

;; Increment number a la vimscript
(use-package evil-numbers
  :bind
  (("C-c +" . evil-numbers/inc-at-pt)
   ("C-c -" . evil-numbers/dec-at-pt)))

;; PlantUML
(use-package plantuml-mode
  :bind (:map plantuml-mode-map ([(control c) (control c)]
                                 . my-plantuml-preview))
  :config
  (defun my-plantuml-preview ()
    (interactive)
    (save-excursion (plantuml-preview-buffer 4))))


;; Grip Mode
(use-package grip-mode
  :ensure t
  :bind (:map markdown-mode-command-map
              ("g" . grip-mode)))


(use-package eshell-toggle
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command "ls")
  (eshell-toggle-init-function #'eshell-toggle-init-eshell)
  :bind
  ([(super shift return)] . eshell-toggle))

(use-package diff-hl
  :ensure t
  :defer 1
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


(use-package "github-browse-remote"
  ;;https://github.com/chmouel/chmouzies/blob/master/emacs/github-browse-remote.el
  :ensure nil
  :bind (("<C-f6>" . github-browse-remote-kill)
         ("<f6>" . github-browse-remote)))

;;; KEEP IT
;;Web-mode
(provide 'extras-modes)

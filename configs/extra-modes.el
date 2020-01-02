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
  :diminish yas-minor-mode
  :custom
  ((auto-insert-query nil)
   (yas/prompt-functions '(yas/dropdown-prompt)))
  :config
  (yas/global-mode 1)
  (require 'autoinsert)
  (auto-insert-mode)
  (define-auto-insert "\.py"
    '(lambda () (yas--expand-by-uuid 'python-mode "header")))
  (use-package dropdown-list))

;; RegexTool
(use-package regex-tool :commands (regex-tool))

;; Hightly more than 80
(use-package highlight-80+ :commands  (highlight-80+))

;; Browse Kill ring
(use-package browse-at-remote
  :bind (("C-c C-l" . browse-at-remote)))

;; Multiple cursors
(use-package multiple-cursors
  :bind (("C-c ." . mc/mark-all-like-this-dwim))
  :custom
  (mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el"))

;; Expand Region
(use-package expand-region
  :config (setq er/try-expand-list (remove 'er/mark-comment er/try-expand-list))
  :bind (("M-<up>" . er/expand-region)
         ("M-<down>" . er/contract-region)))

;; Ibuffer-VC
(use-package ibuffer-vc
  :init
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-vc-set-filter-groups-by-vc-root)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

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

;; Github browse current file
(use-package github-browse-file)

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
(use-package counsel
  :config
  (define-key ivy-minibuffer-map (kbd "C-o") 'ivy-occur)
  (define-key ivy-minibuffer-map (kbd "C-w") 'ivy-yank-word))

;; RG
(use-package rg
  :custom
  (rg-ignore-case 'smart))

;; AG
(use-package ag
  :custom
  (ag-reuse-buffers t)
  :config
  (add-to-list 'ag-arguments "-z"))

;; flx-ido - advanced flex matching for ido
(use-package flx-ido
  :custom
  (ido-enable-flex-matching t)
  (ido-use-faces nil)
  (gc-cons-threshold 20000000)
  :config
  (flx-ido-mode 1))

;; Flycheck
(use-package flycheck
  :config
  (defun my-flycheck-mode-line-status-text (&optional status)
    (let ((text (pcase (or status flycheck-last-status-change)
                  (`not-checked "")
                  (`no-checker "")
                  (`running "*")
                  (`errored "!")
                  (`finished
                   (let-alist (flycheck-count-errors flycheck-current-errors)
                     (if (or .error .warning)
                         (format ":%s/%s" (or .error 0) (or .warning 0))
                       "")))
                  (`interrupted ".")
                  (`suspicious "?"))))
      (concat " " flycheck-mode-line-prefix text)))

  (setq
   flycheck-mode-line '(:eval (my-flycheck-mode-line-status-text))
   flycheck-mode-line-prefix "FlyChk"
   flycheck-disabled-checkers
   '(html-tidy xml-xmlint emacs-lisp emacs-lisp-checkdoc)
   flycheck-display-errors-delay 0.2
   flycheck-highlighting-mode 'lines)
  (global-flycheck-mode t))

(use-package flycheck-yamllint
  :ensure t
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))))

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
(use-package google-this :bind (("s--" . google-this)))

;;
(use-package highlight-indentation
  :config
  (set-face-background 'highlight-indentation-face "#e3e3d3")
  (set-face-background 'highlight-indentation-current-column-face "#c3b3b3"))

;; change ag interactivity
(use-package wgrep-ag :commands (wgrep-ag-setup wgrep-ag-setup))

;; dumb-jump everywhere move into stuff
(use-package dumb-jump
  :bind
  (("C-S-d" . dumb-jump-go)))

;; Drag stuff up and down
(use-package drag-stuff
  :ensure t
  :diminish drag-stuff-mode
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
  :bind (:map markdown-mode-map
              ("C-`" . markdown-insert-code)))

;; Direnv
(use-package direnv
  :custom
  (direnv-always-show-summary t)
  (direnv-show-paths-in-summary nil)
  :config
  (direnv-mode))

;; Anzu
(use-package anzu
  :diminish anzu-mode
  :config
  (global-anzu-mode +1))

(use-package info-colors
  :hook (Info-selection-hook . info-colors-fontify-node))

(use-package deadgrep
  :config
  (defun my-deadgrep-no-project()
    "Don't use project only current dir"
    (deadgrep--lookup-override default-directory))
  :bind
  (("C-S-g" . (lambda () (interactive) (setq-local deadgrep-project-root-function 'my-deadgrep-no-project) (call-interactively 'deadgrep))))
  )

;; Emacs DASHBoard ASAP
(use-package dashboard
  :ensure t
  :custom
  (dashboard-banner-logo-title "Welcome to ChmouMACS!!")
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-set-file-icons t)
  (dashboard-set-heading-icons t)
  (dashboard-items '((recents . 10)
                     (projects  . 10)
                     (bookmarks . 5)))
  :bind (:map
         dashboard-mode-map
         ("g" . (lambda ()
                  (interactive)
                  (if (file-directory-p
                       (thing-at-point 'filename))
                      (magit-status (thing-at-point 'filename)))))

         ("b" . (lambda ()
                  (interactive)
                  (if (file-directory-p
                       (thing-at-point 'filename))
                      (let ((default-directory (thing-at-point 'filename)))
                        (magit-show-refs)))))

         ("p" . dashboard-previous-line)
         ("n" . dashboard-next-line))
  :bind (("s-3" . my-show-dashboard))
  :config
  (dashboard-setup-startup-hook)
  (defun my-show-dashboard()
    (interactive)
    (if (not (get-buffer dashboard-buffer-name))
        (progn
          (ignore-errors (dashboard-insert-startupify-lists))
          (switch-to-buffer dashboard-buffer-name)
          (dashboard-mode))
      (progn (dashboard-refresh-buffer)))
    (call-interactively 'widget-forward)))

;; Ace Window
(use-package ace-window
  :bind (("C-M-s-w" . ace-window)))

(use-package ace-jump-buffer
  :custom
  ((ajb-bs-configuration "files"))
  :bind (("C-M-s-e" . ace-jump-buffer)))

;; Which key
(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

;;
(use-package centaur-tabs
  :bind
  (("s-{" . centaur-tabs-backward)
   ("s-}" . centaur-tabs-forward)
   ("s->" . centaur-tabs-counsel-switch-group)
   ("S-s up" . centaur-tabs-forward-group)
   ("S-s down" . centaur-tabs-backward-group))

  :custom
  ((centaur-tabs-cycle-scope 'tabs)
   (centaur-tabs-set-bar 'under)
   (x-underline-at-descent-line t)
   (centaur-tabs-set-modified-marker t)
   (centaur-tabs-modified-marker "﹡")
   (centaur-tabs-gray-out-icons 'buffer)
   (centaur-tabs-set-icons t))

  :init
  (require 'centaur-tabs)
  :config
  (centaur-tabs-headline-match)
  (centaur-tabs-mode t)
  (centaur-tabs-group-by-projectile-project))

;; VTERM
(use-package vterm)

;; ZOOM mode
(use-package zoom
  :diminish zoom-mode
  :config
  (zoom-mode 1))

;;

;;; KEEP IT
;;Web-mode
(provide 'extras-modes)

;; Dimnish commnand line
(use-package diminish :ensure t)

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
  :ensure t
  :diminish yas-minor-mode
  :custom
  ((auto-insert-query nil)
   (yas-prompt-functions '(yas/dropdown-prompt)))
  :config
  (yas/global-mode 1)
  (require 'autoinsert)
  (auto-insert-mode)
  (setq auto-insert-query nil)
  (setq auto-insert-alist nil)
  (define-auto-insert "\.py"
    '(lambda () (yas--expand-by-uuid 'python-mode "header"))))
  ;; (use-package dropdown-list :ensure t))
  
(use-package yasnippet-snippets :diminish :ensure t)

;; RegexTool
(use-package regex-tool :commands (regex-tool) :ensure t)

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-c ." . mc/mark-all-dwim))
  :custom
  (mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el"))


;; Expand Region
(use-package expand-region
  :ensure t
  :config (setq er/try-expand-list (remove 'er/mark-comment er/try-expand-list))
  :bind (("M-<up>" . er/expand-region)
         ("M-<down>" . er/contract-region)))

;; Popup for auto-complete and others
(use-package popup :ensure t)

;; Auto complete in words.
(use-package auto-complete :ensure t)

;; JSON Mode
(use-package json-mode :mode "\\.json\\'" :ensure t)

;; Yascroll
(use-package yascroll :config (global-yascroll-bar-mode 't) :ensure t)

(use-package powerline
  :ensure t
  :custom
  (powerline-display-mule-info nil)
  (powerline-display-buffer-size nil))

;; FZF
(use-package fzf
  :ensure t
  :init (setenv "FZF_DEFAULT_COMMAND" "fd --type f")
  :commands (fzf/start fzf)
  :bind
  (("C-c F" . fzf)))

;; RG
(use-package rg
  :ensure t
  :custom
  (rg-ignore-case 'smart))

;; AG
(use-package ag
  :ensure t
  :bind (("C-c h" . ag-project))
  :commands (ag/read-from-minibuffer)
  :custom
  (ag-reuse-buffers t)
  :config
  (add-to-list 'ag-arguments "-z"))

;; Flycheck
(use-package flycheck
  :disabled
  :ensure t
  :config
  (defun my-flycheck-mode-line-status-text (&optional status)
    (let ((text (pcase (or status flycheck-last-status-change)
                  (`not-checked "")
                  (`no-checker "")
                  (`running "🏃")
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
  ((flycheck-mode-line '(:eval (my-flycheck-mode-line-status-text)))
   (flycheck-mode-line-prefix "FC ")
   (flycheck-disabled-checkers
    '(go-unconvert
      ;; go-staticcheck go-errcheck
      ;; go-fmt go-build go-vet
      html-tidy xml-xmlint
      emacs-lisp emacs-lisp-checkdoc))
   (flycheck-display-errors-delay 0.2)
   (flycheck-highlighting-mode 'lines))
  :init
  (global-flycheck-mode t))

;;Flycheck
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
  :ensure t
  :custom
  ((rm-whitelist
    (format "^ \\(%s\\)$"
            (mapconcat #'identity
                       '("FC.*")
                       "\\|")))))

;; Comment dwim
(use-package comment-dwim-2 :ensure t  :bind (("M-;" . comment-dwim-2)))

;; Smartshift
(use-package smart-shift :ensure t :config (global-smart-shift-mode))

;; Isearch
(use-package isearch-dabbrev
  :ensure t
  :bind (:map isearch-mode-map ("<tab>" . isearch-dabbrev-expand)))

;; Toggle control-x-1 to restore after
(use-package zygospore
  :ensure t
  :bind
  (("C-1" . zygospore-toggle-delete-other-windows)
   ("C-x 1" . zygospore-toggle-delete-other-windows)))

;;
(use-package google-this :ensure t :bind (("C-c *" . google-this)))

;;
(use-package highlight-indentation :ensure t)

;; change ag interactivity
(use-package wgrep-ag :commands (wgrep-ag-setup wgrep-ag-setup) :ensure t)

;; dumb-jump everywhere move into stuff
(use-package dumb-jump
  :ensure t
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :bind
  (("C-S-d" . dumb-jump-go)))

;; Drag stuff up and down
(use-package drag-stuff
  :diminish
  :ensure t
  :init (drag-stuff-global-mode 1)
  :bind (([(control x) (down)] . drag-stuff-down)
         ([(control x) (up)] . drag-stuff-up)))

;; Dockerfilemode
(use-package dockerfile-mode :ensure t )

;; crux
(use-package crux
  :ensure t
  :bind (("C-k" . crux-smart-kill-line)
         ("C-M-l" . crux-switch-to-previous-buffer)
         ("C-o" . crux-smart-open-line-above)
         ([shift return] . crux-smart-open-line )))

;; Eshell autosuggest
(use-package esh-autosuggest
  :ensure t
  :hook (eshell-mode . esh-autosuggest-mode)
  ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
  ;; line below instead:
  ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
  :ensure t)

;; Reformatter
(use-package reformatter :ensure t )

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
  :ensure t
  :custom
  (direnv-always-show-summary t)
  (direnv-show-paths-in-summary nil)
  :config
  (direnv-mode))

;; Anzu
(use-package anzu
  :ensure t
  :diminish
  :bind (([remap query-replace] . anzu-query-replace)
         ([remap query-replace-regexp] . anzu-query-replace-regexp)
         :map isearch-mode-map
         ([remap isearch-query-replace] . anzu-isearch-query-replace)
         ([remap isearch-query-replace-regexp] . anzu-isearch-query-replace-regexp))
  :ensure t
  :hook (after-init . global-anzu-mode))

;; Swiper
(use-package swiper
  :ensure t 
  :diminish
  :config
  (if (executable-find "rg")
      (setq counsel-grep-base-command
            "rg -i -M 120 --no-heading --line-number --color never %s %s"))
  :bind 
  (("C-S-s" . 'swiper-isearch)
   :map isearch-mode-map
   ("C-'" . swiper-from-isearch)))

;; Easy-kill
(use-package easy-kill
  :ensure t
  :bind
  (("M-w" . 'easy-kill)))

;; Info colours
(use-package info-colors
  :ensure t :hook (Info-selection-hook . info-colors-fontify-node))

;; Deadgrep
(use-package deadgrep
  :ensure t
  :config
  (defun my-deadgrep-no-project()
    "Don't use project only current dir"
    (deadgrep--lookup-override default-directory))
  :bind
  (("C-c u" . 'deadgrep)
   ("C-S-g" . (lambda () (interactive) (setq-local deadgrep-project-root-function 'my-deadgrep-no-project) (call-interactively 'deadgrep)))
   :map deadgrep-mode-map
   ("C-e" . deadgrep-edit-mode)))

;; Which key
(use-package which-key
  :diminish
  :ensure t
  :config
  (which-key-mode))

;; Increment number a la vimscript
(use-package evil-numbers
  :ensure t
  :bind
  (("C-c +" . evil-numbers/inc-at-pt)
   ("C-c -" . evil-numbers/dec-at-pt)))

;; PlantUML
(use-package plantuml-mode
  :ensure t
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
  :ensure t
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command "ls")
  (eshell-toggle-init-function #'eshell-toggle-init-eshell)
  :bind
  ("C-`" . eshell-toggle))

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

; Avy
(use-package avy
  :ensure t
  :bind ("C-c C-j" . avy-goto-word-1))

;; Use ripgrep
(use-package "ripgrep" :ensure t)

;;; KEEP IT
;;Web-mode
(provide 'extras-modes)

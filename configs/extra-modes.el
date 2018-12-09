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
(use-package browse-kill-ring)

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
;; Smart power bar that look fruitful
(use-package micgoline)

;; Boorkmarks
(use-package bm)

;;Company mode
(use-package company :diminish company-mode)

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

;; ag a C ack replacement
(use-package ag                            ;
  :commands (ag ag/dwim-at-point)
  :chords ("=-" . my-ag-here)
  :bind   (("s-h" . projectile-ag)
           ("C-S-g" . my-ag-here)
           ("C-S-h" . projectile-ag))
  :custom
  (ag-reuse-buffers t)
  :config
  (add-to-list 'ag-arguments "-z")
  (defun my-ag-here (string)
    (interactive (list (read-from-minibuffer "Search string here: " (ag/dwim-at-point))))
    (ag/search string (expand-file-name "."))))

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
   flycheck-mode-line-prefix "👺"
   flycheck-disabled-checkers
   '(html-tidy xml-xmlint emacs-lisp emacs-lisp-checkdoc)
   flycheck-display-errors-delay 0.2
   flycheck-highlighting-mode 'lines)
  (global-flycheck-mode t))

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

;;edit-server
(use-package edit-server
  :config
  (use-package edit-server-htmlize
    :config
    (add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
    (add-hook 'edit-server-done-hook 'edit-server-maybe-htmlize-buffer))
  (edit-server-start))

;; ADOC mode
(use-package adoc-mode :mode "\\.adoc\\'")

;; crux
(use-package crux
  :bind (("C-k" . crux-smart-kill-line)
         ("C-o" . crux-smart-open-line-above)
         ([shift return] . crux-smart-open-line )))


;;Web-mode
(provide 'extras-modes)

;;RST
(autoload 'rst-mode "rst" "RST" t)
(push '("\\.rst\\'" . rst-mode) auto-mode-alist)

;; Yassnippet
(defun yas--expand-by-uuid (mode uuid)
  "Exapnd snippet template in MODE by its UUID"
  (yas/expand-snippet
   (yas--template-content
    (yas--get-template-by-uuid mode uuid))))

(defun yas--magit-email-or-default ()
  "Get email from GIT or use default"
  (if (magit-toplevel ".")
      (magit-get "user.email")
    user-mail-address))

(use-package yasnippet
  :config
  (yas/global-mode 1)
  (require 'autoinsert)
  (auto-insert-mode)
  (setq auto-insert-query nil)
  (define-auto-insert "\.py"
    '(lambda () (yas--expand-by-uuid 'python-mode "header")))
  (use-package dropdown-list)
  (setq yas/prompt-functions '(yas/dropdown-prompt)))

;; RegexTool
(use-package regex-tool :commands (regex-tool))

;; Hightly more than 80
(use-package highlight-80+ :commands  (highlight-80+))

;; Browse Kill ring
(use-package browse-kill-ring)

;; Multiple cursors
(use-package multiple-cursors
  :bind (("C-c ." . mc/mark-all-like-this-dwim))
  :config (setq mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el"))

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

;; Smart power bar that look fruitful
(use-package micgoline :config (require 'micgoline))

;; Boorkmarks
(use-package bm)

;;Company mode
(use-package company)

;;Ido Vertical mode
(use-package ido-vertical-mode
  :config
  (ido-vertical-mode 1)
  (setq ido-max-prospects 5))

;; smex - IDO completion for M-x
(use-package smex
  :config
  (setq smex-save-file (locate-user-emacs-file "auto-save-list/smex-items"))
  :bind (("M-x" . smex)))

;; ag a C ack replacement
(use-package ag                            ;
  :commands (ag ag/dwim-at-point)
  :bind   (("C-S-h" . my-ag-repo)
           ("C-S-g" . my-ag-here))
  :config
  (setq ag-reuse-buffers t)
  (defun my-ag-repo (string)
    (interactive
     (list (read-from-minibuffer
            "Search string: "
            (ag/dwim-at-point))))
    (let ((gitdir (magit-toplevel ".")))
      (if gitdir
          (ag/search string gitdir))))
  (defun my-ag-here (string)
    (interactive (list (read-from-minibuffer "Search string: " (ag/dwim-at-point))))
    (ag/search string (expand-file-name "."))))

;; flx-ido - advanced flex matching for ido
(use-package flx-ido
  :config
  (setq gc-cons-threshold 20000000)
  (flx-ido-mode 1))

;; Flycheck
(use-package flycheck
  :config
  (setq flycheck-disabled-checkers
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
(use-package google-this :bind (("S--" . google-this)))

;;
(use-package highlight-indentation
  :config
  (set-face-background 'highlight-indentation-face "#e3e3d3")
  (set-face-background 'highlight-indentation-current-column-face "#c3b3b3"))

(use-package wgrep-ag :commands (wgrep-ag-setup wgrep-ag-setup))

;;Web-mode
(provide 'extras-modes)

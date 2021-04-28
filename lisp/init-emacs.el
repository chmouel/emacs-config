(use-package emacs
  :preface
  ;; FilePath
  (setq server-auth-dir (locate-user-emacs-file "auto-save-list/server/")
        url-configuration-directory (locate-user-emacs-file "auto-save-list/url/")
        url-cookie-file (locate-user-emacs-file "auto-save-list/cookies")
        tramp-persistency-file-name (locate-user-emacs-file "auto-save-list/tramp")
        gnus-init-file (locate-user-emacs-file "lisp/init-gnus.el")
        url-history-file (locate-user-emacs-file "auto-save-list/url-history")
        package-quickstart-file (locate-user-emacs-file "auto-save-list/package-quickstart.el")
        bookmark-default-file (locate-user-emacs-file "auto-save-list/bookmarks.bmk")
        save-place-file (locate-user-emacs-file "auto-save-list/emacs-places.el")
        nsm-settings-file (locate-user-emacs-file "auto-save-list/network-security.data"))
  :bind
  ("M-u" . upcase-dwim)
  ("M-l" . downcase-dwim)
  ("M-c" . capitalize-dwim)
  ("C-<next>" . end-of-buffer)
  ("C-<prior>" . beginning-of-buffer)
  ("C-c \]" . next-error)
  ("C-c \[" . previous-error)

  ("C-x B" . switch-to-buffer-other-window)

  ("C-x C-=" . ediff-buffers)
  ;; kill-current-buffer works weirdly for me, it switch to another buffer i am
  ;; not expected with and i have been using that keybining/lambda to a very long time
  ("C-x C-k" . (lambda ()
                 (interactive)(kill-buffer (current-buffer))))

  ("C-x f" . find-file-at-point)
  ("M-q" . fill-region)

  ("C-\\" . (lambda () (interactive) (find-file (completing-read "Recent File: " recentf-list))))

  ("C-c <up>" . backward-paragraph)
  ("C-c <down>" . forward-paragraph)

  ("C-x <left>" . indent-rigidly-left)
  ("C-x <right>" . indent-rigidly-right)

  ("C-2" . split-window-vertically)

  ;; Redefine {for/back}ward paragraphs to just 4 lines
  ("C-<down>" .
   (lambda ()
     (interactive)
     (ignore-errors (next-logical-line 5))))

  ("C-<up>" .
   (lambda ()
     (interactive)
     (ignore-errors (previous-logical-line 5))))

  :hook
  (after-save . executable-make-buffer-file-executable-if-script-p)
  (after-init . windmove-default-keybindings)
  ;;----------------------------------------------------------------------------
  ;; Allow access from emacsclient
  ;;----------------------------------------------------------------------------
  (after-init . (lambda ()
                  (require 'server)
                  (unless (and (fboundp 'server-running-p) (server-running-p))
                    (server-start))))
  :config
  (global-set-key (kbd "C-S-<up>") (kbd "C-u 2 M-v"))
  (global-set-key (kbd "C-S-<down>") (kbd "C-u 2 C-v"))

  (global-unset-key "\C-x\C-z")
  (global-unset-key "\C-z")
  (fset 'yes-or-no-p 'y-or-n-p)

  :custom
  (tab-width 4)
  (indent-tabs-mode nil)
  (fill-column 80)
  ;; Backup
  (vc-follow-symlinks t)
  (enable-local-variables :all) ;; Is it a good idea ?? probably not :\
  (make-backup-files nil))

;; Diff
(use-package diff
  :custom
  (diff-font-lock-prettify t)
  (diff-font-lock-syntax nil))

;; Ediff
(use-package ediff
  :custom
  (ediff-diff-options "-w")
  (ediff-split-window-function 'split-window-horizontally)
  (emerge-diff-options "--ignore-all-space")
  (ediff-window-setup-function 'ediff-setup-windows-plain))

;; Time
(use-package time
  :custom
  (display-time-24hr-format t)
  (display-time-default-load-average nil)
  (display-time-world-list
   '(("Europe/Paris" "Paris")
     ("America/New_York" "Boston")
     ("America/Los_Angeles" "San-Francisco")
     ("Asia/Kolkata" "Bangalore"))))

;; Save Places
(use-package saveplace
  :custom
  (save-place t))

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :custom
  (savehist-file (locate-user-emacs-file "auto-save-list/save-history.el"))
  (enable-recursive-minibuffers t)
  (history-length 1000)
  (savehist-additional-variables
   '(mark-ring
     global-mark-ring
     search-ring
     regexp-search-ring
     extended-command-history))
  (savehist-autosave-interval 300))

;; Hippy-Expand
(use-package hippie-exp
  :ensure nil
  :bind (([remap dabbrev-expand] . hippie-expand))
  :custom
  (hippie-expand-try-functions-list
   '(try-expand-dabbrev
     try-complete-file-name-partially
     try-complete-file-name
     try-expand-dabbrev-all-buffers
     try-expand-all-abbrevs
     try-expand-list
     try-expand-line
     try-expand-dabbrev-from-kill
     try-complete-lisp-symbol-partially
     try-complete-lisp-symbol)))

(use-package tab-bar
  :hydra (hydra-tabs (:timeout 10)
                     ""
                     ("n" tab-new "new")
                     ("k" tab-close "kill")
                     ("f" find-file-other-tab "find-file")
                     ("\[" tab-previous "previous")
                     ("\]" tab-next "next")
                     ("<return>" tab-bar-select-tab-by-name "select")
                     ("m" tab-bar-move-tab "move")
                     ("r" tab-bar-rename-tab "rename")
                     ("M" (lambda () (interactive) (tab-bar-move-tab -1)) "moveleft")
                     ("P" (lambda ()
                            (interactive)
                            (let ((tab-bar-new-tab-choice 'my-projectile-and-find-file))
                              (tab-new)))
                      "projectfile")
                     ("p" (lambda ()
                            (interactive)
                            (let ((tab-bar-new-tab-choice 'my-projectile-and-dired))
                              (tab-new)))
                      "projectdired")
                     ("q" nil "quit"))
  :bind
  ("s-<tab>" . hydra-tabs/body)
  :custom
  (tab-bar-new-button-show 'nil)
  (tab-bar-history-mode 'nil)
  (tab-bar-new-tab-to 'rightmost)
  (tab-bar-tab-hints 't)
  :config
  (cond ((memq window-system '(mac ns))
         (setq tab-bar-select-tab-modifiers '(super)))
        ((memq window-system '(x))
         (setq tab-bar-select-tab-modifiers '(meta))))
  (tab-bar-mode 1)
  (setq tab-bar-new-tab-choice "."))

(use-package isearch
  :ensure nil
  :defer t
  :bind
  (:map
   isearch-mode-map
   ("C-." . isearch-forward-symbol-at-point)
   ("C-o" . my-isearch-occur)
   ("M-o" . my-isearch-moccur))
  :custom
  (isearch-allow-scroll t)
  :config
  (defun my-isearch-moccur ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (multi-occur-in-matching-buffers
       (concat ".*\." (file-name-extension (buffer-file-name)) "$")
       (if isearch-regexp isearch-string (regexp-quote isearch-string)))))
  (defun my-isearch-occur ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;;  Flyspell mode
(use-package vc
  :ensure nil
  :hook
  (log-edit-mode . flyspell-mode))

;; Recentfiles
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-max-saved-items 500)
  (recentf-exclude
   '("\\.?cache" ".cask" "url" "COMMIT_EDITMSG\\'" "bookmarks"
     "\\.\\(?:gz\\|gif\\|svg\\|elc\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
     "\\.?ido\\.last$" "\\.revive$" "/G?TAGS$" "/.elfeed/"
     "^/tmp/" "^/var/folders/.+$" "^/ssh:" "/persp-confs/"
     (lambda (file) (file-in-directory-p file package-user-dir))))
  (recentf-save-file (locate-user-emacs-file "auto-save-list/recent-file-list.el"))
  (recentf-max-saved-items 500)
  :config
  (push (expand-file-name recentf-save-file) recentf-exclude)
  (add-to-list 'recentf-filename-handlers 'abbreviate-file-name))

;; Sho long
(use-package so-long
  :ensure nil
  :hook (after-init . global-so-long-mode)
  :config (setq so-long-threshold 400))

;; Paren mode
(use-package paren
  :ensure nil
  :custom
  (show-paren-highlight-openparen t)
  (show-paren-when-point-in-periphery t)
  (show-paren-when-point-inside-paren t))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package winner
  :ensure nil
  :hook (after-init . winner-mode))

(provide 'init-emacs)

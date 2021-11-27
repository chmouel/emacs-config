(use-package emacs
  :preface
  ;; FilePath
  (setq server-auth-dir (locate-user-emacs-file "auto-save-list/server/")
        url-configuration-directory (locate-user-emacs-file "auto-save-list/url/")
        url-cookie-file (locate-user-emacs-file "auto-save-list/cookies")
        tramp-persistency-file-name (locate-user-emacs-file "auto-save-list/tramp")
        gnus-init-file (locate-user-emacs-file "lisp/init-gnus.el")
        url-history-file (locate-user-emacs-file "auto-save-list/url-history")
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
  ("C-x C-=" . ediff-buffers)
  ;; kill-current-buffer works weirdly for me, it switch to another buffer i am
  ;; not expected with and i have been using that keybining/lambda to a very long time
  ("C-x C-k" . (lambda ()
                 (interactive)(kill-buffer (current-buffer))))

  ("C-x f" . find-file-at-point)
  ("M-q" . fill-region)

  ("C-c <up>" . backward-paragraph)
  ("C-c <down>" . forward-paragraph)

  ("C-x <left>" . indent-rigidly-left)
  ("C-x <right>" . indent-rigidly-right)

  ("C-2" . split-window-vertically)

  ;; Redefine {for/back}ward paragraphs to just 4 lines
  ("C-<down>" .
   (lambda ()
     (interactive)
     (ignore-errors (next-logical-line 5))
     (pulse-momentary-highlight-one-line (point))))

  ("C-<up>" .
   (lambda ()
     (interactive)
     (ignore-errors (previous-logical-line 5))
     (pulse-momentary-highlight-one-line (point))))

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
  (global-unset-key "\C-x\C-z")
  (global-unset-key "\C-z")

  :custom
  (initial-scratch-message nil)
  (kill-whole-line t)
  (use-short-answers t)
  (package-native-compile t)
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

;; XREF
(use-package xref
  :custom
  (xref-search-program 'ripgrep))

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
  :config
  (setq savehist-additional-variables
        '(mark-ring
          global-mark-ring
          search-ring
          regexp-search-ring
          register-alist
          extended-command-history))
  :custom
  (savehist-file (locate-user-emacs-file "auto-save-list/save-history.el"))
  (enable-recursive-minibuffers t)
  (history-length 1000)
  (savehist-autosave-interval 300))

(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer)
  :custom
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-use-header-line nil)
  :hook
  (ibuffer-mode . hl-line-mode)
  :config
  (defun my-real-buffer-p (buf)
    (not (buffer-file-name buf)))
  (with-eval-after-load "ibuf-ext"
    (add-to-list 'ibuffer-never-show-predicates #'my-real-buffer-p)))

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
                     ("q" nil "quit"))
  :bind
  ("C-M-l" . tab-recent)
  ("s-<tab>" . hydra-tabs/body)
  :custom
  (tab-bar-new-button-show 'nil)
  (tab-bar-close-button nil)
  (tab-bar-history-mode 'nil)
  (tab-bar-new-tab-to 'rightmost)
  (tab-bar-tab-hints 't)
  (tab-bar-separator "  ")
  :config
  (cond ((memq window-system '(mac ns))
         (setq tab-bar-select-tab-modifiers '(super)))
        (t
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
   ("C-o" . isearch-occur)
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

(use-package calendar
  :ensure nil
  :custom
  (calendar-holidays `((holiday-fixed 1 1 "Jour de l'an")
	                   (holiday-fixed 1 6 "Épiphanie")
	                   (holiday-fixed 2 2 "Chandeleur")
	                   (holiday-fixed 2 14 "Saint Valentin")
	                   (holiday-fixed 5 1 "Fête du travail")
	                   (holiday-fixed 5 8 "Commémoration de la capitulation de l'Allemagne en 1945")
	                   (holiday-fixed 6 21 "Fête de la musique")
	                   (holiday-fixed 7 14 "Fête nationale - Prise de la Bastille")
	                   (holiday-fixed 8 15 "Assomption (Religieux)")
	                   (holiday-fixed 11 11 "Armistice de 1918")
	                   (holiday-fixed 11 1 "Toussaint")
	                   (holiday-fixed 11 2 "Commémoration des fidèles défunts")
	                   (holiday-fixed 12 25 "Noël")
                       ;; fetes a date variable
	                   (holiday-easter-etc 0 "Pâques")
                       (holiday-easter-etc 1 "Lundi de Pâques")
                       (holiday-easter-etc 39 "Ascension")
                       (holiday-easter-etc 49 "Pentecôte")
                       (holiday-easter-etc -47 "Mardi gras")
	                   (holiday-float 5 0 4 "Fête des mères")
	                   ;; dernier dimanche de mai ou premier dimanche de juin si c'est le
	                   ;; même jour que la pentecôte TODO
	                   (holiday-float 6 0 3 "Fête des pères"))) ;; troisième dimanche de juin
  (calendar-mark-holidays-flag t)
  (calendar-week-start-day 1))

;; (use-package winner
;;   :ensure nil
;;   :hook (after-init . winner-mode))

(use-package grep
  :ensure nil
  :hook
  (grep-mode .
             (lambda ()
               (switch-to-buffer-other-window "*grep*")))
  :custom
  (grep-highlight-matches 'always))

(use-package term
  :disabled
  :ensure nil
  :bind
  ("C-`" . my-toggle-term)
  :config
  ;;https://gist.github.com/msoeken/4b2e3ee07b7252f8cb99
  (defun my-toggle-term ()
    "Toggles between terminal and current buffer (creates terminal, if none exists)"
    (interactive)
    (if (string= (buffer-name) "*ansi-term*")
        (other-window 1)
      (if (get-buffer "*ansi-term*")
          (pop-to-buffer "*ansi-term*")
        (progn
          (ansi-term (getenv "SHELL"))
          (setq show-trailing-whitespace nil))))))

(provide 'init-emacs)

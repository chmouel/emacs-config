(use-package emacs
  :bind
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

  ( "C-2" . split-window-vertically)

  ;; Redefine {for/back}ward paragraphs to just 4 lines
  ("C-<down>" . 
   (lambda ()
     (interactive)
     (ignore-errors (next-logical-line 5))))

  ("C-<up>" .
   (lambda ()
     (interactive)
     (ignore-errors (previous-logical-line 5))))

  ;; Go to GNUS
  ("<f2>" .
   (lambda ()
     (interactive)
     (let ((tab-index (or (tab-bar--tab-index-by-name "*Group*") -1)))
       (if (= tab-index -1)
           (progn
             (tab-bar-select-tab tab-index)
             (gnus)))
       (tab-bar-select-tab (1+ tab-index)))))  


  :hook
  (after-save . executable-make-buffer-file-executable-if-script-p)
  (before-save . my-delete-trailing-whitespace)
  (after-init . windmove-default-keybindings)
  
  :config
  (defvar my-delete-trailing-whitespace-enabled t)
  (defun my-delete-trailing-whitespace ()
    (if my-delete-trailing-whitespace-enabled (delete-trailing-whitespace)))
  
  (when (not window-system)
    (define-key function-key-map "\eO1;5A"    [C-up])
    (define-key function-key-map "\eO1;5B"  [C-down])
    (define-key function-key-map "\eO1;5C" [C-right])
    (define-key function-key-map "\eO1;5D"  [C-left]))  

  (global-unset-key "\C-x\C-z")
  (global-unset-key "\C-z")
  
  (fset 'yes-or-no-p 'y-or-n-p)  
  :custom
  ;; Bookmarks
  (gnus-init-file (locate-user-emacs-file "gnus/init.el"))
  (url-history-file (locate-user-emacs-file "auto-save-list/url-history"))
  (package-quickstart-file (locate-user-emacs-file "auto-save-list/package-quickstart.el"))
  (bookmark-default-file (locate-user-emacs-file "auto-save-list/bookmarks.bmk"))
  (save-place-file (locate-user-emacs-file "auto-save-list/emacs-places.el"))
  (nsm-settings-file (locate-user-emacs-file "auto-save-list/network-security.data")))

;; Save Places
(use-package saveplace :config (setq-default save-place t))

;;Abbrev
(use-package abbrev
  :diminish abbrev-mode
  :custom
  abbrev-file-name (locate-user-emacs-file "auto-save-list/abbrev_defs"))

;; Hippy-Expand
(use-package hippie-exp
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
  :ensure nil
  :custom
  (
   tab-bar-new-button-show 'nil
   tab-bar-history-mode 't
   tab-bar-new-tab-to 'rightmost
   tab-bar-tab-hints 't)
  :config
  (cond ((memq window-system '(mac ns))
         (setq tab-bar-select-tab-modifiers '(super)))
        ((memq window-system '(x))
         (setq tab-bar-select-tab-modifiers '(meta))))
  (tab-bar-mode 1)
  (setq tab-bar-new-tab-choice (lambda () (dired "."))))

;; Find files already opened
(use-package isearch
  :ensure nil
  :defer t
  :bind (([remap isearch-forward] . endless/isearch-symbol-with-prefix)
         :map isearch-mode-map
         ("C-." . isearch-forward-symbol-at-point)
         ("C-o" . my-isearch-occur)
         ("M-o" . my-isearch-moccur))
  :custom
  (isearch-allow-scroll t)
  :config
  ;; http://endlessparentheses.com/quickly-search-for-occurrences-of-the-symbol-at-point.html
  (defun endless/isearch-symbol-with-prefix (p)
    "Like isearch, unless prefix argument is provided.
With a prefix argument P, isearch for the symbol at point."
    (interactive "P")
    (let ((current-prefix-arg nil))
      (call-interactively
       (if p #'isearch-forward-symbol-at-point
         #'isearch-forward))))

  (defun my-isearch-moccur ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (multi-occur-in-matching-buffers
       (concat ".*\." (file-name-extension (buffer-file-name)) "$")
       (if isearch-regexp isearch-string (regexp-quote isearch-string)))
      ))

  (defun my-isearch-occur ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; IBUFFER
(use-package ibuffer
  :hook
  (ibuffer-mode . (lambda ()
	                (ibuffer-auto-mode 1)
	                (ibuffer-filter-by-visiting-file nil)))
  :custom (ibuffer-saved-filter-groups
           (quote (
                   ("default"
                    ("Files" (not mode . dired-mode) (name . "^[^*]"))
                    ("Directories" (mode . dired-mode))))
                  ))
  :bind (("C-x C-b" . ibuffer-jump)
         :map ibuffer-mode-map
         ("M-p" . ibuffer-backward-line)))

;; Shell Mode
(use-package shell
  :hook
  (shell-mode . ansi-color-for-comint-mode-on)
  :custom
  (
   comint-prompt-read-only t
   ansi-color-names-vector ; better contrast colors
   ["black" "red4" "green4" "yellow4"
    "blue3" "magenta4" "cyan4" "white"]))

;; Comit mode
(use-package comint
  :hook
  (comint-mode . (lambda ()
                   (local-set-key
                    '[(control meta l)]
                    (lambda () (interactive)
                      (switch-to-buffer (other-buffer nil)))))))

;;  Flyspell mode
(use-package vc
  :hook
  (log-edit-mode . flyspell-mode))

;;  Define j/k for scroll up/down on view-mode and derived.
(defun my-view-vi-keys-map (x-map)
  (define-key x-map (read-kbd-macro "S-SPC") 'View-scroll-page-backward)
  (define-key x-map (read-kbd-macro "j") 'View-scroll-line-forward)
  (define-key x-map (read-kbd-macro "k") 'View-scroll-line-backward))

(eval-after-load "view" '(my-view-vi-keys-map view-mode-map))
(eval-after-load "man" '(my-view-vi-keys-map Man-mode-map))

;;  Ediff
(use-package ediff
  :custom
  (emerge-diff-options "--ignore-all-space"))

;; Diff
(use-package diff
  :custom
  (diff-refine nil))

;; Compilation colors
(use-package ansi-color
  :hook
  (compilation-filter . (lambda ()
                          (toggle-read-only)
                          (ansi-color-apply-on-region compilation-filter-start (point))
                          (toggle-read-only))))

;; Start server mode
(use-package server
  :hook
  (after-init . server-mode))
                                        ;
(use-package eldoc)
(use-package subword)
(use-package autorevert)

;; Which-func
(use-package which-func
  :config (which-function-mode)
  :custom-face
  (which-func ((((class color) (min-colors 89)) (:foreground "#ffffff" :background "SlateBlue2"))))
  :config
  (setq which-func-unknown "⊥" ; The default is really boring…
        which-func-format
        `((:propertize ("" which-func-current "")
                       local-map ,which-func-keymap
                       face which-func
                       mouse-face mode-line-highlight
                       help-echo "mouse-1: go to beginning\n\
mouse-2: toggle rest visibility\n\
mouse-3: go to end"))))

;;View
(use-package view)

;; Search files on the system
(use-package locate
  :defer t
  :config
  ;; Use mdfind as locate substitute on OS X, to utilize the Spotlight database
  (when-let (mdfind (and (eq system-type 'darwin) (executable-find "mdfind")))
    (setq locate-command mdfind)))

;; Recentf
(use-package recentf
  :config
  (recentf-load-list)
  :custom
  (recentf-save-file (locate-user-emacs-file "auto-save-list/recent-file-list.el")
                     recentf-max-saved-items 500 recentf-max-menu-items 15))

;; Xref
(use-package xref
  :bind
  (:map xref--xref-buffer-mode-map
        ("N" . (lambda ()(interactive)(xref--search-property 'xref-group)))
        ("P" . (lambda ()(interactive)(xref--search-property 'xref-group t)))))

;; VC
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
  :custom
  (
   eshell-scroll-to-bottom-on-input 'all
   eshell-error-if-no-glob t
   eshell-hist-ignoredups t
   eshell-save-history-on-exit t
   eshell-prefer-lisp-functions nil
   eshell-destroy-buffer-when-process-dies t))

(provide 'init-emacs)

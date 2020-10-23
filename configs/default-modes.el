;; Save Places
(use-package saveplace :config (setq-default save-place t))

;;Abbrev
(setq
 abbrev-file-name (concat user-emacs-directory "auto-save-list/abbrev_defs"))

;; Bookmarks
(setq bookmark-default-file (concat user-emacs-directory "/auto-save-list/bookmarks.bmk"))

;; Hippy-Expand
(use-package hippie-exp                 ; Powerful expansion and completion
  :bind (([remap dabbrev-expand] . hippie-expand))
  :config
  (progn
    (setq hippie-expand-try-functions-list
          '(try-expand-dabbrev
            try-complete-file-name-partially
            try-complete-file-name
            try-expand-dabbrev-all-buffers
            try-expand-all-abbrevs
            try-expand-list
            try-expand-line
            try-expand-dabbrev-from-kill
            try-complete-lisp-symbol-partially
            try-complete-lisp-symbol))))

(use-package tab-bar
  :ensure nil
  :custom
  (tab-bar-new-button-show
   nil
   tab-bar-select-tab-modifiers '(super))
  :config
  (setq tab-bar-new-tab-choice (lambda () (dired ".")))
  (tab-bar-mode 1)
  :bind
  (("s-{" . tab-previous)
   ("s-}" . tab-next)
   ("s->" . tab-switcher)
   ("s-w" . (lambda () (interactive) (kill-current-buffer) (tab-bar-close-tab)))
   ("s-t" . tab-new)))




;; Find files already opened
(use-package isearch
  :ensure nil
  :defer t
  :bind (([remap isearch-forward] . endless/isearch-symbol-with-prefix)
         :map isearch-mode-map
         ("C-." . isearch-forward-symbol-at-point)
         ("C-o" . my-isearch-occur)
         ("M-o" . my-isearch-moccur)
         )
  :init
  (setq isearch-allow-scroll t)
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
  :init
  (add-hook 'ibuffer-mode-hook
	        '(lambda ()
	           (ibuffer-auto-mode 1)
	           (ibuffer-filter-by-visiting-file nil)))
  :hook ibuffer-auto-mode
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
;(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))
(use-package shell
  :hook ansi-color-for-comint-mode-on
  :config (setq comint-prompt-read-only t
                ansi-color-names-vector ; better contrast colors
                ["black" "red4" "green4" "yellow4"
                 "blue3" "magenta4" "cyan4" "white"]))

;; Comit mode
(add-hook 'comint-mode-hook
          (lambda ()
            (local-set-key
             '[(control meta l)]
             (lambda () (interactive)
               (switch-to-buffer (other-buffer nil))))))

;;  Flyspell mode
(add-hook 'log-edit-mode-hook 'flyspell-mode)

;;  Make execustable scripts.
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;  Delete trailing whitespace, allow overriding it in a dirs-locale with the
;;  my-delete-trailing-whitespace-enabled variable
(defvar my-delete-trailing-whitespace-enabled 't)
(defun my-delete-trailing-whitespace ()
  (if my-delete-trailing-whitespace-enabled (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'my-delete-trailing-whitespace)


;;  Define j/k for scroll up/down on view-mode and derived.
(defun my-view-vi-keys-map (x-map)
  (define-key x-map (read-kbd-macro "S-SPC") 'View-scroll-page-backward)
  (define-key x-map (read-kbd-macro "j") 'View-scroll-line-forward)
  (define-key x-map (read-kbd-macro "k") 'View-scroll-line-backward)
  )

(eval-after-load "view" '(my-view-vi-keys-map view-mode-map))
(eval-after-load "man" '(my-view-vi-keys-map Man-mode-map))

;;  M-z redefine to zap-up-to-char
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-z") 'zap-up-to-char)

;;  Ediff
(setq emerge-diff-options "--ignore-all-space")

;; Compilation colors
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(use-package server                     ; The server of `emacsclient'
  :init (server-mode))
;
(use-package eldoc)
(use-package subword)
(use-package autorevert)

;; Which-func
(use-package which-func
  :disabled t
  :init (which-function-mode)
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

(use-package ido
  :defer t
  :bind
  (:map ido-completion-map
        (" "   . ido-next-match)
        ))

;; Find files already recent
(use-package files
  :after ido
  :ensure nil
  :defer t
  :bind (("s-." . my-goto-recent-files))
  :config
  (defun my-goto-recent-files(arg)
    (interactive "P")
    (let ((rf (if arg (--filter (not (string-match ":" it)) recentf-list) recentf-list)))
      (find-file (ido-completing-read "File: " rf)))))

;; Recentf
(use-package recentf
  :config
  (recentf-load-list)
  :custom
  (recentf-save-file "~/.emacs.d/auto-save-list/recent-file-list.el"
                     recentf-max-saved-items 500 recentf-max-menu-items 15))

;; VC

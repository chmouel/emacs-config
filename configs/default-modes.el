;; Save Places
(use-package saveplace :config (setq-default save-place t))

;;Abbrev
(setq
 abbrev-file-name (concat my-init-directory "/auto-save-list/abbrev_defs"))

;; Bookmarks
(setq bookmark-default-file (concat my-init-directory "/auto-save-list/bookmarks.bmk"))

;; Dired
(defun my-dired-mode-hook ()
  (dired-omit-mode)
  (when (featurep 'tooltip) (tooltip-mode 0))
  (local-set-key '[(j)] 'dired-next-line)
  (local-set-key '[(k)] 'dired-previous-line)
  (local-set-key '[(s)] 'dired-up-directory)
  (local-set-key '[(l)] 'my-dired-launch-command)
  (local-set-key '[(backspace)] 'dired-up-directory)
  (local-set-key '[(E)] 'wdired-change-to-wdired-mode)
  (local-set-key '[(W)] 'browse-url-of-dired-file)
  (local-set-key '[(mouse-1)] 'dired-advertised-find-file)
  (require 'dired-x)
  )
(add-hook 'dired-mode-hook 'my-dired-mode-hook)

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

;; Isearch with occur
(defun my-isearch-occur ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))
(define-key isearch-mode-map (kbd "C-o") 'my-isearch-occur)
(setq isearch-allow-scroll t)
(diminish 'isearch-mode)

;; Email With Message-mail
(fset 'mail 'message-mail)
(if (file-exists-p (concat my-init-directory "/gnus/message.el"))
    (load-file (concat my-init-directory "/gnus/message.el")))

;; IBUFFER
(use-package ibuffer
  :hook ibuffer-auto-mode
  :config (setq ibuffer-saved-filter-groups
                (quote (
                        ("default"
                         ("Files" (not mode . dired-mode) (name . "^[^*]"))
                         ("Directories" (mode . dired-mode))))
                       ))
  :bind (("C-~" . ibuffer)))

;; Shell Mode
;(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))
(use-package shell
  :hook ansi-color-for-comint-mode-on
  :config (setq comint-prompt-read-only t
                ansi-color-names-vector ; better contrast colors
                ["black" "red4" "green4" "yellow4"
                 "blue3" "magenta4" "cyan4" "white"]))

;;  IDO
(defun my-ido-local-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map " " 'ido-next-match)
  )
(add-hook 'ido-setup-hook 'my-ido-local-keys)

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

;;  Delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

;                                       ;
(use-package server                     ; The server of `emacsclient'
  :init (server-mode)
  :diminish (server-buffer-clients . " ⓒ"))

;
(use-package eldoc :diminish eldoc-mode)
(use-package subword :diminish subword-mode)
(use-package autorevert :diminish auto-revert-mode)

;; Which-func
(use-package which-func
  :init (which-function-mode)
  :config
  (setq which-func-unknown "⊥" ; The default is really boring…
        which-func-format
        `((:propertize (" " which-func-current)
                       local-map ,which-func-keymap
                       face which-func
                       mouse-face mode-line-highlight
                       help-echo "mouse-1: go to beginning\n\
mouse-2: toggle rest visibility\n\
mouse-3: go to end"))))

;;View
(use-package view :diminish (view-mode . "👁"))

;; Grep
(use-package grep
  :defer t
  :config
  (when-let (gnu-find (and (eq system-type 'darwin)
                           (executable-find "gfind")))
    (setq find-program gnu-find))

  (when-let (gnu-xargs (and (eq system-type 'darwin)
                            (executable-find "gxargs")))
    (setq xargs-program gnu-xargs)))

;; Search files on the system
(use-package locate
  :defer t
  :config
  ;; Use mdfind as locate substitute on OS X, to utilize the Spotlight database
  (when-let (mdfind (and (eq system-type 'darwin) (executable-find "mdfind")))
    (setq locate-command mdfind)))

;Abbrev
(setq
 abbrev-file-name (concat my-init-directory "/auto-save-list/abbrev_defs"))

;Bookmarks
(setq  bookmark-default-file (concat my-init-directory "/auto-save-list/bookmarks.bmk"))

;Dired
(require 'dired-x)
(autoload 'dired-omit-mode "dired-x" nil t)

(defun my-dired-mode-hook ()
  ;(local-set-key '[(mouse-3)] 'mouse-popup-menubar-stuff)
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

;Hippy-Expand
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
        try-complete-lisp-symbol))

;Isearch with occur
(defun my-isearch-occur ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))
(define-key isearch-mode-map (kbd "C-o") 'my-isearch-occur)

;Email With Message-mail
(fset 'mail 'message-mail)
(if (file-exists-p (concat my-init-directory "/gnus/message.el"))
  (load-file (concat my-init-directory "/gnus/message.el")))

;IBUFFER
(add-hook 'ibuffer-mode-hook 'ibuffer-auto-mode)
(setq ibuffer-saved-filter-groups
      (quote (
              ("default"
               ("Files" (not mode . dired-mode) (name . "^[^*]"))
               ("Directories" (mode . dired-mode))))
              ))
(global-set-key (read-kbd-macro "C-S-`") 'ibuffer)

;Shell Mode
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

;AutoInsert
(auto-insert-mode 't)
(setq auto-insert-alist
      '((python-mode . "python.py")))

;Iswitchb
(require 'iswitchb)
(defun my-iswitchb-local-keys ()
  (mapc (lambda (K)
	      (let* ((key (car K)) (fun (cdr K)))
            (define-key iswitchb-mode-map (edmacro-parse-keys key) fun)))
	    '(("<right>" . iswitchb-next-match)
	      ("<left>"  . iswitchb-prev-match)
	      ("<up>"    . ignore             )
	      ("<down>"  . ignore             ))))
(add-hook 'iswitchb-define-mode-map-hook 'my-iswitchb-local-keys)

; IDO
(defun my-ido-local-keys ()
 "Add my keybindings for ido."
 (define-key ido-completion-map " " 'ido-next-match)
 )
(add-hook 'ido-setup-hook 'my-ido-local-keys)

;Comit mode
(add-hook 'comint-mode-hook
	  (lambda ()
        (local-set-key
         '[(control meta l)]
         (lambda () (interactive)
           (switch-to-buffer (other-buffer nil))))))

; Flyspell mode
(add-hook 'log-edit-mode-hook 'flyspell-mode)

; Make execustable scripts.
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

; Delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; Define j/k for scroll up/down on view-mode and derived.
(defun my-view-vi-keys-map (x-map)
  (define-key x-map (read-kbd-macro "S-SPC") 'View-scroll-page-backward)
  (define-key x-map (read-kbd-macro "j") 'View-scroll-line-forward)
  (define-key x-map (read-kbd-macro "k") 'View-scroll-line-backward)
)

(eval-after-load "view" '(my-view-vi-keys-map view-mode-map))
(eval-after-load "man" '(my-view-vi-keys-map Man-mode-map))

; M-z redefine to zap-up-to-char
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-z") 'zap-up-to-char)

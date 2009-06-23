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
  (local-set-key '[(meta s)]  (lambda () (interactive) (svn-status (dired-current-directory)) (switch-to-buffer "*svn-status*"))) 
  (local-set-key '[(s)] 'dired-up-directory) 
  (local-set-key '[(E)] 'wdired-change-to-wdired-mode) 
  (local-set-key '[(W)] 'browse-url-of-dired-file)
  (local-set-key '[(mouse-1)] 'dired-advertised-find-file)
  (require 'dired-x)
  )
(add-hook 'dired-mode-hook 'my-dired-mode-hook)

;Hippy-Expand
(setq hippie-expand-try-functions-list 
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;Emacs-Lisp
(eldoc-mode 't)

;Browse-URL
(Work
 (require 'browse-url)
 (add-to-list 'browse-url-filename-alist
              '("/home/cboudjnah/Work/intranet" . "http://localhost/intranet")
              '("/home/cboudjnah/Work/overmind/web" . "http://localhost/overmind")
              ))

;Org-Mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;Isearch with occur
(defun my-isearch-occur ()
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))
(define-key isearch-mode-map (kbd "C-o") 'my-isearch-occur)

;Isearch switched buffer
;(define-key global-map [(control ?z)] 'isearchb-activate)

;SQL Information
(Work
 (setq sql-user "root"
       sql-password ""
       sql-database "intranet"
       sql-server "localhost"
       sql-product (quote mysql)
       sql-electric-stuff (quote semicolon)
       sql-input-ring-file-name (concat my-init-directory "/auto-save-list/mysql_history.sql")
       sql-product (quote mysql)
       )
 (defalias 'sql 'sql-mysql)
)

;Email With Message-mail
(fset 'mail 'message-mail)
(if (file-exists-p (concat my-init-directory "/gnus/message.el"))
  (load-file (concat my-init-directory "/gnus/message.el")))

;IBUFFER
(add-hook 'ibuffer-mode-hook 'ibuffer-auto-mode)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("Emacs" (name . "^*"))
;               ("IRC" (mode . erc-mode))
;               ("TiltWEB" (filename . "^.*/TiltWeb/.*"))
;               ("CoreCli" (filename . "^.*CoreCli.*"))
;               ("DailyUpdate" (filename . "^.*DailyUpdate.*"))
;;              ("Gnus" (or
;;                         (mode . message-mode)
;;                         (mode . bbdb-mode)
;;                         (mode . mail-mode)
;;                         (mode . gnus-group-mode)
;;                         (mode . gnus-summary-mode)
;;                         (mode . gnus-article-mode)
;;                         (name . "^\\.bbdb$")
;;                         (name . "^\\.newsrc-dribble")))
               )))
      )

;; ibuffer, I like my buffers to be grouped
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups
             "default")))


;Shell Mode
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

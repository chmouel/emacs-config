;;SNIPPPET
(require 'snippet nil t)

;;Emacs-W3M
(when (featurep 'w3m)
  (define-key w3m-mode-map [mouse-2] 'w3m-mouse-view-this-url-new-session))

;Elscreen
(Work
 (if (and (featurep 'elscreen) window-system)
     (progn
       (setq elscreen-display-tab t)
       (global-set-key (read-kbd-macro "M-1") (lambda () (interactive) (elscreen-goto 0)))
       (global-set-key (read-kbd-macro "M-2") (lambda () (interactive) (elscreen-goto 1)))
       (global-set-key (read-kbd-macro "M-3") (lambda () (interactive) (elscreen-goto 2)))
       (global-set-key (read-kbd-macro "M-4") (lambda () (interactive) (elscreen-goto 3)))
       (global-set-key (read-kbd-macro "M-5") (lambda () (interactive) (elscreen-goto 4)))
       (global-set-key (read-kbd-macro "M-6") (lambda () (interactive) (elscreen-goto 5)))
       (global-set-key (read-kbd-macro "M-7") (lambda () (interactive) (elscreen-goto 6)))
       (global-set-key (read-kbd-macro "M-8") (lambda () (interactive) (elscreen-goto 7)))
       (global-set-key (read-kbd-macro "M-9") (lambda () (interactive) (elscreen-goto 8)))
       (global-set-key (read-kbd-macro "M-0") (lambda () (interactive) (elscreen-goto 9)))
       (global-set-key '[(control home)] 'elscreen-previous)
       (global-set-key '[(control end)] 'elscreen-next)
       (define-key elscreen-map (read-kbd-macro "SPC") 'elscreen-next)
       (define-key elscreen-map (read-kbd-macro "DEL") 'elscreen-previous)
       (elscreen-create)
       (elscreen-create)
       (elscreen-create)
       (elscreen-goto 0)
       (require 'elscreen-dired)
       )
   )
)

;Disable screen when not window-system
(Work
 (if  (and (featurep 'elscreen) (not window-system))
   (setq elscreen-display-tab nil)
   )
 )

;PSVN should be necessary only on custom install (debian configuration)
(Win
 (autoload 'svn-status "psvn" nil t))

;
(require 'swbuff nil t)
(when (featurep 'swbuff)
  (global-set-key (read-kbd-macro "M-`") 'swbuff-switch-to-next-buffer)
  (global-set-key (read-kbd-macro "M-~") 'swbuff-switch-to-previous-buffer))
;
;(require 'iswitch-recent-files)

;
(Win
 (autoload 'ahk-mode "ahk-mode"  "AHK Mode."  t))

; BreadCrumb (Bookmarks)
(autoload 'bc-set               "breadcrumb" "Set bookmark in current buffer."  t)
(autoload 'bc-previous          "breadcrumb" "Go to previous bookmark."         t)
(autoload 'bc-next              "breadcrumb" "Go to next bookmark."             t)
(autoload 'bc-local-previous    "breadcrumb" "Go to previous local bookmark."   t)
(autoload 'bc-local-next        "breadcrumb" "Go to next local bookmark."       t)
(autoload 'bc-goto-current      "breadcrumb" "Go to the current bookmark."      t)
(autoload 'bc-list              "breadcrumb" "List all bookmarks in menu mode." t)
(autoload 'bc-clear             "breadcrumb" "Clear all bookmarks."             t)
(global-set-key [C-f2]      'bc-set)
(global-set-key [f2]        'bc-previous)
(global-set-key [S-f2]      'bc-next)
(global-set-key [M-f2]      'bc-list)

;Jabber
(autoload 'jabber-connect "jabber" "Jabber Mode" t)
(eval-after-load "jabber"
  '(progn
     (global-set-key '[(control x)(control j)]   'dired-jump)
     (define-key ctl-x-map "\C-z" jabber-global-keymap)     
     ))

;
(require 'winring)
(global-set-key '[(f10)]      'winring-next-configuration)
(global-set-key '[(control f10)]      'winring-prev-configuration)
(winring-initialize)

;
(require 'rst)
(add-to-list 'auto-mode-alist '("\\.rst\\'" . rst-mode))

;;
;;
(require 'anything-config)
(when (featurep 'anything-config)
;ISEARCHB
  (define-key global-map [(control ?z)] 'anything)
  (setq anything-sources
        '(
          anything-c-source-buffers
          anything-c-source-file-name-history
          anything-c-source-files-in-current-dir
          anything-c-source-occur
          anything-c-source-imenu
          anything-c-source-ctags
          anything-c-source-ffap-guesser
          anything-c-source-bookmarks
          anything-c-source-kill-ring
          ))
  (setq anything-c-boring-buffer-regexp 
        "\\(\\` \\)\\|\\*anything\\| \\*Echo Area\\| \\*Minibuf\\|\\*Customize*\\|\\*Completions\\|\\*Woman\\|\\*info\\|\\*Messages\\|\\*Help")
  )

;
(require 'window-numbering)
(window-numbering-mode t)

;
(require 'highlight-parentheses)

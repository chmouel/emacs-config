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

;
(require 'swbuff nil t)
(when (featurep 'swbuff)
  (global-set-key (read-kbd-macro "M-`") 'swbuff-switch-to-next-buffer)
  (global-set-key (read-kbd-macro "M-~") 'swbuff-switch-to-previous-buffer))

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
(setcdr (assq 'html rst-compile-toolsets)
        '("rst2html" ".htm" 
          "--stylesheet=/usr/share/doc/python-configobj/stylesheets/voidspace_docutils.css"))

;
(require 'window-numbering)
(window-numbering-mode t)

;
(require 'highlight-parentheses)

;yasnippet
(require 'yasnippet) ;; not yasnippet-bundle
(setq yas/trigger-key (kbd "")) 
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt)) 

;Flymake
(eval-after-load "flymake"
  '(progn
     (require 'flymake-cursor)))
     

;Ack
(setenv "ACK_COLOR_MATCH" "")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(global-set-key (kbd "C-M-s") 'ack)

;;
(require 'lua-mode nil t)

;;
(autoload 'git-status "git" "GIT status" t)

;twitter
(autoload 'twit-show-recent-tweets	"twit" "" t) ; most recent direct tweets (!)

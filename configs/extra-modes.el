;Elscreen
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

;Disable screen when not window-system
(if  (and (featurep 'elscreen) (not window-system))
    (setq elscreen-display-tab nil)
  )

;SWBUFF
(when (featurep 'swbuff)
  (global-set-key (read-kbd-macro "M-`") 'swbuff-switch-to-next-buffer)
  (global-set-key (read-kbd-macro "M-~") 'swbuff-switch-to-previous-buffer))

;RST
(autoload 'rst-mode "rst" "RST" t)
(push '("\\.rst\\'" . rst-mode) auto-mode-alist)

; Windows Numbering
(require 'window-numbering)
(window-numbering-mode t)

; For Yas/Snippet
(require 'python)
(require 'cc-mode)

;Yasnippet
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
     
;LUA-MODE
(autoload 'lua-mode "lua-mode" "Lua Mode" t)

;GIT
(autoload 'git-status "git" "GIT status" t)

;IGREP
(autoload 'igrep "igrep" "IGREP" t)
(autoload 'igrep-find "igrep" "IGREP" t)
(defun my-igrep-at-point()
  (interactive)
  (let* ((cword (current-word))
         (regexp (read-from-minibuffer 
                  (format "Grep (%s): " cword) ))
         (igrep-find t))
    (if (string= regexp "")
        (setq regexp (current-word)))
    (igrep nil regexp '("*")))
  )
(global-set-key (kbd "C-M-s") 'my-igrep-at-point)

;RegexTool
(autoload 'regex-tool "regex-tool" "REGEX Tool" t)

;SML Mode
(if (require 'sml-modeline nil 'noerror)    ;; use sml-modeline if available
  (progn 
    (sml-modeline-mode 1)                   ;; show buffer pos in the mode line
    (scroll-bar-mode -1)))                   ;; turn off the scrollbar

;Magit
(autoload 'magit-status "magit" "Magit Status" t)

;Elscreen
(if (and (featurep 'elscreen) window-system)
     (progn
       (setq elscreen-display-tab t)
       (global-set-key (read-kbd-macro "M-1")
                       (lambda () (interactive) (elscreen-goto 0)))
       (global-set-key (read-kbd-macro "M-2")
                       (lambda () (interactive) (elscreen-goto 1)))
       (global-set-key (read-kbd-macro "M-3")
                       (lambda () (interactive) (elscreen-goto 2)))
       (global-set-key (read-kbd-macro "M-4")
                       (lambda () (interactive) (elscreen-goto 3)))
       (global-set-key (read-kbd-macro "M-5")
                       (lambda () (interactive) (elscreen-goto 4)))
       (global-set-key (read-kbd-macro "M-6")
                       (lambda () (interactive) (elscreen-goto 5)))
       (global-set-key (read-kbd-macro "M-7")
                       (lambda () (interactive) (elscreen-goto 6)))
       (global-set-key (read-kbd-macro "M-8")
                       (lambda () (interactive) (elscreen-goto 7)))
       (global-set-key (read-kbd-macro "M-9")
                       (lambda () (interactive) (elscreen-goto 8)))
       (global-set-key (read-kbd-macro "M-0")
                       (lambda () (interactive) (elscreen-goto 9)))
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

;RST
(autoload 'rst-mode "rst" "RST" t)
(push '("\\.rst\\'" . rst-mode) auto-mode-alist)

; For Yas/Snippet
(require 'yasnippet nil t) ;; not yasnippet-bundle
(when (featurep 'yasnippet)
  (yas/global-mode 1)
  (eval-after-load "yasnippet"
    '(progn
       (require 'dropdown-list)
       (setq yas/prompt-functions '(yas/dropdown-prompt))))
)

;Flymake
(eval-after-load "flymake"
  '(progn
     (require 'flymake-cursor)))

;LUA-MODE
(autoload 'lua-mode "lua-mode" "Lua Mode" t)

;GIT
(autoload 'git-status "git" "GIT status" t)

;RegexTool
(autoload 'regex-tool "regex-tool" "REGEX Tool" t)

;Magit
(autoload 'magit-status "magit" "Magit Status" t)
(global-set-key (read-kbd-macro "C-c g") 'magit-status)

;Puppet Mode
(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

;Todo-Txt
(require 'todotxt nil t)
(when (featurep 'todotxt)
  (global-set-key (kbd "<f12>") 'todotxt)
  (setq todotxt-file (expand-file-name "~/Dropbox/todo/todo.txt"))
)

; Hightly more than 80
(require 'highlight-80+ nil t)

; Highlight Indentation
(require 'highlight-indentation nil t)

;Find find in GIT repo
(require 'find-file-in-git-repo nil t)
(when (featurep 'find-file-in-git-repo)
  (global-set-key (kbd "C-c C-g") 'find-file-in-git-repo)
  (global-set-key (kbd "C-S-f") 'find-file-in-git-repo)
  )

(require 'mark-more-like-this nil t)
(when (featurep 'mark-more-like-this)
  (global-set-key (kbd "C-c r") 'mark-all-like-this))

;RST
(autoload 'rst-mode "rst" "RST" t)
(push '("\\.rst\\'" . rst-mode) auto-mode-alist)

;TodoTXT
(autoload 'todotxt "todotxt" nil t)
(global-set-key (kbd "<f12>") 'todotxt)
(setq todotxt-file (expand-file-name "~/Dropbox/todo/todo.txt"))


;Ensure package is installed
(package-initialize)
(defun my-ensure-installed (package)
  (if (not (package-installed-p package))
      (package-install package)))

; For Yas/Snippet
(my-ensure-installed 'yasnippet)
(my-ensure-installed 'yasnippet-bundle)
(my-ensure-installed 'dropdown-list)
(require 'yasnippet nil t) ;; not yasnippet-bundle
(when (featurep 'yasnippet)
  (yas/global-mode 1)
  (eval-after-load "yasnippet"
    '(progn
       (require 'dropdown-list)
       (setq yas/prompt-functions '(yas/dropdown-prompt))))
)

;Flymake
(my-ensure-installed 'flymake-cursor)
(eval-after-load "flymake"
  '(progn
     (require 'flymake-cursor)))

; Flymake shell mode
(my-ensure-installed 'flymake-shell)
(eval-after-load "flymake"
  '(progn
     (require 'flymake-shell nil t)
     (add-hook 'sh-set-shell-hook 'flymake-shell-load)))

;RegexTool
(my-ensure-installed 'regex-tool)
(autoload 'regex-tool "regex-tool" "REGEX Tool" t)

;Magit
(my-ensure-installed 'magit)
(autoload 'magit-status "magit" "Magit Status" t)
(global-set-key (read-kbd-macro "C-c g") 'magit-status)

; Hightly more than 80
(my-ensure-installed 'highlight-80+)
(autoload 'highlight-80+ "highlight-80+" nil t)

; Highlight Indentation
(my-ensure-installed 'highlight-indentation)
(autoload 'highlight-indentation "highlight-indentation" nil t)

;Find find in GIT repo
(my-ensure-installed 'find-file-in-git-repo)
(require 'find-file-in-git-repo nil t)
(global-set-key (kbd "C-c C-g") 'find-file-in-git-repo)
(global-set-key (kbd "C-S-f") 'find-file-in-git-repo)

; Browse Kill ring
(my-ensure-installed 'browse-kill-ring)
(autoload 'browse-kill-ring "browse-kill-ring" "Browse Kill Ring" t)

; Multiple cursors
(setq mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el")
(my-ensure-installed 'multiple-cursors)
(autoload 'mc/mark-next-like-this "multiple-cursors" "Multiple Cursors" t)
(global-set-key (kbd "C-@") 'mc/mark-next-like-this)

; Expand Region
(my-ensure-installed 'expand-region)
(autoload 'er/expand-region "expand-region" "Multiple Cursors" t)
(global-set-key (kbd "C-=") 'er/expand-region)

; Anything!!!
(my-ensure-installed 'anything)
(my-ensure-installed 'anything-config)
(require 'anything nil t)
(require 'anything-config nil t)
(require 'anything-git-goto nil t)
(defun my-anything ()
  (interactive)
  (anything-other-buffer
   '(anything-c-source-buffers
     anything-c-source-git-goto
     anything-c-source-bookmarks
     anything-c-source-imenu
     anything-c-source-recentf
     )
   " *my-anything*"))
(global-set-key (read-kbd-macro "C-z") 'my-anything)

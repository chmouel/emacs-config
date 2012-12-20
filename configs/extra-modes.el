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
(push "~/.emacs.d/packages/yasnippet" load-path)
(require 'yasnippet nil t) ;; not yasnippet-bundle
(when (featurep 'yasnippet)
  (yas/global-mode 1)
  (eval-after-load "yasnippet"
    '(progn
       (require 'dropdown-list)
       (setq yas/prompt-functions '(yas/dropdown-prompt))))
)

;Flymake
(push "~/.emacs.d/packages/yasnippet" load-path)
(eval-after-load "flymake"
  '(progn
     (require 'flymake-cursor)))

;RegexTool
(my-ensure-installed 'regex-tool)
(autoload 'regex-tool "regex-tool" "REGEX Tool" t)

;Magit
(push "~/.emacs.d/packages/magit" load-path)
(autoload 'magit-status "magit" "Magit Status" t)
(global-set-key (read-kbd-macro "C-c g") 'magit-status)

; Hightly more than 80
(my-ensure-installed 'highlight-80+)
(autoload 'highlight-80+ "highlight-80+" nil t)

;Find find in GIT repo
(my-ensure-installed 'find-file-in-git-repo)
(require 'find-file-in-git-repo nil t)
(global-set-key (kbd "C-c C-g") 'find-file-in-git-repo)
(global-set-key (kbd "C-S-f") 'find-file-in-git-repo)

; Browse Kill ring
(push "~/.emacs.d/packages/browse-kill-ring" load-path)
(autoload 'browse-kill-ring "browse-kill-ring" "Browse Kill Ring" t)

; Multiple cursors
(push "~/.emacs.d/packages/multiple-cursors" load-path)
(setq mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el")
(autoload 'mc/mark-next-like-this "multiple-cursors" "Multiple Cursors" t)
(global-set-key (kbd "C-@") 'mc/mark-next-like-this)

; Expand Region
(push "~/.emacs.d/packages/expand-region" load-path)
(autoload 'er/expand-region "expand-region" "Multiple Cursors" t)
(global-set-key (kbd "C-=") 'er/expand-region)

; Anything!!!
(my-ensure-installed 'anything)
(my-ensure-installed 'anything-config)
(my-ensure-installed 'anything-git-goto)
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
     anything-c-source-time-world)
   "*my-anything*"))
(define-key anything-map (kbd "C-S-p") 'anything-previous-source)
(define-key anything-map (kbd "C-S-n") 'anything-next-source)
(global-set-key (read-kbd-macro "C-z") 'my-anything)

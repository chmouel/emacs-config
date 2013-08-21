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
(autoload 'magit-read-top-dir "magit" "Magit Status" t)
(global-set-key (read-kbd-macro "C-c g") 'magit-status)
(global-set-key (read-kbd-macro "C-S-o") '(lambda ()(interactive) (find-file (magit-read-top-dir nil))))

; Hightly more than 80
(my-ensure-installed 'highlight-80+)
(autoload 'highlight-80+ "highlight-80+" nil t)

;Find find in GIT repo
(my-ensure-installed 'find-file-in-git-repo)
(require 'find-file-in-git-repo nil t)
(global-set-key (read-kbd-macro "C-`") 'find-file-in-git-repo)
(global-set-key (kbd "C-S-f") 'find-file-in-git-repo)

; Browse Kill ring
(push "~/.emacs.d/packages/browse-kill-ring" load-path)
(autoload 'browse-kill-ring "browse-kill-ring" "Browse Kill Ring" t)

; Multiple cursors
(push "~/.emacs.d/packages/multiple-cursors" load-path)
(setq mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el")
(autoload 'mc/mark-all-like-this-dwim "multiple-cursors" "Multiple Cursors" t)
(global-set-key (kbd "C-@") 'mc/mark-all-like-this-dwim)

; Expand Region
(push "~/.emacs.d/packages/expand-region" load-path)
(autoload 'er/expand-region "expand-region" "Multiple Cursors" t)
(global-set-key (kbd "C-=") 'er/expand-region)

;Flymake new
(push "~/.emacs.d/packages/emacs-flymake" load-path)
(require 'flymake)

;Ibuffer extras
(my-ensure-installed 'ibuffer-vc)
(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-vc-set-filter-groups-by-vc-root)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

;
(push "~/.emacs.d/packages/markit" load-path)
(require 'markit)
(global-set-key (read-kbd-macro "C-\"") 'markit-mark-region-include)
(global-set-key (read-kbd-macro "C-\'") 'markit-mark-region-exclude)

;
(push "~/.emacs.d/packages/popup-el" load-path)
(push "~/.emacs.d/packages/auto-complete" load-path)
(require 'auto-complete)

;
(my-ensure-installed 'git-gutter)
(autoload 'git-gutter "git-gutter" "Git Gutter" t)

;
(my-ensure-installed 'ack-and-a-half)
(define-key global-map (kbd "C-S-g") 'ack-and-a-half)

;JSON Mode
(my-ensure-installed 'json-mode)
(autoload 'json-mode "json-mode" "JSON Mode" t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

; Github browse file
(my-ensure-installed 'github-browse-file)
(autoload 'github-browse-file "github-browse-file" "Github browse file." t)

; window-number-meta-mode
(my-ensure-installed 'window-number)
(autoload 'window-number-meta-mode "window-number")
(window-number-meta-mode 't)

; perspective
(my-ensure-installed 'perspective)
(require 'perspective)

; Yascroll
(my-ensure-installed 'yascroll)
(global-yascroll-bar-mode 't)

; Ctags
(my-ensure-installed 'ctags-update)
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)
(autoload 'ctags-update "ctags-update" "update TAGS using ctags" t)

;
(my-ensure-installed 'openstack-cgit-browse-file)

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
(autoload 'yas/hippie-try-expand "yasnippet" nil t)
(autoload 'yas/minor-mode "yasnippet" nil t)
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

;RegexTool
(my-ensure-installed 'regex-tool)
(autoload 'regex-tool "regex-tool" "REGEX Tool" t)

; Hightly more than 80
(my-ensure-installed 'highlight-80+)
(autoload 'highlight-80+ "highlight-80+" nil t)

; Browse Kill ring
(my-ensure-installed 'browse-kill-ring)

; Multiple cursors
(my-ensure-installed 'multiple-cursors)
(setq mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el")
(global-set-key (kbd "C-@") 'mc/mark-all-like-this-dwim)

; Expand Region
(my-ensure-installed 'expand-region)
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
(my-ensure-installed 'auto-complete)
(my-ensure-installed 'popup)
(require 'auto-complete)

;
(my-ensure-installed 'git-gutter)

;
(my-ensure-installed 'ack-and-a-half)
(define-key global-map (kbd "C-S-g") 'ack-and-a-half)

;JSON Mode
(my-ensure-installed 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

; Github browse file
(my-ensure-installed 'github-browse-file)

; window-number-meta-mode
(my-ensure-installed 'window-number)
(autoload 'window-number-meta-mode "window-number")
(window-number-meta-mode 't)

; Yascroll
(my-ensure-installed 'yascroll)
(global-yascroll-bar-mode 't)

; Openstack browse current file.
(my-ensure-installed 'openstack-cgit-browse-file)

;; timestamps
(my-ensure-installed 'powerline)
(powerline-default-theme)

(set-face-attribute 'mode-line nil
                    :background "OliveDrab3"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :box nil)

;Boorkmarks
(my-ensure-installed 'bm)
(global-set-key (read-kbd-macro "C-S-t") 'bm-toggle)

;Company mode
(my-ensure-installed 'company)

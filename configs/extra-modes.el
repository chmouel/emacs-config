;RST
(autoload 'rst-mode "rst" "RST" t)
(push '("\\.rst\\'" . rst-mode) auto-mode-alist)

;TodoTXT
(autoload 'todotxt "todotxt" nil t)
(global-set-key (kbd "<f12>") 'todotxt)
(setq todotxt-file (expand-file-name "~/Dropbox/todo/todo.txt"))


;Ensure package is installed
(if (fboundp 'package-initialize)
    (package-initialize))

;Macros for easy package.
(defmacro Package (package &rest body)
  "Install a package if not installed and execute body"
  (declare (indent 1) (debug t))
  `(let ((package-dest ,package))
     (if (fboundp 'package-install)
         (condition-case err
             (progn
               (if (not (package-installed-p package-dest))
                   (package-install package-dest))
               (progn ,@body))
           (message (car err))))))

; For Yas/Snippet
(Package 'yasnippet
  (autoload 'yas/hippie-try-expand "yasnippet" nil t)
  (autoload 'yas/minor-mode "yasnippet" nil t)
  (when (featurep 'yasnippet)
    (yas/global-mode 1)
    (eval-after-load "yasnippet"
      '(progn
         (require 'dropdown-list)
         (setq yas/prompt-functions '(yas/dropdown-prompt))))))

;Flymake
(Package 'flymake-cursor
  (eval-after-load "flymake"
    '(progn
       (require 'flymake-cursor))))

;RegexTool
(Package 'regex-tool
  (autoload 'regex-tool "regex-tool" "REGEX Tool" t))

; Hightly more than 80
(Package 'highlight-80+
  (autoload 'highlight-80+ "highlight-80+" nil t))

; Browse Kill ring
(Package 'browse-kill-ring)

; Multiple cursors
(Package 'multiple-cursors
  (setq mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el")
  (global-set-key (kbd "C-@") 'mc/mark-all-like-this-dwim))

; Expand Region
(Package 'expand-region
  (global-set-key (kbd "C-=") 'er/expand-region))

;Flymake new
(push "~/.emacs.d/packages/emacs-flymake" load-path)
(require 'flymake)

;Ibuffer extras
(Package 'ibuffer-vc
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-vc-set-filter-groups-by-vc-root)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

; Popup for auto-complete and others
(Package 'popup)

; Auto complete in words.
(Package 'auto-complete)

; Git Gutter.
(Package 'git-gutter)

; Ack and Half.
(Package 'ack-and-a-half)

;JSON Mode
(Package 'json-mode
  (add-to-list 'auto-mode-alist '("\\.json$" . json-mode)))

; window-number-meta-mode
(Package 'window-number
  (autoload 'window-number-meta-mode "window-number")
  (window-number-meta-mode 't))

; Yascroll
(Package 'yascroll
  (if (fboundp 'global-yascroll-bar-mode)
      (global-yascroll-bar-mode 't)))

; Github browse current file
(Package 'github-browse-file)

; Openstack browse current file.
(Package 'openstack-cgit-browse-file)

;; timestamps
(Package 'powerline
  (powerline-default-theme)
  (set-face-attribute 'mode-line nil
                      :background "OliveDrab3"
                      :box nil)
  (set-face-attribute 'mode-line-inactive nil
                      :box nil))

;Boorkmarks
(Package 'bm
  (global-set-key (read-kbd-macro "C-S-t") 'bm-toggle))

;Company mode
(Package 'company)

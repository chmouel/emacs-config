;; Save Places
(use-package saveplace :config (setq-default save-place t))

;;Abbrev
(setq
 abbrev-file-name (concat my-init-directory "/auto-save-list/abbrev_defs"))

;; Bookmarks
(setq bookmark-default-file (concat my-init-directory "/auto-save-list/bookmarks.bmk"))

;; Dired
(use-package "dired"
  :ensure nil
  :config
  (require 'dired-x)
  :init
  (defun my-dired-mode-hook ()
    (dired-omit-mode)
    (when (featurep 'tooltip) (tooltip-mode 0)))
  (add-hook 'dired-mode-hook 'my-dired-mode-hook)
  ;; Hack dired to launch files with 'l' key.
  ;; http://omniorthogonal.blogspot.com/2008/05/useful-emacs-dired-launch-hack.html
  (defun my-dired-launch-command ()
    (interactive)
    (dired-do-shell-command
     (case system-type
       (gnu/linux "gnome-open") ;right for gnome (ubuntu), not for other systems
       (darwin "open"))
     nil
     (dired-get-marked-files t current-prefix-arg)))
  :bind
  (:map dired-mode-map
        ("W" . browse-url-of-dired-file)
        ("l" . my-dired-launch-command)
        ("E" . wdired-change-to-wdired-mode)
        ("s" . dired-up-directory)
        ("j" . dired-next-line)
        ("k" . dired-previous-line)))

;; Hippy-Expand
(use-package hippie-exp                 ; Powerful expansion and completion
  :bind (([remap dabbrev-expand] . hippie-expand))
  :config
  (progn
    (setq hippie-expand-try-functions-list
          '(try-expand-dabbrev
            try-complete-file-name-partially
            try-complete-file-name
            try-expand-dabbrev-all-buffers
            try-expand-all-abbrevs
            try-expand-list
            try-expand-line
            try-expand-dabbrev-from-kill
            try-complete-lisp-symbol-partially
            try-complete-lisp-symbol))))

;; Find files already opened
(use-package isearch
  :ensure nil
  :defer t
  :diminish isearch
  :bind (([remap isearch-forward] . endless/isearch-symbol-with-prefix)
         :map isearch-mode-map
         ("C-." . isearch-forward-symbol-at-point)
         ("C-o" . my-isearch-occur))
  :init
  (setq isearch-allow-scroll t)
  :config
  ;; http://endlessparentheses.com/quickly-search-for-occurrences-of-the-symbol-at-point.html
  (defun endless/isearch-symbol-with-prefix (p)
    "Like isearch, unless prefix argument is provided.
With a prefix argument P, isearch for the symbol at point."
    (interactive "P")
    (let ((current-prefix-arg nil))
      (call-interactively
       (if p #'isearch-forward-symbol-at-point
         #'isearch-forward))))

  (defun my-isearch-occur ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; Email With Message-mail
(fset 'mail 'message-mail)
(if (file-exists-p (concat my-init-directory "/gnus/message.el"))
    (load-file (concat my-init-directory "/gnus/message.el")))

;; IBUFFER
(defun my-ibuffer()
  (interactive)
  (ibuffer-list-buffers t)
  (switch-to-buffer-other-window (get-buffer "*Ibuffer*")))

(use-package ibuffer
  :hook ibuffer-auto-mode
  :custom (ibuffer-saved-filter-groups
           (quote (
                   ("default"
                    ("Files" (not mode . dired-mode) (name . "^[^*]"))
                    ("Directories" (mode . dired-mode))))
                  ))
  :bind (("C-~" . my-ibuffer)
         :map ibuffer-mode-map
         ("M-p" . ibuffer-backward-line)))

;; Shell Mode
;(add-hook 'shell-mode-hook '(lambda () (toggle-truncate-lines 1)))
(use-package shell
  :hook ansi-color-for-comint-mode-on
  :config (setq comint-prompt-read-only t
                ansi-color-names-vector ; better contrast colors
                ["black" "red4" "green4" "yellow4"
                 "blue3" "magenta4" "cyan4" "white"]))

;; Comit mode
(add-hook 'comint-mode-hook
          (lambda ()
            (local-set-key
             '[(control meta l)]
             (lambda () (interactive)
               (switch-to-buffer (other-buffer nil))))))

;;  Flyspell mode
(add-hook 'log-edit-mode-hook 'flyspell-mode)

;;  Make execustable scripts.
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

;;  Delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;  Define j/k for scroll up/down on view-mode and derived.
(defun my-view-vi-keys-map (x-map)
  (define-key x-map (read-kbd-macro "S-SPC") 'View-scroll-page-backward)
  (define-key x-map (read-kbd-macro "j") 'View-scroll-line-forward)
  (define-key x-map (read-kbd-macro "k") 'View-scroll-line-backward)
)

(eval-after-load "view" '(my-view-vi-keys-map view-mode-map))
(eval-after-load "man" '(my-view-vi-keys-map Man-mode-map))

;;  M-z redefine to zap-up-to-char
(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-z") 'zap-up-to-char)

;;  Ediff
(setq emerge-diff-options "--ignore-all-space")

;; Compilation colors
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

                                        ;                                       ;
(use-package server                     ; The server of `emacsclient'
  :init (server-mode)
  :diminish (server-buffer-clients . " ⓒ"))
;
(use-package eldoc :diminish eldoc-mode)
(use-package subword :diminish subword-mode)
(use-package autorevert :diminish auto-revert-mode)

;; Which-func
(use-package which-func
  :disabled t
  :init (which-function-mode)
  :custom-face
  (which-func ((((class color) (min-colors 89)) (:foreground "#ffffff" :background "SlateBlue2"))))
  :config
  (setq which-func-unknown "⊥" ; The default is really boring…
        which-func-format
        `((:propertize ("" which-func-current "")
                       local-map ,which-func-keymap
                       face which-func
                       mouse-face mode-line-highlight
                       help-echo "mouse-1: go to beginning\n\
mouse-2: toggle rest visibility\n\
mouse-3: go to end"))))

;;View
(use-package view :diminish (view-mode . "👁"))

;; Grep
(use-package grep
  :defer t
  :config
  (when-let (gnu-find (and (eq system-type 'darwin)
                           (executable-find "gfind")))
    (setq find-program gnu-find))

  (when-let (gnu-xargs (and (eq system-type 'darwin)
                            (executable-find "gxargs")))
    (setq xargs-program gnu-xargs)))

;; Search files on the system
(use-package locate
  :defer t
  :config
  ;; Use mdfind as locate substitute on OS X, to utilize the Spotlight database
  (when-let (mdfind (and (eq system-type 'darwin) (executable-find "mdfind")))
    (setq locate-command mdfind)))

;;  IDO
(defun my-ido-local-keys ()
  "Add my keybindings for ido."
  (define-key ido-completion-map " " 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
  (define-key ido-completion-map "[" 'ido-prev-match)
  (define-key ido-completion-map "]" 'ido-next-match)
  )
(add-hook 'ido-setup-hook 'my-ido-local-keys)

;; Find files already opened
(use-package "files"
  :after ido
  :ensure nil
  :defer t
  :bind (("s-`" . ido-goto-recent-file))
  :config
  (defun ido-goto-recent-file (file)
    (interactive
     (list (let* ((filepaths (let ((items))
			                   (dolist (item recentf-list)
			                     (if (and (stringp item)
					                      (not (string-match ":" item))
					                      (file-regular-p item)
					                      (not (member item items)))
				                     (add-to-list 'items item t)))
			                   items))
                  (filenames (mapcar 'expand-file-name filepaths))
		          (numfilenames (length filenames))
		          ;; get filename from user with ido
		          (chosenfilename (ido-completing-read "Recent file: " filenames))
		          (afterfilenameslist (member chosenfilename filenames))
		          (posinlist (- numfilenames (length afterfilenameslist))))
	         (nth posinlist filepaths))))
    (find-file file)))

;; Recentf
(use-package recentf
  :config
  (setq recentf-save-file "~/.emacs.d/auto-save-list/recent-file-list.el"
        recentf-max-saved-items 500
        recentf-max-menu-items 15)
  (recentf-mode +1))

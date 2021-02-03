;;; init-completion.el ---                           -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Chmouel Boudjnah
;; Author: Chmouel Boudjnah <chmouel@chmouel.com>

;; Prettiness
(use-package marginalia
  :ensure t
  :config
  (setq marginalia-annotators
        '(;; marginalia-annotators-heavy
          marginalia-annotators-light))
  (marginalia-mode 1))

;; Consult
(use-package consult
  :after projectile
  :custom
  (consult-async-default-split "")
  (consult-find-command '("fdfind" "--color=never" "--full-path"))
  (consult-project-root-function #'projectile-project-root)
  :ensure t
  :bind (("M-s o" . consult-outline)
         ("M-s i" . consult-imenu)
         ("M-s g" . consult-grep)
         ("M-g g" . consult-goto-line)
         ("M-s y"   . consult-yank)
         ("C-x r b" . (lambda ()(interactive) (do-ivy-completion 'consult-bookmark)))
         ("C-x C-r" . consult-recent-file))
  ;; ("C-\\" . consult-buffer)
  ;; ("C-x b" . consult-buffer))
  :config
  (defun my-consult-projectile-rg (&optional initial)
    (interactive "P")
    (if (and (eq projectile-require-project-root 'prompt)
             (not (projectile-project-p)))
        (projectile-switch-project)
      (let ((thingapt (if initial (thing-at-point 'symbol) nil))
            (ignored
             (mapconcat (lambda (i)
                          (concat "--glob !" (shell-quote-argument i)))
                        (append
                         (projectile--globally-ignored-file-suffixes-glob)
                         (projectile-ignored-files-rel)
                         (projectile-ignored-directories-rel))
                        " ")))
        (consult-ripgrep (projectile-project-root) thingapt)))))

;;  Disabled
(use-package prescient
  :ensure t
  :config
  (prescient-persist-mode t)
  :custom
  (prescient-sort-length-enable nil)
  (prescient-filter-method '(literal regexp fuzzy)))

;;
(use-package selectrum
  :disabled
  :ensure t
  :bind
  (:map selectrum-minibuffer-map
        ("C-\\" . selectrum-next-candidate)
        ("C-s" . selectrum-next-candidate)
        ("C-n" . selectrum-next-candidate)
        ("C-p" . selectrum-previous-candidate)
        ("<up>" . previous-history-element)
        ("<down>" . next-history-element))
  :custom
  (selectrum-count-style 'nil)
  (selectrum-extend-current-candidate-highlight t))

(use-package selectrum-prescient
  :disabled
  :ensure t
  :after selectrum
  :config
  (selectrum-prescient-mode +1))

;;;; Disabled
;; IDO
(use-package ido
  :disabled
  :after ivy
  :defer t
  :custom
  (ido-enable-last-directory-history t)
  (ido-enable-tramp-completion nil)
  (ido-ignore-directories '("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`\\.svn/"))
  (ido-rotate-file-list-default t)
  (ido-save-directory-list-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/ido.last")))
  (ido-show-dot-for-dired t)
  (ido-use-filename-at-point 'guess)
  (ido-use-url-at-point t)
  (ido-enable-flex-matching t)
  (ido-use-url-at-pointfaces nil)
  :bind
  (:map ido-common-completion-map
        ("C-\\" . ido-next-match)
        :map ido-completion-map
        (" "   . ido-next-match)))

;; Flex IDO
;; flx-ido - advanced flex matching for ido
(use-package flx-ido
  :disabled
  :ensure t
  :config
  (flx-ido-mode 1))

;; Ido Vertical mode
(use-package ido-vertical-mode
  :disabled  
  :ensure t
  :custom
  (ido-max-prospects 10)
  :config
  (ido-vertical-mode 1))

;; Ivy
(use-package ivy
  :ensure t
  :hook (after-init . ivy-mode)
  :bind
  (("C-\\" . ivy-switch-buffer)
   ("C-x C-f" . (lambda ()(interactive) (do-normal-completion 'find-file)))
   ("C-x b" . ivy-switch-buffer)
   :map ivy-minibuffer-map
   ("C-\\" . ivy-next-line))
  :config
  (defun do-normal-completion(func)
    (let ((completion-styles '(flex partial-completion emacs22))
          (completing-read-function #'completing-read-default)
          ;; (completing-read-function #'icomplete-read)
          (completion-in-region-function #'completion--in-region))
      (call-interactively func)))  
  :custom
  (counsel-switch-buffer-preview-virtual-buffers nil)
  (ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (ivy-extra-directories nil)
  (ivy-count-format "")
  (ivy-use-virtual-buffers t))

(use-package all-the-icons-ivy
  :ensure t
  :after (all-the-icons ivy)
  :custom
  (all-the-icons-spacer " ")
  (all-the-icons-ivy-file-commands
   '(counsel-dired-jump
     counsel-find-file
     counsel-file-jump
     counsel-find-library
     counsel-git
     counsel-projectile-find-dir
     counsel-projectile-find-file
     counsel-recentf))
  :config (all-the-icons-ivy-setup))

;; Helm
(use-package helm :ensure t
  :custom
  (helm-buffers-fuzzy-matching t)
  :bind
  ("C-M-y" . helm-show-kill-ring))


;; Counsel
(use-package counsel
  :ensure t
  :after ivy
  :custom
  (setq
   counsel-find-file-ignore-regexp
   (regexp-opt
    (append completion-ignored-extensions (quote (".#")))))
  :bind (("C-h f"   . counsel-describe-function)
         ("M-x" . counsel-M-x)
         ("C-|" . counsel-find-file)
         ("C-h s"   . counsel-describe-function)
         ("C-h v"   . counsel-describe-variable)
         ("C-x 8 RET" . counsel-unicode-char)
         ("C-x r b" . counsel-bookmark)))

;; Ivy integration for Projectile
(use-package counsel-projectile
  :bind
  (("C-c U" . counsel-projectile-rg))
  :hook (counsel-mode . counsel-projectile-mode)
  :init (setq counsel-projectile-grep-initial-input '(ivy-thing-at-point)))

;;; DISABLED
(use-package ivy-prescient
  :ensure t
  :after counsel
  :config
  (ivy-prescient-mode 1))

(use-package amx
  :disabled
  :ensure t
  :init
  (amx-initialize)
  :custom
  ((amx-save-file
    (locate-user-emacs-file
     "auto-save-list/amx-items"))))

;; smex - IDO completion for M-x
(use-package smex
  :disabled
  :ensure t
  :custom
  (smex-save-file
   (locate-user-emacs-file
    "auto-save-list/smex-items")))

(use-package icomplete
  ;; :hook (after-init . fido-mode)
  :custom
  (icomplete-in-buffer t)
  (icomplete-show-matches-on-no-input t)
  (icomplete-tidy-shadowed-file-names t)
  (icomplete-delay-completions-threshold 0)
  :custom-face
  (icomplete-first-match ((t (:foreground "gold" :weight extra-bold))))
  :config
  :bind (:map icomplete-minibuffer-map
              ("C-c C-c" . embark-act)
              ("<return>" . icomplete-force-complete-and-exit)
              ("C-<tab>" . minibuffer-force-complete)
              ("C-\\" . icomplete-forward-completions)
              ("C-s" . icomplete-forward-completions)
              ("C-n" . icomplete-forward-completions)
              ("C-p" . icomplete-backward-completions)))

(use-package icomplete-vertical
  :after icomplete
  :hook (icomplete-mode . icomplete-vertical-mode))

;;; Code:

(provide 'init-completion)
;;; init-completion.el ends here

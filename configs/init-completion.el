;;; init-completion.el ---                           -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Chmouel Boudjnah
;; Author: Chmouel Boudjnah <chmouel@chmouel.com>

;; Helm
(use-package helm :ensure t)

;; IDO
(use-package ido
  :defer t
  :config
  (ido-mode)
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
  :bind
  (:map ido-common-completion-map
        ("C-\\" . ido-next-match)
        :map ido-completion-map
        (" "   . ido-next-match)))

;; Flex IDO
;; flx-ido - advanced flex matching for ido
(use-package flx-ido
  :ensure t
  :custom
  (ido-enable-flex-matching t)
  (ido-use-faces nil)
  :config
  (flx-ido-mode 1))

;; Ido Vertical mode
(use-package ido-vertical-mode
  :ensure t
  :custom
  (ido-max-prospects 10)
  :config
  (ido-vertical-mode 1))

;; Prettiness
(use-package marginalia
  :ensure t
  :config
  (setq marginalia-annotators
        '(marginalia-annotators-heavy
          marginalia-annotators-light))
  (marginalia-mode 1))

                                        ; Use flex for completion-styles
(use-package minibuffer
  :custom
  (completion-styles
   '(basic partial-completion flex)))


;; Ivy
(use-package ivy
  :ensure t
  :bind
  (:map ivy-minibuffer-map
        ("C-\\" . ivy-next-line))
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

;; Counsel
(use-package counsel
  :ensure t
  :after ivy
  :custom
  (setq
   counsel-find-file-ignore-regexp
   (regexp-opt
    (append completion-ignored-extensions (quote (".#")))))
  ;; (regexp-opt completion-ignored-extensions))
  :bind (("C-h f"   . counsel-describe-function)
         ("C-x b"   . counsel-switch-buffer)
         ("C-\\"    . counsel-switch-buffer)
         ("C-x r b" . counsel-bookmark)
         ("M-x"     . counsel-M-x)))

;;; DISABLED
(use-package ivy-prescient
  :disabled
  :ensure t
  :after counsel
  :config
  (ivy-prescient-mode 1))

(use-package icomplete
  :disabled
  :hook (after-init . icomplete-mode)
  :custom
  (icomplete-in-buffer t)
  (icomplete-delay-completions-threshold 0)
  :config
  :bind (:map icomplete-minibuffer-map
              ("<return>" . icomplete-force-complete-and-exit)              
              ("TAB" . icomplete-force-complete)              
              ("C-\\" . icomplete-forward-completions)
              ("C-s" . icomplete-forward-completions)
              ("C-n" . icomplete-forward-completions)
              ("C-p" . icomplete-backward-completions)))

(use-package icomplete-vertical
  :disabled
  :after icomplete
  :hook (icomplete-mode . icomplete-vertical-mode))

(use-package consult
  :disabled
  :ensure t
  :bind (("M-s o" . consult-outline)
         ("M-s i" . consult-imenu)
         ("C-x r b" . consult-bookmark)
         ("C-x b" . consult-buffer)
         ("M-y" . consult-yank-pop)))

;;  Disabled
(use-package prescient
  :disabled
  :ensure t
  :config
  (prescient-persist-mode t)  
  :custom
  (prescient-sort-length-enable nil)
  (prescient-filter-method '(anchored regexp fuzzy)))

;;
(use-package selectrum
  :ensure t
  :disabled
  :custom
  (selectrum-count-style 'nil)
  (selectrum-extend-current-candidate-highlight t)
  :config
  (selectrum-mode))

(use-package selectrum-prescient
  :disabled
  :ensure t
  :after selectrum
  :config
  (selectrum-prescient-mode t))

;;;; Disabled

(use-package amx
  :disabled
  :ensure t
  :init
  (amx-initialize)
  :custom
  ((amx-save-to-file
    (locate-user-emacs-file
     (concat "auto-save-list/amx-items")))))

;; smex - IDO completion for M-x
(use-package smex
  :ensure t
  :disabled
  :custom
  (smex-save-file
   (locate-user-emacs-file
    "auto-save-list/smex-items"))
  :bind (("M-x" . smex)))

;;; Code:

(provide 'init-completion)
;;; init-completion.el ends here

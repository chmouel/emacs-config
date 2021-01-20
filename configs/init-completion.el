;;; init-completion.el ---                           -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Chmouel Boudjnah
;; Author: Chmouel Boudjnah <chmouel@chmouel.com>

;; Helm
(use-package helm :ensure t)

;; IDO
(use-package ido
  :defer t
  :bind
  (:map ido-common-completion-map
        ("C-\\" . ido-next-match)
        :map ido-completion-map
        (" "   . ido-next-match)))

;;; Ido Vertical mode
(use-package ido-vertical-mode
  :ensure t
  :custom
  (ido-max-prospects 10)
  :config
  (ido-vertical-mode 1))

(use-package marginalia
  :ensure t
  :config
  (setq marginalia-annotators
        '(marginalia-annotators-heavy
          marginalia-annotators-light))
  (marginalia-mode 1))

(use-package minibuffer
  :hook (after-init . minibuffer-depth-indicate-mode) ; recursion depth
  :custom
  (enable-recursive-minibuffers t)
  (completion-styles
   '(partial-completion basic flex initials substring))
  (completion-category-overrides
   '((file (styles basic flex initials substring))
     (buffer (styles basic flex initials substring))
     (info-menu (styles basic flex initials substring))))
  (completion-auto-help nil)
  (completion-flex-nospace nil)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t)
  (completion-pcm-complete-word-inserts-delimiters t)
  (completion-show-help nil))

(use-package icomplete
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
  :after icomplete
  :hook (icomplete-mode . icomplete-vertical-mode))

(use-package consult
  :ensure t
  :bind (("M-s o" . consult-outline)
         ("M-s i" . consult-imenu)
         ("C-x r b" . consult-bookmark)
         ("M-y" . consult-yank-pop)))

;;  Disabled
(use-package prescient
  :ensure t
  :disabled
  :config
  (prescient-persist-mode t)  
  :custom
  (prescient-sort-length-enable nil)
  (prescient-filter-method '(anchored simple regexp fuzzy)))

(use-package selectrum
  :ensure t
  :disabled
  :custom
  (selectrum-count-style 'nil)
  (selectrum-extend-current-candidate-highlight t)
  :config
  (selectrum-mode))

(use-package selectrum-prescient
  :ensure t
  :after selectrum
  :disabled
  :config
  (selectrum-prescient-mode t))

;; Ivy
(use-package ivy
  :ensure t
  :disabled
  :config
  (ivy-mode)
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
  :disabled
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

(use-package ivy-prescient
  :ensure t
  :disabled
  :after counsel
  :config
  (ivy-prescient-mode 1))

;; Counsel
(use-package counsel
  :ensure t
  :disabled
  :after ivy
  :custom
  (counsel-find-file-ignore-regexp
   (regexp-opt completion-ignored-extensions))
  :bind (("C-h f"   . counsel-describe-function)
         ("C-x b"   . counsel-switch-buffer)
         ("C-\\"    . counsel-switch-buffer)
         ("C-x r b" . counsel-bookmark)
         ("M-x"     . counsel-M-x)))

;;;; Disabled
;; flx-ido - advanced flex matching for ido
(use-package flx-ido
  :ensure t
  :disabled
  :custom
  (ido-enable-flex-matching t)
  (ido-use-faces nil)
  :config
  (flx-ido-mode 1))

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

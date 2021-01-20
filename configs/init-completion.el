;;; init-completion.el ---                           -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Chmouel Boudjnah

;; Author: Chmouel Boudjnah <chmouel@chmouel.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

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

(use-package prescient
  :ensure t
  :config
  (prescient-persist-mode t)  
  :custom
  (prescient-sort-length-enable nil)
  (prescient-filter-method '(literal fuzzy anchored)))

(use-package marginalia 
  :ensure t
  :init
  (marginalia-mode t)
  ;; When using Selectrum, ensure that Selectrum is refreshed when cycling annotations.
  (advice-add #'marginalia-cycle :after
              (lambda () (when (bound-and-true-p selectrum-mode) (selectrum-exhibit))))
  (setq marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light))
  :bind (:map minibuffer-local-completion-map
              ("C-i" . marginalia-cycle-annotators)))

(use-package selectrum
  :ensure t
  :custom
  (selectrum-count-style 'nil)
  (selectrum-extend-current-candidate-highlight t)
  :config
  (selectrum-mode))

(use-package selectrum-prescient
  :ensure t
  :after selectrum
  :config
  (selectrum-prescient-mode t))

(use-package consult
  :ensure t
  :bind (("M-s o" . consult-outline)
         ("M-s i" . consult-imenu)
         ("C-x r b" . consult-bookmark)
         ("M-y" . consult-yank-pop)))

;;; Ido Vertical mode
(use-package ido-vertical-mode
  :ensure t
  :custom
  (ido-max-prospects 10)
  :config
  (ido-vertical-mode 1))

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

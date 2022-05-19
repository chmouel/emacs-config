;; Copyright Chmouel Boudjnah <chmouel@chmouel.com>
;; Emacs init
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Startup time
(defun chmou-display-startup-time ()
  (message
   "Emacs loaded in %s with %d garbage collections."
   (emacs-init-time)
   gcs-done))

(add-hook 'emacs-startup-hook #'chmou-display-startup-time)


;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(defconst my-gc-cons-threshold (* 1024 1024 1024))
(setq normal-gc-cons-threshold my-gc-cons-threshold)
(setq gc-cons-threshold  (* 128 1024 1024))
(add-hook
'emacs-startup-hook
(lambda () (setq gc-cons-threshold normal-gc-cons-threshold)))


;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "auto-save-list/custom.el" user-emacs-directory))

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Init ELPA
(require 'init-elpa)      ;; Machinery for installing required packages

;; Init Early local
(require 'init-local nil t)

;; Requires
(require 'init-theme)
(require 'init-emacs)
(require 'init-abbrev)
(require 'init-popmark)
(require 'init-functions)
(require 'init-dired)
(require 'init-sessions)
(require 'init-project)

;; Packages
(require 'init-packages)
(require 'init-completion)
(require 'init-vertico)
(require 'init-eshell)
(require 'init-magit)
(require 'init-evil)

;; Programming modes
(require 'init-programming)
(require 'init-flycheck)
(require 'init-yasnippet)
(require 'init-elisp)
(require 'init-python)
(require 'init-lsp)
(require 'init-yaml)
(require 'init-org)
(require 'init-sh)
(require 'init-makefile)
(require 'init-javascript)
(require 'init-markdown)
(require 'init-go)
(require 'init-rust)
(require 'init-web)

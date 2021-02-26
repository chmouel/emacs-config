;; Emacs init
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


;; Startup time
(defun efs/display-startup-time ()
  (message
   "Emacs loaded in %s with %d garbage collections."
   (format
    "%.2f seconds"
    (float-time
     (time-subtract after-init-time before-init-time)))
   gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)


;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(setq normal-gc-cons-threshold (* 20 1024 1024))
(setq gc-cons-threshold  (* 128 1024 1024))
(add-hook
'emacs-startup-hook
(lambda () (setq gc-cons-threshold normal-gc-cons-threshold)))


;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "auto-save-list/custom.el" user-emacs-directory))

(require 'bind-key)

;; Init ELPA
(require 'init-elpa)      ;; Machinery for installing required packages

;; Init Early local
(require 'init-local nil t)

;; Requires
(require 'init-theme)
(require 'init-emacs)
(require 'init-functions)
(require 'init-dired)
(require 'init-packages)
(require 'init-project)
(require 'init-completion)
(require 'init-eshell)
(require 'init-magit)

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
(require 'init-go)
(require 'init-html)

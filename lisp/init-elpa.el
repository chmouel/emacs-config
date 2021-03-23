(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/") t)

(add-to-list
 'package-archives
 '("org" . "https://orgmode.org/elpa/") t)

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;;; Fire up package.el
(setq-default
 use-package-always-defer t
 use-package-always-ensure t)
(package-initialize)

;; My custom packages location to be defined in init-local
(defconst my-swivb-location nil) ;; https://github.com/chmouel/emacs-swivb/
(defconst my-github-browse-remote-location nil) ;; https://git.io/JmpQk

(provide 'init-elpa)

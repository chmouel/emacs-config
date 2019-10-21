;;Chmouel Boudjnah <chmouel@chmouel.com>
;; Initializations variables
(defvar my-init-directory "~/.emacs.d")

;; Initializations Config
(push (expand-file-name (concat my-init-directory "/modes/")) load-path)
(push (expand-file-name (concat my-init-directory "/modes/local")) load-path)

;; Initializations functions
(defun my-load-file(file)
  (let* ((dir (concat my-init-directory "/configs") )
		 (fpath (concat dir "/" file ".el")))
	(if (file-exists-p fpath)(load-file fpath) (format "File %s doen't exit" fpath) )))

(defun my-load-dir(dir)
  (let ((files (directory-files dir nil "\.el$")))
    (while files
      (load-file (concat dir (pop files))))))

(defun my-short-hostname()
  (string-match "[0-9A-Za-z-]+" system-name)
  (substring system-name (match-beginning 0) (match-end 0))
  )

;; Some macros.
(defmacro GUI (&rest x) (list 'if (not (null window-system)) (cons 'progn x)))

;; Loading Packages
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir (expand-file-name (concat my-init-directory "/packages/")))
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;; Custome customize (lol so funny!)
(setq custom-file (concat my-init-directory "/configs/customed.el"))
(load custom-file)

;; Ensure package is installed
(if (fboundp 'package-initialize)
    (package-initialize))

;; use-package
(if (not (fboundp 'use-package))
    (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

;; use-package key chord
(use-package use-package-chords
  :config (key-chord-mode 1))

;; Loading Configs files
(my-load-dir (concat my-init-directory "/configs/"))
(my-load-dir (concat my-init-directory "/configs/programming/"))

;; Loading Host
(if (file-exists-p (downcase (concat my-init-directory "/hosts/" (my-short-hostname) ".el")))
    (load-file (downcase (concat my-init-directory "/hosts/" (my-short-hostname) ".el"))))

(setq initial-major-mode 'markdown-mode)
(setq initial-scratch-message "\
<!--
    Chmouel's scratch buffer,

Useful Keys :

Super-o - Open Project
Super-p - Open Project and jump to a file
Super-i - Open project and grep

Super-g - magit status
Super-f - find file in project
Super-b - switch to a buffer inside this project

-->

")

;; END
(cd (expand-file-name "~/"))
(put 'downcase-region 'disabled nil)
(put 'magit-edit-line-commit 'disabled nil)

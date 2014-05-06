;;Chmouel Boudjnah <chmouel@chmouel.com>
;Initializations variables
(defvar my-init-directory "~/.emacs.d")

;Initializations Config
(push (expand-file-name (concat my-init-directory "/modes/")) load-path)
(push (expand-file-name (concat my-init-directory "/modes/local")) load-path)

;Initializations functions
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

;Loading Packages
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir (expand-file-name (concat my-init-directory "/packages/")))
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;Custome customize (lol)
(setq custom-file (concat my-init-directory "/configs/customed.el"))
(load custom-file)

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


;Loading Configs files
(my-load-dir (concat my-init-directory "/configs/"))
(my-load-dir (concat my-init-directory "/configs/programming/"))

;Loading Host
(if (file-exists-p (downcase (concat my-init-directory "/hosts/" (my-short-hostname) ".el")))
    (load-file (downcase (concat my-init-directory "/hosts/" (my-short-hostname) ".el"))))

;;END
(cd (expand-file-name "~/"))
(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)

;;Chmouel Boudjnah <chmouel@chmouel.com>
;Initializations variables
(defvar my-init-directory "~/.emacs.d")

;Initializations Config
(add-to-list 'load-path (expand-file-name (concat my-init-directory "/modes/")))
(add-to-list 'load-path (expand-file-name (concat my-init-directory "/modes/local")))

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
  (string-match "[0-9A-Za-z]+" system-name)
  (substring system-name (match-beginning 0) (match-end 0))
  )

;; Some macros.
(defmacro GNUEmacs (&rest x) (list 'if (string-match "GNU Emacs" (version)) (cons 'progn x)))
(defmacro GUI (&rest x) (list 'if (not (null window-system)) (cons 'progn x))) 
(defmacro Win (&rest x) (list 'if (string= window-system "w32") (cons 'progn x))) 
(defmacro Work (&rest x) (list 'if (or (string= (my-short-hostname) "paris") (string= (my-short-hostname) "coco")) (cons 'progn x))) 
(defmacro Laptop (&rest x) (list 'if (string= (my-short-hostname) "laptop") (cons 'progn x)))

;Loading Packages
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir (expand-file-name (concat my-init-directory "/packages/")))
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))


;Loading Configs files
(my-load-dir (concat my-init-directory "/configs/"))
(my-load-dir (concat my-init-directory "/configs/programming/"))

;Loading Host
(if (file-exists-p (downcase (concat my-init-directory "/hosts/" (my-short-hostname) ".el")))
    (load-file (downcase (concat my-init-directory "/hosts/" (my-short-hostname) ".el"))))

;;END
(cd (expand-file-name "~/"))


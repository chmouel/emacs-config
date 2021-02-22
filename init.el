;;Chmouel Boudjnah <chmouel@chmouel.com>
;; Initializations Config
(push (locate-user-emacs-file "modes/") load-path)
(push (locate-user-emacs-file "modes/local") load-path)

(defun my-load-dir(dir)
  (let ((files (directory-files dir nil "\.el$")))
    (while files
      (load-file (concat dir (pop files))))))

(defun my-short-hostname()
  (string-match "[0-9A-Za-z-]+" (system-name))
  (substring system-name (match-beginning 0) (match-end 0)))

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;; Load custom file
(setq custom-file (locate-user-emacs-file "configs/customed.el"))
(load custom-file)

;; Loading Configs files
(my-load-dir (locate-user-emacs-file "configs/"))
(my-load-dir (locate-user-emacs-file "configs/programming/"))

;; Loading local host file
(let ((localhostfile
       (locate-user-emacs-file
        (format "hosts/%s.el" (downcase (my-short-hostname))))))
  (if (file-exists-p localhostfile)
      (load-file localhostfile)))

;; END

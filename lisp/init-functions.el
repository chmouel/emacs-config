;; Go to GNUS
(defun my-switch-to-gnus ()
  (interactive)
  (let ((tab-index (or (tab-bar--tab-index-by-name "*Group*") -1)))
    (if (= tab-index -1)
        (progn
          (tab-bar-select-tab tab-index)
          (gnus)))
    (tab-bar-select-tab (1+ tab-index))))
(global-set-key (read-kbd-macro "<f2>") 'my-switch-to-gnus)

;; Duplicate current line down
(defun my-duplicate-region (beg end &optional sep)
  "Duplicate the region"
  (interactive "*r")
  (let ((p (point)))
    (copy-region-as-kill beg end)
    (message "%d" (point))
    (goto-char end)
    (if (stringp sep) (insert sep))
    (yank)
    (goto-char p)))

(defun my-duplicate-line-or-region ()
  "duplicate the region if active otherwise the current line"
  (interactive)
  (if mark-active
      (my-duplicate-region (point) (mark))
    (progn
      (my-duplicate-region
       (point-at-bol)
       (point-at-eol) "\n")
      (forward-line))))
(global-set-key '[(control meta d)] 'my-duplicate-line-or-region)

;; autoindent open-*-lines
(defvar newline-and-indent t)
(defun my-comment-line-or-region ()
  (interactive "*")
  (if (and mark-active transient-mark-mode)
      (comment-or-uncomment-region (region-beginning) (region-end) nil)
    (progn
      (save-excursion
        (move-beginning-of-line nil)
        (set-mark-command nil)
        (move-end-of-line nil)
        (comment-dwim nil)))))
(global-set-key (read-kbd-macro "M-;") 'comment-dwim)

;; http://emacsredux.com/blog/2013/05/30/joining-lines/
(defun my-top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))
(global-set-key (kbd "C-S-j") 'my-top-join-line)

;; http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line] 'smarter-move-beginning-of-line)

;; From http://www.emacswiki.org/emacs/FullScreen#toc23
(defun my-toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; I have a bunch of different 'profiles' for kubernetes by different cluster so
;; i don't mess between things
;; This allow me to set the KUBECONFIG variable between those easily
;; TODO: add the current profile in modeline
(defun my-switch-kubeconfig-env (&optional kubeconfig)
  (interactive
   (list
    (completing-read
     "Kubeconfig: "
     (mapcar
      (lambda (x)
        (replace-regexp-in-string
         "^config\." ""
         (file-name-nondirectory(directory-file-name x))))
      (directory-files-recursively
       (expand-file-name "~/.kube") "^config\.")) nil t )))
  (setq kubeconfig (expand-file-name (format "~/.kube/config.%s" kubeconfig)))
  (if (file-exists-p kubeconfig)
      (setenv "KUBECONFIG" kubeconfig)
    (error "Cannot find kubeconfig: %s" kubeconfig)))

(defun my-search (consult directory)
  (if consult
      (counsel-rg
       (ag/dwim-at-point))
    (let ((search (read-from-minibuffer "Search string: ")))
      (ripgrep-regexp search (expand-file-name directory)))))

(defun my-search-project (&optional arg)
  (interactive "P")
  (my-search arg (projectile-ensure-project (projectile-project-root))))

(defun my-search-here (&optional arg)
  (interactive "P")
  (my-search arg default-directory))

(global-set-key '[(super g)] 'my-search-here)

;;
(defun my/frame-move-resize (position)
  "Resize selected frame to cover exactly 1/3 of screen area, and
   move frame to given third of current screen. Symbol POSITION can
   be either left, center, right."

  (let* ((HEIGHT (display-pixel-height))
         (WIDTH  (display-pixel-width)))
    (pcase position
      ('left   (setf x (* 0 (/ (display-pixel-width) 3))))
      ('center (setf x (* 1 (/ (display-pixel-width) 3))))
      ('right  (setf x (* 2 (/ (display-pixel-width) 3)))))

    (set-frame-size (selected-frame) (/ WIDTH 2) HEIGHT t)
    (set-frame-position (selected-frame) x 0)))

;; Take a url (or replace to the raw one if it's a github url) download and eval it.
(defun my-try-el(url)
  "Quickly try a lisp file downloading and evaluating it"
  (interactive "sEmacs lisp url to retrieve: ")
  (let ((rawurl
         (replace-regexp-in-string
          "/blob" ""
          (replace-regexp-in-string
           "https://github.com" "https://raw.githubusercontent.com" url))))
    (progn
      (switch-to-buffer (url-retrieve-synchronously rawurl))
      (save-excursion
        (goto-char (point-min))
        (delete-region (point) (search-forward "\n\n" nil t)))
      (eval-buffer)
      (emacs-lisp-mode)
      (font-lock-ensure))))

(provide 'init-functions)
;; Go to GNUS
(defun my-switch-to-gnus ()
  (interactive)
  (let ((tab-index (or (tab-bar--tab-index-by-name "*Group*") -1)))
    (if (= tab-index -1)
        (progn
          (tab-bar-select-tab tab-index)
          (gnus)))
    (tab-bar-select-tab (1+ tab-index))))

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

;;https://www.emacswiki.org/emacs/NavigatingParentheses
(defun forward-or-backward-sexp (&optional arg)
  "Go to the matching parenthesis character if one is adjacent to point."
  (interactive "^p")
  (cond ((looking-at "\\s(") (forward-sexp arg))
        ((looking-back "\\s)" 1) (backward-sexp arg))
        ;; Now, try to succeed from inside of a bracket
        ((looking-at "\\s)") (forward-char) (backward-sexp arg))
        ((looking-back "\\s(" 1) (backward-char) (forward-sexp arg))))
(global-set-key (read-kbd-macro "C-=") 'forward-or-backward-sexp)

;; sync
(defun my-sync-dir ()
  (interactive)
  (require 'magit-repos)
  (dolist (repo (magit-list-repos))
    (progn
      (magit-status-setup-buffer repo)
      (unless (magit-anything-modified-p t repo)
        (magit-git-command-topdir "gh repo sync")
        (call-interactively 'magit-fetch-from-upstream)
        (call-interactively 'magit-section-show-level-4-all)))))


;;
(defun my-move-to-biggest (&optional arg)
  "A bit like crux transpose windows (where this function started from) but keep
   the largest window on focus.  If there is more than two window, focus to the
   largest window. if you are already on the largest window then switch to the
   last one (if prefix switch last one + prefix) Like this for i3/sway
   https://git.io/Jy94D or dwm centeredmaster
   https://dwm.suckless.org/patches/centeredmaster/"
  (interactive "p")
  (let ((this-win (selected-window))
        (this-buffer (window-buffer))
        (largest (get-largest-window))
        (this-win-size
         (* (window-total-width) (window-total-height))))
    (if (or (< (count-windows) 1)
            (eq this-win largest))
        (other-window arg)
      (select-window largest))
    (set-window-buffer this-win (current-buffer))
    (set-window-buffer (selected-window) this-buffer)
    (if (> this-win-size
           (* (window-total-width) (window-total-height)))
        (other-window -1))))
(global-set-key (read-kbd-macro "C-c o") 'my-move-to-biggest)



(provide 'init-functions)

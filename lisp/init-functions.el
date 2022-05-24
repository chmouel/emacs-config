;; Go to GNUS
(defun my-switch-to-gnus ()
  "Select the tab or switch to gnus"
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

;;https://www.emacswiki.org/emacs/NavigatingParentheses

;; Sync directories with gh repo sync, gh repo sync is not great, may just adapt
;; in "pure" magit commands
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


;; https://www.reddit.com/r/emacs/comments/rtvpvw/switching_to_a_buffer_of_the_same_mode/hqwvc9l/
(defun my-change-buffer-same-major-mode (change-buffer)
  "Call CHANGE-BUFFER until the current buffer has the initial `major-mode'."
  (let ((initial (current-buffer))
        (mode major-mode))
    (funcall change-buffer)
    (let ((first-change (current-buffer)))
      (catch 'loop
        (while (not (eq major-mode mode))
          (funcall change-buffer)
          (when (eq (current-buffer) first-change)
            (switch-to-buffer initial)
            (throw 'loop t)))))))

(defun my-next-buffer-same-major-mode ()
  "Like `next-buffer' for buffers in the current `major-mode'."
  (interactive)
  (my-change-buffer-same-major-mode 'next-buffer))
(global-set-key (read-kbd-macro "C-M-<right>") 'my-next-buffer-same-major-mode)

(defun my-previous-buffer-same-major-mode ()
  "Like `previous-buffer' for buffers in the current `major-mode'."
  (interactive)
  (my-change-buffer-same-major-mode 'previous-buffer))
(global-set-key (read-kbd-macro "C-M-<left>") 'my-previous-buffer-same-major-mode)

;; adapted from  a SO answer somewhere
(defun my-frame-move-resize (position)
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

;; translated from something I have done on sway with i3ipc
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
(global-set-key (read-kbd-macro "C-S-o") 'my-move-to-biggest)

;; translated from something I have done on sway with i3ipc
(defun my-precious-layouts ()
  "if only one window split in two, two resize the one focused small and the
unfocused big, if 3 grow big the middle one, 1/6 of frame the side ones, if you
have more than 3 then well you better start using resize-window.el "
  (interactive)
  (if (eq (length (window-list)) 1)
      (split-window-right))
  (cond ((eq (length (window-list)) 2)
         ;; can't get window-resize work as expected so let shrink window minus the total frame width
         (shrink-window (- (window-total-width) (/ (frame-width) 4)) t))
        ((eq (length (window-list)) 3)
         (select-window (frame-first-window))
         (shrink-window
          (-(window-total-width) (/ (frame-width) 6)) t)
         (select-window (nth 2 (window-list nil nil (frame-first-window))))
         (shrink-window
          (-(window-total-width) (/ (frame-width) 6)) t)))
  (select-window (get-largest-window)))
(global-set-key (read-kbd-macro "C-c o") 'my-precious-layouts)

(defun my-window-split-toggle ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))
(global-set-key (read-kbd-macro "C-c <DEL>") 'my-window-split-toggle)

(provide 'init-functions)

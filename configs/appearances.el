;;Default appearances
(when (featurep 'tool-bar) (tool-bar-mode -1))
(when (featurep 'scroll-bar) (scroll-bar-mode -1))

(setq frame-resize-pixelwise t          
      ring-bell-function 'ignore
      line-spacing 2
      window-combination-resize t)

(global-font-lock-mode 't)
(delete-selection-mode 't)
(show-paren-mode 't)
(column-number-mode t)
(line-number-mode t)
(display-time-mode -1)

(defun my-replace-git-status (tstr)
  (let* ((tstr (replace-regexp-in-string "Git" "" tstr))
         (first-char (substring tstr 0 1))
         (rest-chars (substring tstr 1))
         (emojified (cond
                     ((string= ":" first-char) ;;; Modified
                      (replace-regexp-in-string "^:" "‼ " tstr))
                     ((string= "-" first-char) ;; No change
                      (replace-regexp-in-string "^-" "ʾ" tstr))
                     (t tstr))))
    (propertize emojified 'face '(:foreground "Light Blue" :weight bold))))
(advice-add #'vc-git-mode-line-string :filter-return #'my-replace-git-status)

(defun add-mode-line-dirtrack ()
  "When editing a file, show the last directory of the current path in the mode
   line."
  (add-to-list 'mode-line-buffer-identification
               '(:eval (propertize (substring
                                    default-directory
                                    (+ 1 (string-match "/[^/]+/$" default-directory)) nil)
                                   'face '(:foreground "#7d7d7d" :slant italic)))))
(add-hook 'find-file-hook 'add-mode-line-dirtrack)


;;Default appearances
(setq frame-title-format
      '("" invocation-name ": "(:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))
(when (featurep 'tool-bar) (tool-bar-mode -1))
(when (featurep 'scroll-bar) (scroll-bar-mode -1))
;; (when (featurep 'menu-bar)(menu-bar-mode -1))

;;; Buffer, Windows and Frames
(setq frame-resize-pixelwise t          ; Resize by pixels
      frame-title-format
      '(:eval (if (buffer-file-name)
                  (abbreviate-file-name (buffer-file-name)) "%b"))
      ;; Size new windows proportionally wrt other windows
      window-combination-resize t)

;;Line Spacing by default
(setq-default line-spacing 2)

;;Modes
(put 'narrow-to-page 'disabled nil)
(global-font-lock-mode 't)
(delete-selection-mode 't)
(show-paren-mode 't)
(column-number-mode -1)
(line-number-mode -1)
(display-time-mode -1)

(advice-add #'vc-git-mode-line-string :filter-return #'my-replace-git-status)
(defun my-replace-git-status (tstr)
  (let* ((tstr (replace-regexp-in-string "Git" "" tstr))
         (first-char (substring tstr 0 1))
         (rest-chars (substring tstr 1)))
    (cond
     ((string= ":" first-char) ;;; Modified
      (replace-regexp-in-string "^:" "⚡️" tstr))
     ((string= "-" first-char) ;; No change
      (replace-regexp-in-string "^-" "✔️" tstr))
     (t tstr))))

(defun add-mode-line-dirtrack ()
  "When editing a file, show the last directory of the current path in the mode
   line."
  (add-to-list 'mode-line-buffer-identification
               '(:eval (propertize (substring
                                    default-directory
                                    (+ 1 (string-match "/[^/]+/$" default-directory)) nil)
                                   'face '(:foreground "#7d7d7d" :slant italic))
                       )))
(add-hook 'find-file-hook 'add-mode-line-dirtrack)

;;Non Customizables
(setq ring-bell-function 'ignore)

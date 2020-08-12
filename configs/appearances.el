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
(column-number-mode 't)
(line-number-mode 't)
(show-paren-mode 't)
(if window-system
    (display-time-mode 't))

;;Non Customizables
(setq ring-bell-function 'ignore)

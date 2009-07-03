; The theme
(require 'color-theme 'nil t)
(when (fboundp 'color-theme-mode) 
  (require 'color-theme-wombat)
  (color-theme-wombat))

;;Default appearances
(setq frame-title-format "Emacs - %b %*") 
(when (featurep 'tool-bar) (tool-bar-mode -1))
(when (featurep 'scroll-bar) (scroll-bar-mode -1))
(when (featurep 'fringe) (fringe-mode -1))
(when (featurep 'menu-bar)(menu-bar-mode -1))

;Line Spacing by default
(setq-default line-spacing 2)

;Modes
(put 'narrow-to-page 'disabled nil)
(global-font-lock-mode 't)
(delete-selection-mode 't)
(column-number-mode 't)
(line-number-mode 't)
(show-paren-mode 't)
(display-time-mode 't)

;Default Frame
(add-to-list 'default-frame-alist '(fullscreen . fullwidth))

;Non Customizables
(setq ring-bell-function 'ignore)

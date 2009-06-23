;; (GUI 
;;  (Work 
;;   (add-to-list 'default-frame-alist '(font . "Sans-12"))
;;  ))
;; (GUI
;;  (Work
;;   (require 'color-theme nil t)
;;   (when (fboundp 'color-theme-mode)  
;;     (defun color-theme-inkpot ()
;;       (interactive)
;;       (color-theme-install
;;        '(color-theme-inkpot
;;          ((foreground-color . "#cfbfad")
;;           (background-color . "#1e1e27")
;;           (border-color . "#3e3e5e")
;;           (cursor-color . "sienna1")
;;           (background-mode . dark))
;;          (region ((t (:background "LightCyan4"))))
;;          (highlight ((t (:background "#404040"))))
;;          (fringe ((t (:background "#16161b"))))
;;          (show-paren-match-face ((t (:background "#606060"))))
;;          (isearch ((t (:bold t :foreground "#303030" :background "#cd8b60"))))
;;          (modeline ((t (:bold t :foreground "#b9b9b9" :background "#3e3e5e"))))
;;          (modeline-inactive ((t (:foreground "#708090" :background "#3e3e5e"))))
;;          (modeline-buffer-id ((t (:bold t :foreground "#b9b9b9" :background "#3e3e5e"))))
;;          (minibuffer-prompt ((t (:bold t :foreground "#708090"))))
;;          (font-lock-builtin-face ((t (:foreground "#c080d0"))))
;;          (font-lock-comment-face ((t (:foreground "#708090")))) ; original inkpot: #cd8b00
;;          (font-lock-constant-face ((t (:foreground "#506dbd"))))
;;          (font-lock-doc-face ((t (:foreground "#cd8b00"))))
;;          (font-lock-function-name-face ((t (:foreground "#87cefa"))))
;;          (font-lock-keyword-face ((t (:bold t :foreground "DarkOrchid"))))
;;          (font-lock-preprocessor-face ((t (:foreground "309090"))))
;;          (font-lock-reference-face ((t (:bold t :foreground "#808bed"))))
;;          (font-lock-string-face ((t (:foreground "#ffcd8b" :background "#404040"))))
;;          (font-lock-type-face ((t (:foreground "#ff8bff"))))
;;          (font-lock-variable-name-face ((t nil)))
;;          (font-lock-warning-face ((t (:foreground "#ffffff" :background "#ff0000")))))))
;;     (color-theme-inkpot))
;;   (setq frame-background-mode 'dark)
;;  )
;; ))

(require 'color-theme nil t)
(when (fboundp 'color-theme-mode) 
  (require 'color-theme-wombat)
  (color-theme-wombat))

(Laptop
 (require 'color-theme nil t)
 (when (fboundp 'color-theme-mode) 
   (color-theme-gnome2))
 (add-to-list 'default-frame-alist '(font . "Monospace-10"))
 )

(Win 
 (add-to-list 'default-frame-alist '(font . "-outline-Lucida Console-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1"))
 )



;;Default appearances
(setq frame-title-format "Emacs - %b %*") 
(when (featurep 'tool-bar) (tool-bar-mode -1))
(when (featurep 'scroll-bar) (scroll-bar-mode -1))
(when (featurep 'fringe) (fringe-mode -1))
(when (featurep 'menu-bar)(menu-bar-mode -1))

(put 'narrow-to-page 'disabled nil)
(global-font-lock-mode 't)
(delete-selection-mode 't)
(column-number-mode 't)
(line-number-mode 't)
(show-paren-mode 't)
(display-time-mode 't)

;Default Frame
;(add-to-list 'default-frame-alist '(fullscreen . fullwidth))

;New Frames
;; (add-to-list 'default-frame-alist 
;;              '(width . 800) 
;;              '(height . 505)
;;              )

;Local
(Win (setq w32-use-full-screen-buffer nil))
(Laptop (display-battery-mode t))


;Non Customizables
(setq ring-bell-function 'ignore)

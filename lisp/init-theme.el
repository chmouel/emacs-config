(use-package ubuntu-theme :after rand-theme)

(use-package doom-themes
  :defer nil
  :custom-face
  (icomplete-first-match ((t (:inherit mode-line-emphasis))))
  ;; (mode-line-buffer-id ((t (:foreground "Light Blue"))))
  ;; (tab-bar-tab ((t (:foreground "orange"))))
  ;; (font-lock-variable-name-face ((t (:foreground "#50fa7b"))))
  ;; (highlight-indentation-face ((t (:inherit default :foreground "#878787"))))
  ;; (hl-line ((t (:background "DodgerBlue4"))))
  )

(use-package rand-theme
  :custom
  (rand-theme-wanted '(ubuntu doom-oceanic-next doom-material doom-horizon doom-palenight doom-vibrant doom-snazzy doom-dracula doom-outrun-electric)))

(use-package doom-modeline
  :defer nil
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

(use-package emacs
  :custom
  (custom-safe-themes 't)
  :init
  (load-theme 'doom-outrun-electric))

(provide 'init-theme)

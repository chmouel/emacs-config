(use-package kaolin-themes)

(use-package doom-themes
  :defer nil
  :custom-face
  (icomplete-first-match ((t (:inherit mode-line-emphasis)))))

(use-package doom-modeline
  :defer nil
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

(use-package emacs
  :custom
  (custom-safe-themes 't)
  :init
  (load-theme 'doom-one))

(provide 'init-theme)

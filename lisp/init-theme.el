(use-package kaolin-themes)

(use-package doom-themes
  :defer nil
  :custom-face
  (icomplete-first-match ((t (:inherit mode-line-emphasis)))))

(use-package doom-modeline
  :defer nil
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

(use-package all-the-icons-completion
  :hook (after-init . all-the-icons-completion-mode))

(use-package emacs
  :custom
  (custom-safe-themes 't)
  :init
  (cond
   ((string= (my-short-hostname) "thebatman")
    (load-theme 'doom-one))
   ((string= (my-short-hostname) "ibra")
    (load-theme 'doom-outrun-electric))))

(provide 'init-theme)

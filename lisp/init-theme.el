(use-package kaolin-themes)

;; Maybe we can do something a bit more smart with those config
(use-package doom-themes
  :defer nil
  :config
  (setq
   doom-one-light-brighter-modeline nil
   doom-one-light-padded-modeline t
   doom-one-light-brighter-comments t
   
   doom-nord-light-brighter-modeline nil
   doom-nord-light-padded-modeline t
   doom-nord-light-brighter-comments t
   
   doom-ayu-light-brighter-comments t
   doom-ayu-light-brighter-modeline nil
   doom-ayu-light-padded-modeline t)
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
  :custom-face
  (tab-bar-tab ((t (:inherit doom-modeline-bar :weight demibold :background nil))))
  :init
  (cond
   ((string= (my-short-hostname) "thebatman")
    (load-theme 'doom-one))
   ((string= (my-short-hostname) "ibra")
    (load-theme 'doom-dark+))
   ((string= (my-short-hostname) "pignon")
    (load-theme 'doom-outrun-electric))
   ((string= (my-short-hostname) "windaube")
    (load-theme 'doom-opera-light))))

(provide 'init-theme)

;; Bufler
(use-package bufler
  :ensure t
  :bind
  (("C-x C-b" . bufler)))

;; Group ibuffer's list by project root
(use-package ibuffer-projectile
  :ensure t
  :after all-the-icons
  :functions all-the-icons-octicon ibuffer-do-sort-by-alphabetic
  :hook ((ibuffer . (lambda ()
                      (ibuffer-projectile-set-filter-groups)
                      (unless (eq ibuffer-sorting-mode 'alphabetic)
                        (ibuffer-do-sort-by-alphabetic)))))
  :config
  (setq ibuffer-projectile-prefix
        (if t
            (concat
             (all-the-icons-octicon "file-directory"
                                    :face ibuffer-filter-group-name-face
                                    :v-adjust 0.0
                                    :height 1.0)
             " ")
          "Project: ")))

(provide 'init-ibuffer)

;; Bufler
(use-package bufler
  :ensure t
  :bind
  (("C-x C-b" . bufler)))

;;; DISABLED
(use-package ibuffer
  :disabled
  :ensure nil
  :bind
  ("C-x C-b" . ibuffer)
  :init
  (setq ibuffer-filter-group-name-face
        '(:inherit (font-lock-string-face bold))))

(use-package all-the-icons-ibuffer
  :ensure t
  :init (all-the-icons-ibuffer-mode 1))

;; Group ibuffer's list by project root
(use-package ibuffer-projectile
  :disabled
  :ensure t
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

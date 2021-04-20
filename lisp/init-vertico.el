;; Enable vertico
(use-package vertico
  :custom-face
  (vertico-current ((t (:foreground "light salmon"))))
  :custom
  (vertico-count-format '())
  :config
  (define-key vertico-map (kbd "C-s") #'vertico-next)
  :init
  (vertico-mode))

(use-package orderless
  :demand t
  :init
  (setq completion-styles '(orderless)
        orderless-component-separator "`"
        completion-category-defaults nil
        completion-category-overrides
        '((file (styles basic flex initials substring))
          (buffer (styles basic flex initials substring))
          (info-menu (styles basic flex initials substring)))))

(provide 'init-vertico)

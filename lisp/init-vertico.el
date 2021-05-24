(use-package orderless
  :demand t
  :custom
  (completion-styles '(orderless))
  (orderless-matching-styles
   '(orderless-strict-leading-initialism
     orderless-regexp
     orderless-prefixes
     orderless-literal))
  (orderless-component-separator " ")
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic flex initials substring))
     (buffer (styles basic flex initials substring))
     (info-menu (styles basic flex initials substring)))))

;; Enable vertico
(use-package vertico
  :custom-face
  (vertico-current ((t (:foreground "red"))))
  :custom
  (vertico-count-format '())
  :config
  (define-key vertico-map (kbd "C-j") #'vertico-exit-input)
  (define-key vertico-map (kbd "C-s") #'vertico-next)
  :init
  (vertico-mode))

(provide 'init-vertico)

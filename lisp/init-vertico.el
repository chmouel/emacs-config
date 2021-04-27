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

;; Enable vertico
(use-package vertico
  :custom-face
  (vertico-current ((t ())))
  :custom
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion)))))
  (vertico-count-format '())
  (completion-styles '(basic partial-completion emacs22 substring flex))
  :init
  (vertico-mode))

;; Use the `orderless' completion style.
;; Enable `partial-completion' for files to allow path expansion.
;; You may prefer to use `initials' instead of `partial-completion'.
(use-package orderless
  :disabled
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))
(provide 'init-vertico)

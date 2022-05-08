(use-package orderless
  :init
  (setq completion-styles '(orderless flex basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion))))
  (setq orderless-matching-styles
        '(orderless-initialism
          orderless-prefixes
          orderless-literal
          orderless-regexp)))

;; Enable vertico
(use-package vertico
  :custom
  (vertico-count-format '())
  :bind
  (:map vertico-map
        ("C-s" . vertico-next)
        ("<return>" . vertico-exit)
        ("<C-return>" . vertico-exit-input)
        ("C-j" . (lambda () (interactive)
	               (if minibuffer--require-match
	        	       (minibuffer-complete-and-exit)
	                 (exit-minibuffer)))))
  :init
  (vertico-reverse-mode t)
  (vertico-mode t))

(use-package vertico-directory
  :ensure nil
  :after vertico
  :bind (:map vertico-map
              ("DEL"   . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word)
              ("C-w"   . vertico-directory-delete-word)
              ("RET"   . vertico-directory-enter)))




(provide 'init-vertico)

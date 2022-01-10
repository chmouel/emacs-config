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

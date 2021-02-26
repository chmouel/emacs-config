;; Flycheck
(use-package flycheck-indicator
  :defer t
  :hook (flycheck-mode . flycheck-indicator-mode)
  :custom
  (flycheck-indicator-status-icons
   '((no-checker . "")
	 (not-checked . "")
	 (running . "*")
	 (finished "")
	 (interrupted "!")
	 (suspicious "!"))))

(use-package flycheck
  :defer t
  :hook
  (prog-mode . flycheck-mode)
  :custom
  ((flycheck-mode-line-prefix "")
   (flycheck-disabled-checkers
	'(go-unconvert
	  html-tidy xml-xmlint
	  emacs-lisp emacs-lisp-checkdoc))
   (flycheck-display-errors-delay 0.2)
   (flycheck-highlighting-mode 'lines))
  :config
  (global-flycheck-mode t))

(use-package flycheck-yamllint
  :after flycheck
  :hook (flycheck-mode  . flycheck-yamllint-setup)
  :ensure t
  :defer t)

(provide 'init-flycheck)

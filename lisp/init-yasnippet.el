;; Yasnippet
(use-package yasnippet
  :defer t
  :hook
  (after-init . yas-global-mode)
  :custom
  (auto-insert-query nil)
  (yas-prompt-functions '(yas-completing-prompt))
  (yas-key-syntaxes '("w_" "w_." "^ "))
  (yas-installed-snippets-dir "~/elisp/yasnippet-snippets")
  (yas-expand-only-for-last-commands nil)

  :config
  (add-hook 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
  ;; Yassnippet
  (defun yas--expand-by-uuid (mode uuid)
	"Exapnd snippet template in MODE by its UUID"
	(yas-expand-snippet
	 (yas--template-content
	  (yas--get-template-by-uuid mode uuid))))

  (defun yas--magit-email-or-default ()
	"Get email from GIT or use default"
	(require 'magit-process)
	(if (magit-toplevel ".")
		(magit-get "user.email")
	  user-mail-address))
  (yas-global-mode 1))

(use-package autoinsert
  :hook
  (after-init . auto-insert-mode)
  :custom
  (auto-insert-query nil)
  (auto-insert-alist nil)
  :config
  (define-auto-insert "\.py"
	'(lambda () (yas--expand-by-uuid 'python-mode "header"))))

(use-package yasnippet-snippets :after yasnippet)

(provide 'init-yasnippet)

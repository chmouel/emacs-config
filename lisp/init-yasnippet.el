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
  (defun yas--magit-email-or-default ()
	"Get email from GIT or use default"
	(if (and (fboundp 'magit-toplevel)
             (magit-toplevel "."))
	    (magit-get "user.email")
	  user-mail-address))
  (yas-global-mode 1))

(use-package yasnippet-snippets :after yasnippet)

(provide 'init-yasnippet)

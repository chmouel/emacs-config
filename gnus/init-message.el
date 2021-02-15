(use-package message
  :mode "\\.eml\\'"
  :hook
  (message-mode . footnote-mode)
  (message-mode . flyspell-mode)
  (message-mode . my-change-background-on-dangerous-mode)
  :bind
  (:map message-mode-map
        ("C-$" . my-change-ispell-local-to-francais)
        ("C-<return>" . my-email-adress-switch)
        ("C-M-m" . expand-abbrev)
        ("M-;" . boxquote-region)
        ("<f2>" . mail-abbrev-insert-alias)
        ("<f8>" . my-ispell-message-and-switch))
  :preface
  (fset 'mail 'message-mail)
  :custom
  (my-email-adresses
   '(("samuel@chmouel.com")
     ("chmouel@chmouel.com")
     ("cboudjna@redhat.com")
     ("chmouel@redhat.com")))
  (message-auto-save-directory "~/Gnus/Mail/drafts")
  (message-directory "~/Gnus/Mail"))

;; Switch Email Adresses
(provide 'init-message)

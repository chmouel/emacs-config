(use-package bbdb
  :ensure t
  :config
  (bbdb-initialize 'gnus 'message)
  (bbdb-mua-auto-update-init 'gnus 'message)

  (add-hook 'message-setup-hook 'bbdb-mail-aliases)
  (setq bbdb-create-hook nil)

  (add-hook 'gnus-started-hook
	        (lambda nil
	          (remove-hook 'gnus-save-newsrc-hook 'bbdb-offer-save)))
  (add-hook 'gnus-save-newsrc-hook 'bbdb-save)
  
  (setq bbdb-offer-save 1                        ;; 1 means save-without-asking
        bbdb-update-records-p 'create            ;; Auto-create
        ;; Only create auto addressbook from this emails groups 
        bbdb-accept-message-alist '(("From" . ".*@\\(gmail\\|google\\|redhat\\)\\.com"))
        bbdb-snarf-rule-default 'mail            ;; Just snarf with mail by default
        bbdb-completion-display-record nil       ;; Don't display bbdb after completion
        bbdb-mail-avoid-redundancy nil           ;; always use full name
        bbdb-add-name 2                          ;; show name-mismatches for 2 secs
        bbdb-add-mails t                         ;; add new addresses to existing...
        bbdb-canonicalize-redundant-mails t      ;; x@foo.bar.cx => x@bar.cx
        bbdb-completion-list t                   ;; complete on anything
        bbdb-complete-mail-allow-cycling  t      ;; cycle through matches
        bbdb-phone-style nil                     ;; No north american
        bbdb-mua-pop-up-window-size 2
        bbdb-mua-pop-up nil
        bbdb-file (expand-file-name "~/Gnus/bbdb")
        bbdb-mua-update-interactive-p '(query . query)
        bbdb-pop-up-layout 'one-line))

(provide 'init-bbdb)

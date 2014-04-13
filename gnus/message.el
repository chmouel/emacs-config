(require 'message)

(setq
 message-auto-save-directory "~/Gnus/Mail/drafts"
 message-directory "~/Gnus/Mail"
)


(push '("\\.eml\\'" . message-mode) auto-mode-alist)

;;Messages
(defun my-message-mode-hook()
  (footnote-mode)
  (flyspell-mode)
  (local-set-key (kbd "C-M-m") 'expand-abbrev)
  (local-set-key (kbd "C--") 'my-snippet-indent-or-complete)
  (local-set-key (read-kbd-macro "M-;") 'boxquote-region)
  (local-set-key (read-kbd-macro "C-;") 'comment-dwim)
  (local-set-key '[(f2)] 'mail-abbrev-insert-alias)
  (local-set-key '[(f8)] 'my-ispell-message-and-switch))
(add-hook 'message-mode-hook 'my-message-mode-hook)

;Switch Email Adresses
(defvar my-email-adresses
  '(("chmouel@openstack.org")
    ("chmouel@chmouel.com")
    ("chmouel.boudjnah@rackspace.co.uk"))
  )
(defun my-email-adress-switch ()
  (interactive)
  (save-excursion
	(let* ((completion-ignore-case t)
		   (item (assoc-ignore-case
				  (completing-read "Email adress: " my-email-adresses nil t)
				  my-email-adresses))
		   (email-adress (car item)))
	  (beginning-of-buffer)
	  (if (re-search-forward "^From:" nil t)
		  (delete-region (point) (progn (end-of-line)(point)))
		(insert "From:"))
	  (insert (concat " " user-full-name " <" email-adress ">"))
	  (if (not (eolp))(insert "\n"))
	  ))
)

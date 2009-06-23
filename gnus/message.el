(require 'message)

(add-to-list 'auto-mode-alist '("core\.rackspace\.com\..*\.txt\\'" . message-mode))

(setq 
 message-auto-save-directory "~/Gnus/Mail/drafts"
 message-directory "~/Gnus/Mail"
)


(add-to-list 'auto-mode-alist '("\\.eml\\'" . message-mode))

(GUI
 (set-face-foreground 'message-header-name "gold1")
 (set-face-foreground 'message-header-to "PaleGreen")
 (set-face-foreground 'message-header-other "PaleGreen")
 (set-face-foreground 'message-header-subject "PaleGreen")
 (set-face-foreground 'message-header-cc "PaleGreen")
 (set-face-foreground 'message-separator "WhiteSmoke")
 (set-face-foreground 'message-cited-text "Hotpink")
 (set-face-attribute 'message-header-subject nil :weight 'bold)
 (set-face-attribute 'message-header-other nil :weight 'bold)
 )


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
  '(("chmouel@chmouel.com") ("cboudjnah@squiz.co.nz") ("chmouel@squiz.net") ("sam@squiz.net") ("cboudjnah@squiz.net")("chmouel@yahoo.fr"))
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


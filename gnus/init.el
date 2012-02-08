;Load Files
(if (file-exists-p (concat my-init-directory "/gnus/filter.el"))
  (load-file (concat my-init-directory "/gnus/filter.el")))

;Default paths
(setq
 gnus-agent-directory "~/Gnus/agent"
 gnus-article-save-directory "~/Gnus/News"
 gnus-cache-directory "~/Gnus/News/cache"
 gnus-directory "~/Gnus/News"
 gnus-home-directory "~/Gnus"
 gnus-kill-files-directory "~/Gnus/News"
 gnus-registry-cache-file "~/Gnus/config/gnus.registry.eld"
 gnus-startup-file "~/Gnus/config/newsrc"
 mail-source-directory "~/Gnus/Mail" 
 nnmail-message-id-cache-file "~/Gnus/config/nnmail-cache"
 )

;Settings
(setq
 mail-user-agent 'gnus-user-agent
 mail-host-address "chmouel.com"
 read-mail-command 'gnus
 gnus-expert-user t
 gnus-visible-headers "^From:\\|^Subject:\\|^Date:\\|^Newsgroups:\\|^X-Mailer:\\|^X-Newsreader:\\|^Organization:\\|^Followup-To:\\|^User-Agent:\\|^To:\\|^Cc:"
 gnus-sorted-header-list '("^From:" "^Subject:" "^Newsgroups:" 
						   "^To:" "^Cc:"  "^Followup-To:" "^Date:" 
						   "^X-Mailer:" "^X-Newsreader:" 
						   "^User-Agent:" 
						   "^Organization:^Approved:")

 gnus-group-line-format "%1M%1S%5y: %(%-50,50G%)\n"
 gnus-topic-display-empty-topics nil
 )

;USE K-J for navigation evil
(defun my-gnus-summary-mode-hook () 
  (local-set-key '[(j)] 'gnus-summary-next-article) 
  (local-set-key '[(k)] 'gnus-summary-prev-article) 
  )
(add-hook 'gnus-summary-mode-hook 'my-gnus-summary-mode-hook)

(setq gnus-thread-sort-functions '(gnus-thread-sort-by-number 
                                   gnus-thread-sort-by-date 
								   gnus-thread-sort-by-subject 
								   gnus-thread-sort-by-total-score))

;HighLine
(require 'hl-line)
(add-hook 'gnus-summary-mode-hook 'my-setup-hl-line)
(add-hook 'gnus-group-mode-hook 'my-setup-hl-line)
(defun my-setup-hl-line () (hl-line-mode 1) (setq cursor-type 'hbar) )
(setq cursor-type 't)

; Colorfull
(require 'gnus-cite)
(require 'mail-parse)

(setq gnus-article-display-hook
      '(gnus-article-de-quoted-unreadable
		gnus-article-emphasize
		gnus-article-hide-boring-headers
		gnus-article-hide-headers-if-wanted
		gnus-article-hide-pgp
		gnus-article-highlight
		gnus-article-highlight-citation
		))

;GET MAIL EVERY 2mn
(gnus-demon-add-handler 'gnus-group-get-new-news 2 t)
(gnus-demon-init)

;Add topic-mode with custom format
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(setq gnus-topic-line-format "%i[ %u&topic-line; ] %v\n")
(defun gnus-user-format-function-topic-line (dummy)
  (let ((topic-face
         (if (zerop total-number-of-articles) 'bold-italic 'bold)))
    (propertize
     (format "%s %d" name total-number-of-articles)
     'face topic-face)))

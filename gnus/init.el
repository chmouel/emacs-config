;Load Files
(if (file-exists-p (concat my-init-directory "/gnus/filter.el"))
  (load-file (concat my-init-directory "/gnus/filter.el")))
(load-file (concat my-init-directory "/gnus/bbdb.el"))

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

(setq sendmail-program "/usr/bin/msmtp")
(setq message-sendmail-extra-arguments '("-a" "rs"))

;Default methods to get mails
(setq gnus-select-method '(nntp "localhost"))
(setq gnus-secondary-select-methods
      '((nnimap "rackspace"
              (nnimap-address "lonmx01"))))

;Archving
(setq gnus-message-archive-group
	  '((if (message-news-p) "sent-news"
		  (concat "sent-mail." (format-time-string "%Y-%m" (current-time))))))

(setq gnus-message-archive-method 
	  '(nnfolder "archive"
				 (gnus-summary-line-format "%U%R%z%I%(%[%4L: %-23,23f%]%) %s\n")
				 (nnfolder-directory   "~/Gnus/Mail/archive")
				 (nnfolder-active-file "~/Gnus/Mail/archive/active")
				 (nnfolder-get-new-mail nil)
				 (nnfolder-inhibit-expiry t)))

;Mime
(setq mm-automatic-display
      '("text/plain" "text/enriched" "text/richtext"
        "image/.*" "text/html" "message/delivery-status" "multipart/.*" "message/rfc822"
        "text/x-patch" "application/pgp-signature" "application/emacs-lisp"))

;Thread and Topic format
(setq
 mail-user-agent 'gnus-user-agent
 mail-host-address "rackspace.co.uk"
 read-mail-command 'gnus
 gnus-expert-user t
 gnus-uncacheable-groups "^nnml"
 gnus-topic-line-format "%i[%(%{%n - %A%}%)]%v\n"
 gnus-summary-line-format "%U%R%I%[%4L: %-15,15n%]%2t %s\n"
 gnus-group-line-format "%1M%1S%5y: %(%-50,50G%)\n"
 gnus-summary-mode-line-format "GNUS: (%g) %Z [%z]"
 gnus-article-mode-line-format "%S"
 gnus-visible-headers "^From:\\|^Subject:\\|^Date:\\|^Newsgroups:\\|^X-Mailer:\\|^X-Newsreader:\\|^Organization:\\|^Followup-To:\\|^User-Agent:\\|^To:\\|^Cc:"
 gnus-sorted-header-list '("^From:" "^Subject:" "^Newsgroups:" 
						   "^To:" "^Cc:"  "^Followup-To:" "^Date:" 
						   "^X-Mailer:" "^X-Newsreader:" 
						   "^User-Agent:" 
						   "^Organization:^Approved:")
 )

(defun gnus-thread-sort-by-thread())
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

(GUI
 (set-face-background 'gnus-summary-selected "ForestGreen")
 (set-face-foreground 'gnus-summary-selected "white")
 (set-face-foreground 'gnus-header-from "PaleGreen")
 (set-face-foreground 'gnus-header-content "PaleGreen")
 (set-face-foreground 'gnus-header-subject "PaleGreen")
 (set-face-foreground 'gnus-header-name "gold1")
)

(setq gnus-article-display-hook
      '(gnus-article-de-quoted-unreadable
		gnus-article-emphasize
		gnus-article-hide-boring-headers
		gnus-article-hide-headers-if-wanted
		gnus-article-hide-pgp
		gnus-article-highlight
		gnus-article-highlight-citation
		))

;Hooks
(defun my-gnus-summary-mode-hook()
  (local-set-key '[(control meta l)] (lambda () (interactive) (switch-to-buffer (other-buffer))))
  (local-set-key '[(control meta b)] 'bookmark-jump))
(add-hook 'gnus-summary-mode-hook 'my-gnus-summary-mode-hook)

(defun my-gnus-group-mode-hook()
  (local-set-key '[(meta f)] (lambda () (interactive) (shell-command "fetchmail")(sleep-for 2)(gnus-group-get-new-news)))
  (local-set-key '[(control meta h)] 'my-nnmail-split-history))
(add-hook 'gnus-group-mode-hook 'my-gnus-group-mode-hook)

(defun my-gnus-article-mode-hook() 
  (when (fboundp 'egocentric-mode)
    (egocentric-mode))
  (local-set-key '[(meta return)] (lambda()(interactive)(browse-url (w3m-anchor)))))
(add-hook 'gnus-article-mode-hook 'my-gnus-article-mode-hook)

;GET MAIL EVERY 2mn
(gnus-demon-add-handler 'gnus-group-get-new-news 2 t)
(gnus-demon-init)

;Add topic-mode
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(setq gnus-topic-line-format "%i[ %u&topic-line; ] %v\n")

;Gnus-parameters
(setq gnus-auto-expirable-newsgroups
           "mail\\.systems\\.*" )

(setq gnus-parameters
	    '(("mail\\.systems\\.cron\\..*"  
		    (gnus-show-threads nil)
			 (gnus-use-scoring nil)
			  (gnus-summary-line-format
               "%U%R%z%I%(%[%d:%-23,23f%]%) %s\n")
              (gcc-self . none))
		  
		  ("mail\\.systems\\.cron\\.check"
		   (gnus-thread-sort-functions '(gnus-thread-sort-by-score
                                         gnus-thread-sort-by-number 
                                         gnus-thread-sort-by-date 
                                         gnus-thread-sort-by-subject 
                                         ))		   
		   )
		  ("mail\\.inbox\\.direct"
		   (gnus-summary-line-format "%U%R%I%[%4L: %-15,15ua%]%2t %s\n")
		   (gcc-self  . none)
		   )
		  ("mail\\.list\\..*" 
		    (total-expire . t)
			 (broken-reply-to . t))
		  ))

;Topic Line
(defun gnus-user-format-function-topic-line (dummy)
  (let ((topic-face
         (if (zerop total-number-of-articles) 'bold-italic 'bold)))
    (propertize
     (format "%s %d" name total-number-of-articles)
     'face topic-face)))
(defun gnus-user-format-function-a (header)
  (let* ((from (gnus-header-from header)))
    (if (string-match gnus-ignored-from-addresses from)
		(let ((recipient (gnus-extra-header 'To)))
		    ;; no recipient, looks like into a newsgroup
		    (if (string= recipient "") (ff-explicit-name from)
			      ;; There is an undisclosed-recipients, looks like posted
			      ;; in a newsgroups and cc: to ourself
			      (if (string= recipient "undisclosed-recipients:;") (concat ">> " (gnus-extra-header 'Newsgroups))
					      ;; There is a disclosed recipient, show its name
					      (concat ">> " (ff-explicit-name recipient)))))
      ;; The sender is not me, show who it is
      (ff-explicit-name from)
      )
    )
  )

(defun ff-explicit-name (email) "Returns a string identity for the
first address in email. The identity is got in bbdb if possible or
from the address itself with mail-extract-address-components. The
sufix \"& al.\" is added if there are more than one address."
  (if email
      (let* ((data (condition-case () (mail-extract-address-components email) (error nil)))
			 (name (car data))
			 (net (car (cdr data))))
		
		(or (and data 
				 (or (and bbdb/gnus-summary-prefer-bbdb-data bbdb/gnus-summary-prefer-real-names
						  (let* ((record (bbdb-search-simple
										  name 
										  (if (and net bbdb-canonicalize-net-hook) (bbdb-canonicalize-address net) net))))
							(and record bbdb/gnus-summary-prefer-real-names (ff-add-al email (bbdb-record-name record)))))
					 (and data (concat (ff-add-al email (or name net email)) ))))
			"**undefined**")
		)
    nil)
  )

(defun ff-add-al (email str) "Returns str if emails does contains only
one address, and str + \"& al.\" if email contains more than one
address"
  (and str
       (if (string-match "," (gnus-mail-strip-quoted-names email)) (concat str " & al.") str)))



;Summary
(defun my-gnus-summary-view-html-alternative-in-mozilla ()
  "Display the HTML part of the current multipart/alternative MIME message
    in mozilla."
  (interactive)
  (save-current-buffer
    (gnus-summary-show-article)
    (set-buffer gnus-article-buffer)
    (let ((file (make-temp-file "html-message-" nil ".html"))
          (handle (cdr (assq 1 gnus-article-mime-handle-alist))))
      (mm-save-part-to-file handle file)
      (browse-url-mozilla (concat "file://" file)))))

(define-key gnus-summary-mode-map [?K ?M]
  'my-gnus-summary-view-html-alternative-in-mozilla)

;
;SPAM
;; (require 'spam)
;; (setq spam-use-bogofilter t) ; I am using bogofilter but there are others
;; (setq gnus-install-group-spam-parameters nil)
;; ;; Here I define general anti-spam things
;; ;; it only say that on exiting all groups matching nnml:private.*,
;; ;; we launch the spam processor and ham processor (using bogofilter)
;; (setq gnus-spam-process-newsgroups
;;     '(("nnml:.*" (gnus-group-spam-exit-processor-bogofilter	;
;; 					        gnus-group-ham-exit-processor-bogofilter)))
;; ;; All messages marked as spam in these groups should go to spambox
;;     gnus-spam-process-destinations '(("nnfolder:.*" "nnfolder:mail.spam")) 
;; ;; and ham found into the spambox should be moved to reclassify group
;;        gnus-ham-process-destinations '(("nnfolder:spam" "nnfolder:mail.reclassify")) 
;;      spam-junk-mailgroups '("mail.spam")
;;      spam-split-group "mail.spam")
;(require 'nnir)
;Searching
;; this corresponds to a topic line format of "%n %A"
;; (defun gnus-user-format-function-topic-line (dummy)
;;   (let ((topic-face 
;; 		 (if (zerop total-number-of-articles) 'bold-italic 'bold)))
;; 	(propertize
;; 	 (format "%s %d" name total-number-of-articles)
;; 	 'face topic-face)))
;; (setq nnir-swish-e-index-file "/home/cboudjnah/Mail/index.swish");
;; (setq nnir-search-engine 'namazu)

;; (require 'gnus-namazu)
;; (gnus-namazu-insinuate)
;; (setq gnus-namazu-make-index-command "mknmz")
;;  (setq gnus-namazu-make-index-arguments
;; 	   '("--all" "--mailnews" "--deny=^.*[^0-9].*$" "--exclude=(SPAM|ham)"))


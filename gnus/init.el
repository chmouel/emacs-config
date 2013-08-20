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

; Browse OpenStack review when found
(defun my-gnus-article-browse-review ()
  (interactive)
  (let (review-url)
    (save-excursion
      (set-buffer gnus-article-buffer)
      (goto-char (point-min))
      (while (re-search-forward (concat "^\\(To view, visit \\)?\\(https://review.openstack.org/[0-9]+\\|https://bugs.launchpad.net/bugs/[0-9]+\\)") nil t)
          (browse-url (match-string-no-properties 2))))))

(defun my-gnus-summary-mode-hook ()
  (local-set-key (read-kbd-macro "M-k") 'my-gnus-article-browse-review)
  (local-set-key '[(\\)] 'my-gnus-article-browse-review)
  ;USE K-J for navigation is evil and that evil is ca
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

; Group parameters.
(setq gnus-parameters
      '(("^gerrit\\.*"
         (highlight-words .  ((": \\(FAILURE\\)" 1 1 error)
                              (": \\(SUCCESS\\)" 1 1 success)
                              (": \\(SKIPPED\\)" 1 1 warning)
                              (": \\(UNSTABLE\\)" 1 1 warning)
                              ("http://logs.openstack.org/.*/check/\\([^/]+\\)/.*FAILURE" 1 1 error)
                              ("Gerrit-.*:" 0 0 button)
                              ("Patch Set [[:digit:]]+: Looks good to me (core reviewer); Approved" 0 0 success)
                              ("Patch Set [[:digit:]]+: Looks good to me (core reviewer)" 0 0 success)
                              ("Patch Set [[:digit:]]+: Looks good to me, but someone else must approve" 0 0 success)
                              ("Patch Set [[:digit:]]+: Doesn't seem to work" 0 0 error)
                              ("Patch Set [[:digit:]]+: Do not merge" 0 0 error)
                              ("Patch Set [[:digit:]]+: I would prefer that you didn't merge this" 0 0 error)
                              ("Patch Set [[:digit:]]+: Works for me" 0 0 success)
                              ("Patch Set [[:digit:]]+: Verified" 0 0 success)
                              ("Patch Set [[:digit:]]+: Approved" 0 0 success)
                              ("^.+ has uploaded a new change for review." 0 0 bold)
                              ("Jenkins has submitted this change and it was merged." 0 0 success))))
        ))


; eNovance
(setq gnus-posting-styles
      '((".*"
         (name "Chmouel Boudjnah")
         (address "chmouel@enovance.com")
         (organization "eNovance"))))

;Load Files
(if (file-exists-p (concat my-init-directory "/gnus/filter.el"))
  (load-file (concat my-init-directory "/gnus/filter.el")))

;Default paths
(setq gnus-agent-directory "~/Gnus/agent"
      gnus-article-save-directory "~/Gnus/News"
      gnus-cache-directory "~/Gnus/News/cache"
      gnus-directory "~/Gnus/News"
      gnus-home-directory "~/Gnus"
      gnus-kill-files-directory "~/Gnus/News"
      gnus-registry-cache-file "~/Gnus/config/gnus.registry.eld"
      gnus-startup-file "~/Gnus/config/newsrc"
      mail-source-directory "~/Gnus/Mail"
      nnmail-message-id-cache-file "~/Gnus/config/nnmail-cache")

;; Install gerrit-download
(Package 'gerrit-download
  (autoload 'gerrit-download-insinuate-gnus "gerrit-download")
  (add-hook 'gnus-startup-hook 'gerrit-download-insinuate-gnus))

;;Settings
(setq gnus-read-newsrc-file nil
      gnus-save-newsrc-file nil
      mail-user-agent 'gnus-user-agent
      mail-host-address "chmouel.com"
      read-mail-command 'gnus
      gnus-expert-user t
      gnus-visible-headers "^From:\\|^Subject:\\|^Date:\\|^Newsgroups:\\|^X-Mailer:\\|^X-Newsreader:\\|^Organization:\\|^Message-Id\\|^Followup-To:\\|^User-Agent:\\|^To:\\|^Cc:"
      gnus-sorted-header-list '("^From:" "^Subject:" "^Newsgroups:"
                                "^To:" "^Cc:"  "^Followup-To:" "^Date:"
                                "^X-Mailer:" "^X-Newsreader:"
                                "^User-Agent:"
                                "^Organization:^Approved:")
                                        ; from jd
      gnus-summary-line-format (concat "%z%U%R %~(max-right 17)~(pad-right 17)&user-date;  "
                                       "%~(max-right 20)~(pad-right 20)f %B%s\n")
      gnus-group-line-format "%1M%1S%5y: %(%-50,50G%)\n"
      gnus-topic-display-empty-topics nil
      gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
      gnus-thread-sort-functions '(gnus-thread-sort-by-number (not gnus-thread-sort-by-date))
      gnus-sum-thread-tree-false-root ""
      gnus-sum-thread-tree-indent " "
      gnus-sum-thread-tree-leaf-with-other "├► "
      gnus-sum-thread-tree-root ""
      gnus-sum-thread-tree-single-leaf "╰► "
      gnus-sum-thread-tree-vertical "│")

(defun my-gnus-article-browse-nnrss-archived-at()
  "Browse nnrss archived at url header"
  (browse-url
   (replace-regexp-in-string
    "\\(\<\\|\>\\)" ""
    (with-current-buffer
        gnus-original-article-buffer
      (message-fetch-field "archived-at"))))  )

(defun my-gnus-artcile-browse-a-regexp-url()
  "Browse some url that we want"
  (article-goto-body)
  (while
      (re-search-forward
       (rx
        (submatch
         (or
          (and "https://review.openstack.org/"
               (one-or-more (any digit)))
          (and
           "https://bugs.launchpad.net/bugs/"
           (one-or-more (any digit)))))) nil t)
    (browse-url (match-string-no-properties 1))))

(defun my-gnus-article-browse-message-id ()
  "Take the message id and browse it with gmane"
  (browse-url
   (concat "http://mid.gmane.org/"
           (message-fetch-field "message-id"))))

; Browse OpenStack review when found
(defun my-gnus-article-browse-something (&optional prefix)
  (interactive "P")
  (gnus-with-article-buffer
    (cond (prefix
           (my-gnus-article-browse-message-id))
          ((string-match "^nntp\\+news\.gwene\.org" gnus-newsgroup-name)
           (my-gnus-article-browse-nnrss-archived-at))
          (t
           (my-gnus-artcile-browse-a-regexp-url)))))

(defun my-gnus-summary-mode-hook ()
  (local-set-key '[(\[)] 'gnus-article-hide-citation-maybe)
  (local-set-key '[(\])] 'my-gnus-article-browse-something))

(add-hook 'gnus-summary-mode-hook 'my-gnus-summary-mode-hook)


(setq gnus-thread-sort-functions '(gnus-thread-sort-by-score
                                   gnus-thread-sort-by-date
								   gnus-thread-sort-by-subject
								   gnus-thread-sort-by-total-score))

(defun my-article-mode-hook()
  (set-fringe-style 1))
(add-hook 'gnus-article-mode-hook 'my-article-mode-hook)

;HighLine
(require 'hl-line)
(add-hook 'gnus-summary-mode-hook 'my-setup-hl-line)
(add-hook 'gnus-group-mode-hook 'my-setup-hl-line)
(defun my-setup-hl-line () (hl-line-mode 1) (setq cursor-type 'hbar) )
(setq cursor-type 't)

; Colours!
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
                                        ; Those come with the excelent jd's gnus configuration.
      '(("^gerrit\\.*"
         (highlight-words .  (("Build failed" 0 0 error)
                              ("Jenkins has submitted this change and it was merged." 0 0 success)
                              ("Gerrit-Project: \\(.*\\)" 1 1 font-lock-comment-face)
                              ("^.+ has uploaded a new change for review." 0 0 bold)

                              ("^-\s+\\([^ ]+\\).*\\(FAILURE\\)" 1 1 error)
                              ("^-\s+\\([^ ]+\\).*\\(SUCCESS\\)" 1 1 success)

                              ("Workflow\\+[[:digit:]]" 0 0 success)
                              ("Workflow-[[:digit:]]" 0 0 error)
                              (".*\\(\\(Code-Review\\|Verified\\)-[[:digit:]]+\\).*" 1 1 error)
                              (".*\\(\\(Code-Review\\|Verified\\)\\+[[:digit:]]+\\).*" 1 1 success)
                              )))))
;;
(Package 'bbdb
  (bbdb-initialize 'gnus 'message)
  (bbdb-mua-auto-update-init 'gnus 'message)

  (add-hook 'message-setup-hook 'bbdb-mail-aliases)

  (setq bbdb-offer-save 1                        ;; 1 means save-without-asking
        bbdb-update-records-p 'create            ;; Auto-create
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
        bbdb-mua-update-interactive-p '(query . query)
        bbdb-pop-up-layout 'one-line))


;;JD-Gnus desktop notifications
(when (string-equal system-type "darwin")
  (defun jd:xml-unescape-string (string)
    (with-temp-buffer
      (insert string)
      (dolist (substitution '(("&amp;" . "&")
                              ("&lt;" . "<")
                              ("&gt;". ">")
                              ("&apos;" . "'")
                              ("&quot;" . "\"")))
        (goto-char (point-min))
        (while (search-forward (car substitution) nil t)
          (replace-match (cdr substitution) t t nil)))
      (buffer-string)))
  (defun notifications-notify (&rest params)
    (let ((title (plist-get params :title))
          (body (plist-get params :body)))
      (call-process "terminal-notifier" nil nil nil
                    "terminal-notifier"
                    "-contentImage" (or (plist-get params :image-path) "")
                    "-appIcon" (or (plist-get params :app-icon) "")
                    "-message" (jd:xml-unescape-string body)
                    "-title" (jd:xml-unescape-string title)
                    "-activate" "org.gnu.Emacs"
                    "-sender" "org.gnu.Emacs"))))
(add-hook 'gnus-after-getting-new-news-hook 'gnus-notifications)

;; Gravatar
(require 'gnus-gravatar)
(add-hook 'gnus-article-prepare-hook 'gnus-treat-from-gravatar)

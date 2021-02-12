;; Load Files
(if (file-exists-p (concat my-init-directory "/gnus/filter.el"))
    (load-file (concat my-init-directory "/gnus/filter.el")))

;; Default paths
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

;; W3m
(use-package w3m
  :ensure t
  :custom
  (mm-inline-text-html-with-images t)
  (mm-text-html-renderer 'gnus-w3m))

;; Gravatar
(use-package gnus-gravatar
  :ensure nil
  :hook
  (gnus-article-prepare-hook . gnus-treat-from-gravatar))

;;Settings
(setq gnus-summary-ignore-duplicates t
      gnus-suppress-duplicates t
      gnus-read-newsrc-file nil
      gnus-save-newsrc-file nil
      gnus-novice-user nil
      mail-user-agent 'gnus-user-agent
      message-dont-reply-to-names message-alternative-emails
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
      gnus-topic-display-empty-topics nil
      gnus-topic-line-format "%i[ %(%{%n%}%) -- %A ]%v
"
      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
      gnus-thread-sort-functions '(gnus-thread-sort-by-number (not gnus-thread-sort-by-date))
      gnus-sum-thread-tree-false-root ""
      gnus-sum-thread-tree-indent " "
      gnus-sum-thread-tree-leaf-with-other "├► "
      gnus-sum-thread-tree-root ""
      gnus-sum-thread-tree-single-leaf "╰► "
      gnus-sum-thread-tree-vertical "│")

(defun my-gnus-summary-mode-hook ()
  (local-set-key "j" 'gnus-summary-next-article)
  (local-set-key
   (kbd "Y")
   (lambda ()
     (interactive)
     (gnus-summary-delete-article)
     (gnus-summary-next-article
      nil (and gnus-auto-select-same
               (gnus-summary-article-subject)))))
  (local-set-key (kbd "C-o") (lambda ()(interactive) (org-capture nil "t")))
  (local-set-key '[(\[)] 'gnus-article-hide-citation-maybe))
(add-hook 'gnus-summary-mode-hook 'my-gnus-summary-mode-hook)

(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-score
        gnus-thread-sort-by-date
		gnus-thread-sort-by-subject
		gnus-thread-sort-by-total-score))

(defun my-article-mode-hook()
  (local-set-key (kbd "s-g") (lambda ()(interactive) (google-this t t)))
  (set-fringe-style 1))
(add-hook 'gnus-article-mode-hook 'my-article-mode-hook)

(defun gnus-user-format-function-d (arg)
  (let ((group gnus-tmp-decoded-group) (group-name))
    (emojify-string
     (cond
      ((cdr
        (cl-assoc-if
         (lambda (regexp) (string-match regexp group))
         my-group-name-map)))
      (t (replace-regexp-in-string ".*/" "" group))))))

;; Remove the backlash of GMAIL folders labels thingy
(defun gnus-user-format-function-mapped (group) ()
       (let ((mapped-name (assoc group my-group-name-map)))
         (if (null mapped-name) group
           (cdr mapped-name))))

(defun gnus-user-format-function-g (arg)
  (let ((splitted
         (cdr (split-string-and-unquote gnus-tmp-group "/"))))
    (if splitted
        (gnus-user-format-function-mapped
         (combine-and-quote-strings
          (cdr (split-string-and-unquote gnus-tmp-group "/")) "."))
      (gnus-user-format-function-mapped gnus-tmp-group))))
(setq gnus-group-line-format "%M%S%p%P%5y:%B%(%ug%)\n")

(defun my-gnus-group-mode-hook ()
  (define-key gnus-topic-mode-map "TAB" 'gnus-topic-select-group)
  (local-set-key "TAB" 'gnus-topic-select-group)
  (local-set-key
   (kbd "S R")
   (lambda()
     (interactive)
     (async-shell-command "systemctl --user start mbsync.timer; systemctl --user start mbsync-perso.timer;journalctl --lines=30 --no-pager --user -x -u mbsync-perso.service -u mbsync.service")))
  (local-set-key "j" 'next-line)
  (local-set-key "k" 'previous-line))
(add-hook 'gnus-group-mode-hook 'my-gnus-group-mode-hook)

;; HighLine
(use-package hl-line
  :ensure nil
  :hook
  (gnus-summary-mode-hook . my-setup-hl-line)
  (gnus-group-mode-hook . my-setup-hl-line)
  :config
  (defun my-setup-hl-line ()
    (hl-line-mode 1)
    (setq-local cursor-type 'hbar)))

;; Colours!
(require 'gnus-cite)
(require 'mail-parse)

(setq gnus-article-display-hook
      '(gnus-article-de-quoted-unreadable
		gnus-article-emphasize
		gnus-article-hide-boring-headers
		gnus-article-hide-headers-if-wanted
		gnus-article-hide-pgp
		gnus-article-highlight
		gnus-article-highlight-citation))

;; Highlight
(use-package hl-line
  :defer t
  :after gnus
  :hook
  (gnus-summary-mode . my-setup-hl-line)
  ;; (gnus-group-mode . my-setup-hl-line)
  :custom-face
  (hl-line ((t (:background "#44475a" :foreground "#bd93f9"))))
  :config
  (defun my-setup-hl-line ()
    (hl-line-mode 1)
    (setq-local cursor-type nil)
    (visual-line-mode 1)))

(defun gnus-demon-scan-mail-or-news-and-update (level)
  "Scan for new mail, updating the *Group* buffer."
  (let ((win (current-window-configuration)))
    (unwind-protect
        (save-window-excursion
          (save-excursion
            (when (gnus-alive-p)
              (save-excursion
                (set-buffer gnus-group-buffer)
                (gnus-group-get-new-news level)))))
      (message "scanning for new mail done")
      (set-window-configuration win))))

(defun gnus-demon-scan-news-and-update ()
  "Scan for new mail, updating the *Group* buffer."
  (gnus-demon-scan-mail-or-news-and-update 1))

;;; ** command
(gnus-demon-add-handler 'gnus-group-get-new-news 2 t)
;; (gnus-demon-add-handler 'gnus-demon-scan-news-and-update 1 nil)
(gnus-demon-add-handler 'gnus-demon-scan-mail 1 nil)
(gnus-demon-init)

;; Add topic-mode with custom format
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(setq gnus-topic-line-format "%i[ %u&topic-line; ] %v\n")
(setq gnus-topic-indent-level 2)
(defun gnus-user-format-function-topic-line (dummy)
  (let ((topic-face
         (if (zerop total-number-of-articles) 'bold-italic 'bold)))
    (propertize
     (format "%s %d" name total-number-of-articles)
     'face topic-face)))

;;
(use-package bbdb
  :ensure t
  :config
  (bbdb-initialize 'gnus 'message)
  (bbdb-mua-auto-update-init 'gnus 'message)

  (add-hook 'message-setup-hook 'bbdb-mail-aliases)
  (setq bbdb-create-hook nil)
  (add-hook 'bbdb-create-hook (lambda (interactive) (bbdb-save nil)))
  (setq bbdb-offer-save 1                        ;; 1 means save-without-asking
        bbdb-update-records-p 'create            ;; Auto-create
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

;; Export the unread inbox as json to plug into external command line
;; emacsclient --eval "(my-is-there-any-mail-out-there-json)"|sed -e \
;;              's/^"//;s/"$//' -e 's/\\"/"/g'|jq
(defconst my-is-there-any-mail-out-there-limit-to ".*")
(defun my-is-there-any-mail-out-there-json ()
  (interactive)
  (let ((win (current-window-configuration))
        (hashtb (make-hash-table :size 20 :test #'equal))
        unread current)
    (unwind-protect
        (save-window-excursion
          (when (gnus-alive-p)
            (with-current-buffer gnus-group-buffer
              (beginning-of-buffer)
              (while (and (not (eobp)))
                (beginning-of-line)
                (when (and
                       (get-text-property (point) 'gnus-group)
                       (string-match
                        my-is-there-any-mail-out-there-limit-to
                        (gnus-group-name-at-point)))
                  (setq unread (get-text-property (point) 'gnus-unread))
                  (when (and (numberp unread) (> unread 0))
                    (let ((gnus-tmp-group (gnus-group-name-at-point)))
                      (puthash (gnus-user-format-function-g gnus-tmp-group) unread hashtb))))
                (forward-line)))))
      (set-window-configuration win))
    (json-serialize hashtb)))

(defun my-is-there-any-mail-out-there-focus-group (group-regexp)
  (let ((win (current-window-configuration))
        found)
    (unwind-protect
        (save-window-excursion
          (save-excursion
            (when (gnus-alive-p)
              (save-excursion
                (set-buffer gnus-group-buffer)
                (goto-char (point-min))
                (when (re-search-forward group-regexp)
                  (setq found (point))
                  ))))))
    (if found (progn
                (switch-to-buffer gnus-group-buffer)
                (goto-char found)
                (gnus-group-select-group)
                (gnus-summary-first-unread-article))
      (set-window-configuration win))))


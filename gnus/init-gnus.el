;;TOTRASH
(use-package gnus
  :hook
  (gnus-group-mode . gnus-topic-mode)
  (gnus-article-mode-hook . (lambda()(interactive)(set-fringe-style 1)))
  (gnus-started . emacs-lock-mode)
  :defer t
  :custom
  ;; Global settings
  (gnus-suppress-duplicates t)
  (gnus-read-newsrc-file nil)
  (gnus-save-newsrc-file nil)
  (gnus-novice-user nil)
  (mail-user-agent 'gnus-user-agent)
  (message-dont-reply-to-names message-alternative-emails)
  (read-mail-command 'gnus)
  (gnus-expert-user t)
  ;; Article
  (gnus-visible-headers "^From:\\|^Subject:\\|^Date:\\|^Newsgroups:\\|^X-Mailer:\\|^X-Newsreader:\\|^Organization:\\|^Message-Id\\|^Followup-To:\\|^User-Agent:\\|^To:\\|^Cc:")
  (gnus-sorted-header-list
   '("^From:" "^Subject:" "^Newsgroups:"
     "^To:" "^Cc:"  "^Followup-To:" "^Date:"
     "^X-Mailer:" "^X-Newsreader:"
     "^User-Agent:"
     "^Organization:^Approved:"))
  ;; Gnus Summary display
  (gnus-topic-line-format "%i[ %u&topic-line; ] %v\n")
  (gnus-topic-indent-level 2)
  (gnus-summary-ignore-duplicates t)
  (gnus-summary-line-format (concat "%z%U%R %~(max-right 17)~(pad-right 17)&user-date;  "
                                    "%~(max-right 20)~(pad-right 20)f %B%s\n"))
  (gnus-topic-display-empty-topics nil)
  (gnus-topic-line-format "%i[ %(%{%n%}%) -- %A ]%v\n")
  (gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references)
  (gnus-thread-sort-functions
   '(gnus-thread-sort-by-total-score
     (not gnus-thread-sort-by-date)))
  (gnus-sum-thread-tree-false-root "")
  (gnus-sum-thread-tree-indent " ")
  (gnus-sum-thread-tree-leaf-with-other "├► ")
  (gnus-sum-thread-tree-root "")
  (gnus-sum-thread-tree-single-leaf "╰► ")
  (gnus-sum-thread-tree-vertical "│")  
  ;; Default paths
  (gnus-agent-directory "~/Gnus/agent")
  (gnus-article-save-directory "~/Gnus/News")
  (gnus-cache-directory "~/Gnus/News/cache")
  (gnus-directory "~/Gnus/News")
  (gnus-home-directory "~/Gnus")
  (gnus-kill-files-directory "~/Gnus/News")
  (gnus-registry-cache-file "~/Gnus/config/gnus.registry.eld")
  (gnus-startup-file "~/Gnus/config/newsrc")
  (mail-source-directory "~/Gnus/Mail")
  (nnmail-message-id-cache-file "~/Gnus/config/nnmail-cache")  
  ;; Article Display
  (gnus-article-display-hook
   '(gnus-article-de-quoted-unreadable
     gnus-article-emphasize
     gnus-article-hide-boring-headers
     gnus-article-hide-headers-if-wanted
     gnus-article-hide-pgp
     gnus-article-highlight
     gnus-article-highlight-citation))  
  :bind
  (
   :map gnus-summary-mode-map
   ("j" . gnus-summary-next-article)
   ("Y" . (lambda ()
            (interactive)
            (gnus-summary-delete-article)
            (gnus-summary-next-article
             nil (and gnus-auto-select-same
                      (gnus-summary-article-subject)))))
   ("C-o" . (lambda ()(interactive) (org-capture nil "t")))
   ("\[" . gnus-article-hide-citation-maybe)

   :map gnus-article-mode-map
   ("s-g" . (lambda ()(interactive) (google-this t t)))
   
   :map gnus-group-mode-map
   ("TAB" . gnus-group-select-group)
   ;; ("j" . next-line)
   ;; ("k" . previous-line)
   ("S R" .
    (lambda()
      (interactive)
      (async-shell-command
       (concat "systemctl --user start mbsync.timer; "
               "systemctl --user start mbsync-perso.timer; sleep 5;"
               "journalctl --lines=30 --no-pager --user -x "
               "-u mbsync-perso.service -u mbsync.service")))))
  :config
  ;; A three pane layout, Group buffer on the left, summary buffer top-right,
  ;; article buffer bottom-right:
  ;; https://www.emacswiki.org/emacs/GnusWindowLayout
  (gnus-add-configuration
   '(article
     (horizontal 1.2
	             (vertical 25
			               (group 1.0))
	             (vertical 1.0
			               (summary 0.25 point)
			               (article 1.0)))))
  (gnus-add-configuration
   '(summary
     (horizontal 1.2
	             (vertical 25
			               (group 1.0))
	             (vertical 1.0
			               (summary 1.0 point)))))

  (gnus-demon-add-handler 'gnus-group-get-new-news 2 t)
  (gnus-demon-add-handler 'gnus-demon-scan-mail 1 nil)
  (gnus-demon-init)
  :custom-face
  (message-header-name ((t (:foreground "#bd93f9" :weight bold))))
  (message-header-other ((t (:foreground "white"))))
  (message-header-subject ((t (:foreground "grey75" :weight normal)))))

;; W3M
(use-package w3m
  :ensure t
  :custom
  (mm-inline-text-html-with-images t)
  (mm-text-html-renderer 'gnus-w3m))

;; Highlight
(use-package hl-line
  :defer t
  :hook
  (gnus-summary-mode . my-setup-hl-line)
  (gnus-summary-mode . hl-line-mode)
  :custom-face
  (hl-line ((t (:background "#44475a" :foreground "#bd93f9"))))
  :config
  (defun my-setup-hl-line ()
    (setq-local cursor-type nil)))

;; Gravatar
(use-package gnus-gravatar
  :ensure nil
  :hook
  (gnus-article-prepare-hook . gnus-treat-from-gravatar))

;; Load all files in gnus directory
(mapc
 'load
 (seq-filter
  (lambda (x)
    (not (string= (file-name-nondirectory x) "init.el")))
  (file-expand-wildcards (concat user-emacs-directory "gnus/*.el"))))
;;

(provide 'init-gnus)

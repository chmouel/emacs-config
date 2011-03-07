
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ack-executable "/usr/bin/ack-grep")
 '(all-christian-calendar-holidays t)
 '(anything-c-adaptive-history-file "~/.emacs.d/auto-save-list/anything-c-adaptive-history")
 '(auto-insert-directory "~/.emacs.d/snippets/autoinsert/")
 '(auto-insert-mode t)
 '(auto-insert-query nil)
 '(auto-install-directory "~/.emacs.d/modes/")
 '(battery-mode-line-format "--[%b%p%%]")
 '(bc-bookmark-file "~/.emacs.d/auto-save-list/breadcrumb.el")
 '(bookmark-save-flag 1)
 '(c-basic-offset 4)
 '(calendar-christian-all-holidays-flag t)
 '(canlock-password "38ebb79c7f0ece35d1103834941558b48e754833")
 '(compilation-ask-about-save nil)
 '(completion-ignored-extensions (quote (".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".pyc" ".pyo" ".gitignore" ".class")))
 '(completion-styles (quote (basic partial-completion emacs22 initials)))
 '(custom-enabled-themes (quote (tango-dark)))
 '(default-major-mode (quote text-mode) t)
 '(delete-by-moving-to-trash t)
 '(diff-switches "-uw")
 '(dired-auto-revert-buffer (quote dired-directory-changed-p))
 '(dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^Thumbs.db$\\|\\.svn$\\|\\.git\\(ignore\\)?\\|\\.pyc$\\|^\\.coverage$\\|^TAGS$\\|^tags$\\|\\.class$\\|\\.DS_Store\\|\\.localized$")
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(display-time-world-list (quote (("Europe/London" "London") ("Europe/Paris" "Paris") ("America/Chicago" "San Antonio"))))
 '(doc-view-continuous t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(electric-pair-mode t)
 '(elscreen-tab-width 23)
 '(enable-local-variables :all)
 '(erc-away-nickname "chmouel_away")
 '(erc-email-userid "chmouel@chmouel.com")
 '(erc-hide-list (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE")))
 '(erc-hide-timestamps t)
 '(erc-input-line-position -2)
 '(erc-insert-away-timestamp-function (quote erc-insert-timestamp-left))
 '(erc-keywords (quote ("chmou")))
 '(erc-log-channels-directory "~/.irclogs")
 '(erc-log-insert-log-on-open t)
 '(erc-modules (quote (autojoin button completion irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring scrolltobottom services spelling track)))
 '(erc-nick "chmouelb")
 '(erc-nicklist-use-icons nil)
 '(erc-nickserv-identify-mode (quote autodetect))
 '(erc-nickserv-passwords (quote ((freenode (("chmouelb" . ""))))) t)
 '(erc-pals (quote ("cyanogen")))
 '(erc-port 6667)
 '(erc-prompt "->")
 '(erc-prompt-for-password nil)
 '(erc-server "irc.freenode.org")
 '(erc-services-mode t)
 '(erc-system-name "frenchy.rackspace.co.uk")
 '(erc-track-enable-keybindings t)
 '(erc-user-full-name "Chmouel Boudjnah")
 '(eshell-directory-name "~/.emacs.d/auto-save-list/eshell/")
 '(eshell-modules-list (quote (eshell-alias eshell-banner eshell-basic eshell-cmpl eshell-dirs eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-rebind eshell-script)))
 '(flymake-start-syntax-check-on-newline nil)
 '(font-use-system-font t)
 '(gnus-init-file "~/.emacs.d/gnus/init.el")
 '(grep-scroll-output t)
 '(grep-window-height 10)
 '(gud-tooltip-echo-area t)
 '(hippie-expand-try-functions-list (quote (yas/hippie-try-expand try-complete-file-name-partially try-complete-file-name try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-all-abbrevs try-expand-list try-expand-line try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(hl-line-sticky-flag nil)
 '(home-end-enable t)
 '(html-inlined-install-modes (quote (nxml-mode nxhtmlmode html-mode php-mode)))
 '(html-inlined-key [f12])
 '(ibuffer-always-compile-formats t)
 '(ibuffer-elide-long-columns t)
 '(ibuffer-expert t)
 '(ibuffer-formats (quote ((mark modified read-only " " (name 18 -1 :left) " " (size 9 -1 :right) " " (mode 16 16 :left :elide) " " filename-and-process) (mark " " (name 16 -1) " " filename))))
 '(ibuffer-never-show-predicates nil nil (ibuf-ext))
 '(ibuffer-show-empty-filter-groups nil)
 '(ibuffer-truncate-lines nil)
 '(ibuffer-use-other-window nil)
 '(ido-enable-last-directory-history nil)
 '(ido-enable-tramp-completion nil)
 '(ido-everywhere t)
 '(ido-ignore-directories (quote ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`\\.svn/")))
 '(ido-mode (quote buffer) nil (ido))
 '(ido-save-directory-list-file "~/.emacs.d/auto-save-list/ido.last")
 '(ido-show-dot-for-dired t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(igrep-options "-I")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-extra-args (quote ("--sug-mode=ultra")) t)
 '(ispell-message-dictionary-alist (quote (("^To:[^\\n,]+\\\\.fr[ \\t\\n,>]" . "francais"))))
 '(ispell-program-name "aspell" t)
 '(iswitchb-mode nil)
 '(jabber-alert-message-hooks (quote (jabber-message-echo jabber-message-scroll)))
 '(jabber-alert-presence-hooks (quote (jabber-presence-update-roster)))
 '(jabber-connection-type (quote starttls))
 '(jabber-history-enabled t)
 '(jabber-mode-line-mode t)
 '(jabber-nickname "Chmouel")
 '(jabber-resource "Work")
 '(jabber-server "jabber.rackspace.com")
 '(jabber-username "chmouel.boudjnah")
 '(jabber-vcard-avatars-retrieve nil)
 '(jde-jdk (quote ("1.6.0_16")))
 '(jde-jdk-registry (quote (("1.6.0_16" . "/usr/lib/jvm/java-6-sun") ("1.6.0_0" . "/usr/lib/jvm/java-6-openjdk"))))
 '(kill-do-not-save-duplicates t)
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(make-backup-files nil)
 '(max-specpdl-size 50000)
 '(mm-inline-text-html-with-w3m-keymap nil)
 '(org-startup-folded nil)
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("elpa" . "http://tromey.com/elpa/") ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(package-user-dir "~/.emacs.d/packages")
 '(rcirc-always-use-server-buffer-flag t)
 '(rcirc-default-nick "chmouelb")
 '(rcirc-default-user-name "chmouelb")
 '(rcirc-prompt "[%t] ")
 '(rcirc-track-minor-mode t)
 '(read-mail-command (quote gnus))
 '(reb-re-syntax (quote sregex))
 '(recentf-auto-cleanup 300)
 '(recentf-exclude (quote (".*/\\.news.*" ".*/\\.bbdb.*" ".*bookmarks.bmk.*" "/usr/share/emacs/.*/etc/.*" ".*loaddefs.el$")) t)
 '(recentf-save-file "~/.emacs.d/auto-save-list/recent-file-list.el")
 '(regex-tool-backend (quote perl))
 '(require-final-newline (quote visit-save))
 '(rst-level-face-base-color "dark slate gray")
 '(safe-local-variable-values (quote ((c-hanging-comment-ender-p))))
 '(save-interprogram-paste-before-kill t)
 '(save-place t nil (saveplace))
 '(save-place-file "~/.emacs.d/auto-save-list/emacs-places")
 '(savehist-file "~/.emacs.d/auto-save-list/history")
 '(savehist-mode t nil (savehist))
 '(server-mode t)
 '(server-use-tcp nil)
 '(server-window nil)
 '(split-width-threshold nil)
 '(svn-status-display-full-path t)
 '(svn-status-hide-unmodified t)
 '(svn-status-wash-control-M-in-process-buffers t)
 '(swbuff-exclude-buffer-regexps (quote ("^ " "^\\*" "^newsrc-dribble$" "^bbdb$")))
 '(tab-width 4)
 '(tags-revert-without-query t)
 '(tramp-chunksize 500)
 '(tramp-default-method "rsyncc")
 '(tramp-persistency-file-name "~/.emacs.d/auto-save-list/tramp")
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(url-cookie-file "~/.emacs.d/auto-save-list/cookies")
 '(use-file-dialog nil)
 '(user-full-name "Chmouel Boudjnah")
 '(user-mail-address "chmouel@chmouel.com")
 '(wdired-enable t)
 '(woman-use-own-frame nil)
 '(x-select-enable-clipboard t)
 '(yas/global-mode nil nil (yasnippet))
 '(yas/trigger-key "C-M-SPC")
 '(yas/wrap-around-region t)
 '(zoneinfo-style-world-list (quote (("Europe/London" "London") ("America/Chicago" "San Antonio") ("Europe/Paris" "Paris")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

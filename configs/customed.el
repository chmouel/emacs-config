
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(*pastie-restricted* t)
 '(ac-comphist-file "~/.emacs.d/auto-save-list/ac-comphist.dat")
 '(ac-dictionary-directories (quote ("~/.emacs.d/dict")))
 '(ac-dictionary-files (quote ("~/.emacs.d/packages/auto-complete/dict/")))
 '(ac-trigger-key "M-TAB")
 '(ack-and-a-half-arguments (quote ("--ignore-dir .tox" "-k" "--ignore-dir vendor/")))
 '(ack-executable "/usr/bin/ack-grep")
 '(all-christian-calendar-holidays t)
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
 '(completion-ignored-extensions
   (quote
    (".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".pyc" ".pyo" ".gitignore" ".class")))
 '(completion-styles (quote (basic partial-completion emacs22 initials)))
 '(ctags-update-other-options
   (quote
    ("--exclude='*.pyc'" "--exclude='*.elc'" "--exclude='*.class'" "--exclude='.git'" "--exclude='.svn'" "--exclude='SCCS'" "--exclude='RCS'" "--exclude='CVS'" "--exclude='EIFGEN'" "--exclude='.tox'" "--exclude='.venv'" "--python-kinds='-i'")))
 '(custom-safe-themes
   (quote
    ("ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "f0ea6118d1414b24c2e4babdc8e252707727e7b4ff2e791129f240a2b3093e32" "2affb26fb9a1b9325f05f4233d08ccbba7ec6e0c99c64681895219f964aac7af" "9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" "62b86b142b243071b5adb4d48a0ab89aefd3cf79ee3adc0bb297ea873b36d23f" "61a83dbf3d3722d70abee8fb6dbc3566766ff86c098c2a925f2ccfd4d5b3a756" "1c1e6b2640daffcd23b1f7dd5385ca8484a060aec901b677d0ec0cf2927f7cde" "1f3304214265481c56341bcee387ef1abb684e4efbccebca0e120be7b1a13589" "fc6e906a0e6ead5747ab2e7c5838166f7350b958d82e410257aeeb2820e8a07a" default)))
 '(cycbuf-buffer-sort-function (quote cycbuf-sort-by-recency))
 '(cycbuf-dont-show-regexp (quote ("^ " "^\\*cycbuf\\*$" "^\\*Messages\\*#")))
 '(cycbuf-mode-name-replacements
   (quote
    (("Fundamental" "Fund.")
     ("Lisp Interaction" "Lisp I.")
     ("Python" "Py"))))
 '(default-major-mode (quote text-mode) t)
 '(delete-by-moving-to-trash t)
 '(diff-switches "-uw")
 '(dired-auto-revert-buffer (quote dired-directory-changed-p))
 '(dired-omit-files
   "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^Thumbs.db$\\|\\.svn$\\|\\.git\\(ignore\\)?\\|\\.pyc$\\|^\\.coverage$\\|^TAGS$\\|^tags$\\|\\.class$\\|\\.DS_Store\\|\\.localized$")
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(display-time-world-list
   (quote
    (("Europe/London" "London")
     ("Europe/Paris" "Paris")
     ("America/Chicago" "San Antonio")
     ("America/Los_Angeles" "San-Francisco")
     ("Australia/Sydney" "Sydney"))))
 '(doc-view-continuous t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(elscreen-tab-width 23)
 '(emacs-lock-default-locking-mode (quote kill))
 '(emerge-diff-options "--ignore-all-space" t)
 '(enable-local-variables :all)
 '(erc-away-nickname "chmouel_away")
 '(erc-current-nick-highlight-type (quote all))
 '(erc-dangerous-host-highlight-type (quote all))
 '(erc-email-userid "chmouel@chmouel.com")
 '(erc-header-line-face-method t)
 '(erc-hide-list (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE")))
 '(erc-hide-timestamps nil)
 '(erc-hl-nicks-mode t)
 '(erc-input-line-position -2)
 '(erc-insert-away-timestamp-function (quote erc-insert-timestamp-left))
 '(erc-keywords (quote ("chmouel")))
 '(erc-kill-channel-hook nil)
 '(erc-log-channels-directory "~/.irclogs")
 '(erc-log-insert-log-on-open t)
 '(erc-macosx-notifications-mode t)
 '(erc-match-mode t)
 '(erc-modules
   (quote
    (completion list hl-nicks button list stamp autojoin irccontrols menu move-to-prompt netsplit networks noncommands readonly scrolltobottom services)))
 '(erc-nick "chmouel")
 '(erc-nicklist-use-icons nil)
 '(erc-nickserv-identify-mode (quote autodetect))
 '(erc-nickserv-passwords (quote ((freenode (("chmouelb" . ""))))))
 '(erc-notifications-mode t)
 '(erc-pals (quote ("chmoub")))
 '(erc-port 6667)
 '(erc-prompt "->")
 '(erc-prompt-for-password nil)
 '(erc-server "irc.freenode.org")
 '(erc-services-mode t)
 '(erc-stamp-mode t)
 '(erc-system-name "frenchy.rackspace.co.uk")
 '(erc-text-matched-hook
   (quote
    (erc-log-matches erc-hide-fools erc-beep-on-match erc-macosx-notifications-notify-on-match erc-log-matches)))
 '(erc-track-enable-keybindings t)
 '(erc-track-shorten-aggressively (quote max))
 '(erc-track-shorten-function nil)
 '(erc-track-showcount t)
 '(erc-track-use-faces nil)
 '(erc-user-full-name "Chmouel Boudjnah")
 '(eshell-directory-name "~/.emacs.d/auto-save-list/eshell/")
 '(eshell-modules-list
   (quote
    (eshell-alias eshell-banner eshell-basic eshell-cmpl eshell-dirs eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-rebind eshell-script)))
 '(flycheck-check-syntax-automatically (quote (save new-line mode-enabled)))
 '(flycheck-disabled-checkers (quote (emacs-lisp emacs-lisp-checkdoc)))
 '(flycheck-display-errors-delay 0.2)
 '(flycheck-highlighting-mode (quote lines))
 '(flymake-check-file-limit nil)
 '(flymake-cursor-error-display-delay 0.1)
 '(flymake-start-syntax-check-on-newline nil)
 '(font-use-system-font t)
 '(global-flycheck-mode t nil (flycheck))
 '(global-git-gutter-mode t)
 '(gnus-init-file "~/.emacs.d/gnus/init.el")
 '(grep-scroll-output t)
 '(grep-window-height 10)
 '(gud-tooltip-echo-area t)
 '(helm-adaptative-mode t nil (helm-adaptative))
 '(helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf")))
 '(helm-buffers-favorite-modes (quote (text-mode python-mode rst-mode)))
 '(helm-command-prefix-key "C-x c")
 '(hippie-expand-try-functions-list
   (quote
    (try-complete-file-name-partially try-complete-file-name yas/hippie-try-expand try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-all-abbrevs try-expand-list try-expand-line try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(hl-line-sticky-flag nil)
 '(home-end-enable t)
 '(html-inlined-install-modes (quote (nxml-mode nxhtmlmode html-mode php-mode)))
 '(html-inlined-key [f12])
 '(ibuffer-always-compile-formats t)
 '(ibuffer-elide-long-columns t)
 '(ibuffer-expert t)
 '(ibuffer-formats
   (quote
    ((mark modified read-only " "
           (name 18 -1 :left)
           " "
           (size 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename))))
 '(ibuffer-never-show-predicates nil nil (ibuf-ext))
 '(ibuffer-show-empty-filter-groups nil)
 '(ibuffer-truncate-lines nil)
 '(ibuffer-use-other-window nil)
 '(ido-enable-flex-matching t)
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
 '(ispell-extra-args (quote ("--sug-mode=ultra")))
 '(ispell-message-dictionary-alist (quote (("^To:[^\\n,]+\\\\.fr[ \\t\\n,>]" . "francais"))))
 '(ispell-program-name "aspell")
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
 '(jde-jdk-registry
   (quote
    (("1.6.0_16" . "/usr/lib/jvm/java-6-sun")
     ("1.6.0_0" . "/usr/lib/jvm/java-6-openjdk"))))
 '(kill-do-not-save-duplicates t)
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(magit-commit-signoff t)
 '(magit-completing-read-function (quote magit-ido-completing-read))
 '(magit-expand-staged-on-commit (quote full))
 '(magit-log-auto-more t)
 '(make-backup-files nil)
 '(max-specpdl-size 50000)
 '(mm-inline-text-html-with-w3m-keymap nil)
 '(oauth2-token-file "~/.emacs.d/auto-save-list/oauth2.plstore")
 '(org-startup-folded nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("elpa" . "http://tromey.com/elpa/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(package-user-dir "~/.emacs.d/packages")
 '(rcirc-always-use-server-buffer-flag t)
 '(rcirc-default-full-name "Chmouel Boudjnah")
 '(rcirc-default-nick "chmouel")
 '(rcirc-default-user-name "chmouel")
 '(rcirc-fill-column (quote frame-width))
 '(rcirc-omit-responses (quote ("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE")))
 '(rcirc-prompt "[%t] ")
 '(rcirc-scroll-show-maximum-output t)
 '(rcirc-track-minor-mode t)
 '(read-mail-command (quote gnus))
 '(reb-re-syntax (quote sregex))
 '(recent-addresses-file "~/.emacs.d/auto-save-list/recent-addresses")
 '(recentf-auto-cleanup (quote mode))
 '(recentf-exclude
   (quote
    (".*/\\.news.*" ".*/\\.bbdb.*" ".*bookmarks.bmk.*" "/usr/share/emacs/.*/etc/.*" ".*loaddefs.el$")))
 '(recentf-mode t)
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
 '(server-use-tcp nil)
 '(server-window nil)
 '(split-width-threshold nil)
 '(svn-status-display-full-path t)
 '(svn-status-hide-unmodified t)
 '(svn-status-wash-control-M-in-process-buffers t)
 '(swbuff-exclude-buffer-regexps (quote ("^ " "^\\*" "^newsrc-dribble$" "^bbdb$")))
 '(tab-width 4)
 '(tabbar-buffer-home-button (quote (("") "")))
 '(tabbar-home-button (quote (("") "")))
 '(tabbar-scroll-left-button (quote ((" <") " ")))
 '(tabbar-scroll-right-button (quote ((" ") "")))
 '(tags-revert-without-query t)
 '(tramp-chunksize 500)
 '(tramp-persistency-file-name "~/.emacs.d/auto-save-list/tramp")
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(url-cookie-file "~/.emacs.d/auto-save-list/cookies")
 '(use-file-dialog nil)
 '(user-full-name "Chmouel Boudjnah")
 '(user-mail-address "chmouel@chmouel.com")
 '(wdired-enable t)
 '(window-number-meta-mode t)
 '(woman-use-own-frame nil)
 '(x-select-enable-clipboard t)
 '(yas-wrap-around-region t)
 '(yas/trigger-key "C-M-SPC")
 '(yas/wrap-around-region t)
 '(zoneinfo-style-world-list
   (quote
    (("Europe/London" "London")
     ("America/Montreal" "Montreal")
     ("America/Los-Angeles" "San Francisco")
     ("Europe/Paris" "Paris")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cycbuf-current-face ((t (:background "grey" :foreground "black" :weight bold))) t)
 '(cycbuf-header-face ((t (:background "black" :foreground "yellow" :weight bold))) t)
 '(ediff-even-diff-B ((t (:foreground "green"))))
 '(ediff-odd-diff-B ((t (:background "#41423f" :foreground "grey"))))
 '(erc-input-face ((t (:foreground "white"))) t)
 '(erc-my-nick-face ((t (:foreground "DarkSlateGray3" :weight bold))) t)
 '(erc-notice-face ((t (:foreground "Grey" :weight bold))) t)
 '(gnus-signature ((t (:slant normal))))
 '(hl-line-face ((t (:background "red"))) t)
 '(magit-item-highlight ((t (:weight bold))))
 '(powerline-active1 ((t (:inherit mode-line :background "light sea green"))))
 '(powerline-active2 ((t (:inherit mode-line :background "grey40" :foreground "white"))))
 '(twittering-username-face ((t (:foreground "red"))) t)
 '(which-func ((t (:weight bold)))))

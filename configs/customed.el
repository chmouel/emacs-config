(put 'dired-find-alternate-file 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(*pastie-restricted* t)
 '(ac-comphist-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/ac-comphist.dat")))
 '(ac-dictionary-directories '((expand-file-name (concat user-emacs-directory "/dict"))))
 '(ac-dictionary-files
   '((expand-file-name
      (concat user-emacs-directory "/packages/auto-complete/dict/"))))
 '(ac-trigger-key "M-TAB")
 '(ace-jump-mode-gray-background nil t)
 '(ack-and-a-half-arguments '("--ignore-dir .tox" "-k" "--ignore-dir vendor/"))
 '(ack-executable "/usr/bin/ack-grep")
 '(ag-reuse-buffers t t)
 '(ajb-bs-configuration "files" t)
 '(all-christian-calendar-holidays t)
 '(atomic-chrome-buffer-frame-height 80)
 '(atomic-chrome-buffer-open-style 'split)
 '(atomic-chrome-url-major-mode-alist
   '(("https://github.com/.*/issues/.*" . markdown-mode)
     ("https://mail.google.com/.*" . message-mode)))
 '(auto-insert-query nil)
 '(auto-install-directory (expand-file-name (concat user-emacs-directory "/modes/")))
 '(battery-mode-line-format "--[%b%p%%]")
 '(bc-bookmark-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/breadcrumb.el")))
 '(blacken-line-length 80)
 '(bookmark-save-flag 1)
 '(bug-reference-bug-regexp
   "\\([Ii]ssue ?#?\\|[Bb]ug ?#?\\|[Pp]atch ?#\\|RFE ?#\\|PR [a-z-+]+/\\)\\([0-9]+\\(?:#[0-9]+\\)?\\)")
 '(c-basic-offset 4)
 '(calendar-christian-all-holidays-flag t)
 '(canlock-password "38ebb79c7f0ece35d1103834941558b48e754833")
 '(centaur-tabs-cycle-scope 'tabs)
 '(centaur-tabs-gray-out-icons 'buffer)
 '(centaur-tabs-modified-marker "﹡")
 '(centaur-tabs-set-bar 'under)
 '(centaur-tabs-set-icons t)
 '(centaur-tabs-set-modified-marker t)
 '(company-idle-delay 0.3)
 '(compilation-ask-about-save nil)
 '(compilation-scroll-output 'first-error)
 '(compile-command "")
 '(completion-ignored-extensions
   '(".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".pyc" ".pyo" ".gitignore" ".class"))
 '(completion-styles '(basic partial-completion emacs22 initials))
 '(confirm-kill-processes nil)
 '(counsel-ack-base-command "ack --nocolor --nogroup %s")
 '(counsel-ag-base-command "ag --ignore \"vendor/*\" --nocolor --nogroup %s")
 '(ctags-update-other-options
   '("--exclude='*.pyc'" "--exclude='*.elc'" "--exclude='*.class'" "--exclude='.git'" "--exclude='.svn'" "--exclude='SCCS'" "--exclude='RCS'" "--exclude='CVS'" "--exclude='EIFGEN'" "--exclude='.tox'" "--exclude='.venv'" "--python-kinds='-i'"))
 '(custom-safe-themes
   '("9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "2cdc13ef8c76a22daa0f46370011f54e79bae00d5736340a5ddfe656a767fddf" "7a994c16aa550678846e82edc8c9d6a7d39cc6564baaaacc305a3fdc0bd8725f" "41039913efab185af1ec1b13ff4df36d6941994d5e3dee39791f30fcd94b42be" "4b0b568d63b1c6f6dddb080b476cfba43a8bbc34187c3583165e8fb5bbfde3dc" "5091eadbb87fa0a168a65f2c3e579d1a648d764f12ab9d3ab7bdefca709cd2a5" "5e0b63e0373472b2e1cf1ebcc27058a683166ab544ef701a6e7f2a9f33a23726" "669e05b25859b9e5b6b9809aa513d76dd35bf21c0f16d8cbb80fb0727dc8f842" "32fd809c28baa5813b6ca639e736946579159098d7768af6c68d78ffa32063f4" "f7b230ac0a42fc7e93cd0a5976979bd448a857cd82a097048de24e985ca7e4b2" "b60f08ddc98a95485ec19f046a81d5877b26ab80a67782ea5b91a00ea4f52170" "a4fa3280ffa1f2083c5d4dab44a7207f3f7bcb76e720d304bd3bd640f37b4bef" "c6b93ff250f8546c7ad0838534d46e616a374d5cb86663a9ad0807fd0aeb1d16" "a02836a5807a687c982d47728e54ff42a91bc9e6621f7fe7205b0225db677f07" "1897b97f63e91a792e8540c06402f29d5edcbfb0aafd64b1b14270663d6868ee" "e47c0abe03e0484ddadf2ae57d32b0f29f0b2ddfe7ec810bd6d558765d9a6a6c" "b9dda6ca36e825766dfada5274cf18d8a5bce70676b786e3260094e0cd8c0e62" "53f8223005ceb058848fb92c2c4752ffdfcd771f8ad4324b3d0a4674dec56c44" "f3455b91943e9664af7998cc2c458cfc17e674b6443891f519266e5b3c51799d" "e7666261f46e2f4f42fd1f9aa1875bdb81d17cc7a121533cad3e0d724f12faf2" "dd854be6626a4243375fd290fec71ed4befe90f1186eb5b485a9266011e15b29" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "0c9f63c9d90d0d135935392873cd016cc1767638de92841a5b277481f1ec1f4a" "09cadcc2784baa744c6a7c5ebf2a30df59c275414768b0719b800cabd8d1b842" "930f7841c24772dda4f22291e510dac1d58813b59dcb9f54ad4f1943ea89cdcd" "e7b49145d311e86da34a32a7e1f73497fa365110a813d2ecd8105eaa551969da" "e61752b5a3af12be08e99d076aedadd76052137560b7e684a8be2f8d2958edc3" "0bff60fb779498e69ea705825a2ca1a5497a4fccef93bf3275705c2d27528f2f" "f951343d4bbe5a90dba0f058de8317ca58a6822faa65d8463b0e751a07ec887c" "2bd0a595cbed0e18370692aeb9f8953b522bd2eeb9bdcb14800d0eeb15d93378" "6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" "1a1cdd9b407ceb299b73e4afd1b63d01bbf2e056ec47a9d95901f4198a0d2428" "de1f10725856538a8c373b3a314d41b450b8eba21d653c4a4498d52bb801ecd2" "43b219a31db8fddfdc8fdbfdbd97e3d64c09c1c9fdd5dff83f3ffc2ddb8f0ba0" "73c69e346ec1cb3d1508c2447f6518a6e582851792a8c0e57a22d6b9948071b4" "20bf9f519f78b247da9ccf974c31d3537bee613ff11579f539b2781246dee73b" "2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" "d8dc153c58354d612b2576fea87fe676a3a5d43bcc71170c62ddde4a1ad9e1fb" "37ba833442e0c5155a46df21446cadbe623440ccb6bbd61382eb869a2b9e9bf9" "462d6915a7eac1c6f00d5acd8b08ae379e12db2341e7d3eac44ff7f984a5e579" "0329c772ed96053a73b9ddddf96c1183e23c267955bbdf78e7933057ce9da04b" "1d2f406a342499f0098f9388b87d05ec9b28ccb12ca548f4f5fa80ae368235b6" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "d21135150e22e58f8c656ec04530872831baebf5a1c3688030d119c114233c24" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "cf284fac2a56d242ace50b6d2c438fcc6b4090137f1631e32bedf19495124600" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "0d456bc74e0ffa4bf5b69b0b54dac5104512c324199e96fc9f3a1db10dfa31f3" "f11e219c9d043cbd5f4b2e01713c2c24a948a98bed48828dc670bd64ae771aa1" "af4dc574b2f96f5345d55b98af024e2db9b9bbf1872b3132bc66dffbf5e1ba1d" "19b9349a6b442a2b50e5b82be9de45034f9b08fa36909e0b1be09433234610bb" "abe3405767afe98b35b6a2b212af1fbc34e4f4c455310d2b7f2ffd2ec81d387b" "862a0ccc73c12df4df325427f9285fa6a5bbba593a77257f43b01c84269f51b0" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "59e82a683db7129c0142b4b5a35dbbeaf8e01a4b81588f8c163bd255b76f4d21" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default))
 '(cycbuf-buffer-sort-function 'cycbuf-sort-by-recency)
 '(cycbuf-dont-show-regexp '("^ " "^\\*cycbuf\\*$" "^\\*Messages\\*#"))
 '(cycbuf-mode-name-replacements
   '(("Fundamental" "Fund.")
     ("Lisp Interaction" "Lisp I.")
     ("Python" "Py")))
 '(cycle-themes-mode t)
 '(dashboard-banner-logo-title "Welcome to ChmouMACS!!" t)
 '(dashboard-center-content t t nil "Customized with use-package dashboard")
 '(dashboard-items '((recents . 10) (projects . 10) (bookmarks . 5)) t)
 '(dashboard-set-file-icons t t)
 '(dashboard-set-heading-icons t t)
 '(dashboard-startup-banner 'logo t)
 '(default-major-mode 'text-mode t)
 '(delete-by-moving-to-trash t)
 '(diff-font-lock-prettify t)
 '(diff-font-lock-syntax nil)
 '(diff-switches "-uw")
 '(dired-auto-revert-buffer 'dired-directory-changed-p)
 '(dired-omit-files
   "^\\.\\|^\\.?#\\|^\\.$\\|^\\.\\.$\\|^Thumbs.db$\\|\\.svn$\\|\\.git\\(ignore\\)?\\|\\.pyc$\\|^\\.coverage$\\|^TAGS$\\|^tags$\\|\\.class$\\|\\.DS_Store\\|\\.localized$\\|__pycache__$")
 '(direnv-always-show-summary t)
 '(direnv-show-paths-in-summary nil)
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(display-time-world-list
   '(("Europe/London" "London")
     ("Europe/Paris" "Paris")
     ("America/Chicago" "San Antonio")
     ("America/Los_Angeles" "San-Francisco")
     ("Australia/Sydney" "Sydney")))
 '(doc-view-continuous t)
 '(ediff-diff-options "-w")
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(electric-pair-mode t)
 '(electric-quote-replace-double t)
 '(elscreen-tab-width 23)
 '(emacs-lock-default-locking-mode 'kill)
 '(emerge-diff-options "--ignore-all-space" t)
 '(enable-local-variables :all)
 '(erc-away-nickname "chmouel_away")
 '(erc-current-nick-highlight-type 'all)
 '(erc-dangerous-host-highlight-type 'all)
 '(erc-email-userid "chmouel@chmouel.com")
 '(erc-header-line-face-method t)
 '(erc-hide-list '("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE"))
 '(erc-hide-timestamps nil)
 '(erc-hl-nicks-mode t)
 '(erc-input-line-position -2)
 '(erc-insert-away-timestamp-function 'erc-insert-timestamp-left)
 '(erc-keywords '("chmouel"))
 '(erc-kill-channel-hook nil)
 '(erc-log-channels-directory "~/.irclogs")
 '(erc-log-insert-log-on-open t)
 '(erc-macosx-notifications-mode t)
 '(erc-match-mode t)
 '(erc-modules
   '(completion list hl-nicks button list stamp autojoin irccontrols menu move-to-prompt netsplit networks noncommands readonly scrolltobottom services))
 '(erc-nick "chmouel")
 '(erc-nicklist-use-icons nil)
 '(erc-nickserv-identify-mode 'autodetect)
 '(erc-nickserv-passwords '((freenode (("chmouelb" . "")))))
 '(erc-notifications-mode t)
 '(erc-pals '("chmoub"))
 '(erc-port 6667)
 '(erc-prompt "->")
 '(erc-prompt-for-password nil)
 '(erc-server "irc.freenode.org")
 '(erc-services-mode t)
 '(erc-stamp-mode t)
 '(erc-system-name "frenchy.rackspace.co.uk")
 '(erc-text-matched-hook
   '(erc-log-matches erc-hide-fools erc-beep-on-match erc-macosx-notifications-notify-on-match erc-log-matches))
 '(erc-track-enable-keybindings t)
 '(erc-track-shorten-aggressively 'max)
 '(erc-track-shorten-function nil)
 '(erc-track-showcount t)
 '(erc-track-use-faces nil)
 '(erc-user-full-name "Chmouel Boudjnah")
 '(eshell-directory-name
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/eshell/")))
 '(eshell-modules-list
   '(eshell-alias eshell-banner eshell-basic eshell-cmpl eshell-dirs eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-rebind eshell-script))
 '(exec-path-from-shell-check-startup-files nil)
 '(fci-rule-color "#37474F")
 '(fill-column 80)
 '(flycheck-check-syntax-automatically '(save mode-enabled))
 '(flycheck-disabled-checkers
   '(html-tidy xml-xmlint emacs-lisp emacs-lisp-checkdoc javascript-eslint))
 '(flycheck-display-errors-delay 0.1)
 '(flycheck-highlighting-mode 'lines)
 '(font-use-system-font t)
 '(forge-database-file
   "/Users/chmouel/.emacs.d/auto-save-list/forge-database.sqlite" t)
 '(fringe-mode '(1 . 1) nil (fringe))
 '(gc-cons-threshold 20000000)
 '(git-gutter:added-sign " ")
 '(git-gutter:deleted-sign " ")
 '(github-browse-file--force-shaid t)
 '(global-git-commit-mode t)
 '(global-git-gutter-mode t)
 '(global-undo-tree-mode nil)
 '(gnus-init-file
   (expand-file-name
    (concat user-emacs-directory "/gnus/init.el")))
 '(gnus-notifications-use-google-contacts nil)
 '(gnus-notifications-use-gravatar nil)
 '(gnus-topic-indent-level 4)
 '(gnus-user-agent '(gnus emacs))
 '(go-playground-ask-for-file-name t t)
 '(go-test-verbose t)
 '(grep-scroll-output t)
 '(grep-window-height 10)
 '(groovy-indent-offset 2)
 '(gud-tooltip-echo-area t)
 '(gui-select-enable-clipboard t)
 '(helm-boring-buffer-regexp-list
   '("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf"))
 '(helm-buffers-favorite-modes '(text-mode python-mode rst-mode))
 '(helm-command-prefix-key "C-x c")
 '(hippie-expand-try-functions-list
   '(try-complete-file-name-partially try-complete-file-name yas/hippie-try-expand try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-all-abbrevs try-expand-list try-expand-line try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol))
 '(hl-line-sticky-flag nil)
 '(home-end-enable t)
 '(html-inlined-install-modes '(nxml-mode nxhtmlmode html-mode php-mode))
 '(html-inlined-key [f12])
 '(ibuffer-always-compile-formats t)
 '(ibuffer-elide-long-columns t)
 '(ibuffer-expert t)
 '(ibuffer-projectile-prefix "")
 '(ibuffer-saved-filter-groups
   '(("default"
      ("Files"
       (not mode . dired-mode)
       (name . "^[^*]"))
      ("Directories"
       (mode . dired-mode)))))
 '(ibuffer-show-empty-filter-groups nil)
 '(ibuffer-truncate-lines nil)
 '(ibuffer-use-other-window nil)
 '(ido-enable-flex-matching t nil nil "Customized with use-package flx-ido")
 '(ido-enable-last-directory-history t)
 '(ido-enable-tramp-completion nil)
 '(ido-ignore-directories '("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`\\.svn/"))
 '(ido-max-prospects 5 nil nil "Customized with use-package ido-vertical-mode")
 '(ido-mode 'buffer nil (ido))
 '(ido-rotate-file-list-default t)
 '(ido-save-directory-list-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/ido.last")))
 '(ido-show-dot-for-dired t)
 '(ido-use-faces nil nil nil "Customized with use-package flx-ido")
 '(ido-use-filename-at-point 'guess)
 '(ido-use-url-at-point t)
 '(igrep-options "-I")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "english")
 '(ispell-extra-args '("--sug-mode=ultra"))
 '(ispell-message-dictionary-alist '(("^To:[^\\n,]+\\\\.fr[ \\t\\n,>]" . "francais")))
 '(ispell-program-name "aspell")
 '(ivy-mode nil)
 '(jabber-alert-message-hooks '(jabber-message-echo jabber-message-scroll))
 '(jabber-alert-presence-hooks '(jabber-presence-update-roster))
 '(jabber-connection-type 'starttls)
 '(jabber-history-enabled t)
 '(jabber-mode-line-mode t)
 '(jabber-nickname "Chmouel")
 '(jabber-resource "Work")
 '(jabber-server "jabber.rackspace.com")
 '(jabber-username "chmouel.boudjnah")
 '(jabber-vcard-avatars-retrieve nil)
 '(jde-jdk '("1.6.0_16"))
 '(jde-jdk-registry
   '(("1.6.0_16" . "/usr/lib/jvm/java-6-sun")
     ("1.6.0_0" . "/usr/lib/jvm/java-6-openjdk")))
 '(jdee-db-active-breakpoint-face-colors (cons "#171F24" "#c792ea"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#171F24" "#c3e88d"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#171F24" "#37474F"))
 '(js-indent-level 2)
 '(kill-do-not-save-duplicates t)
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(lsp-auto-guess-root t t)
 '(lsp-document-highlight-delay 2.0 t)
 '(lsp-eldoc-render-all nil t)
 '(lsp-enable-file-watchers nil)
 '(lsp-enable-links t t)
 '(lsp-enable-snippet t t)
 '(lsp-file-watch-ignored
   '("[/\\\\]\\.git$" "[/\\\\]\\.hg$" "[/\\\\]\\.bzr$" "[/\\\\]_darcs$" "[/\\\\]\\.svn$" "[/\\\\]_FOSSIL_$" "[/\\\\]\\.idea$" "[/\\\\]\\.ensime_cache$" "[/\\\\]\\.eunit$" "[/\\\\]node_modules$" "[/\\\\]\\.fslckout$" "[/\\\\]\\.tox$" "[/\\\\]\\.stack-work$" "[/\\\\]\\.bloop$" "[/\\\\]\\.metals$" "[/\\\\]target$" "[/\\\\]\\.deps$" "[/\\\\]build-aux$" "[/\\\\]autom4te.cache$" "[/\\\\]\\.reference$"))
 '(lsp-file-watch-threshold 500)
 '(lsp-gopls-complete-unimported t t)
 '(lsp-gopls-staticcheck t t)
 '(lsp-prefer-flymake nil t)
 '(lsp-ui-doc-enable t t)
 '(lsp-ui-doc-max-height 15)
 '(lsp-ui-doc-max-width 30)
 '(lsp-ui-flycheck-enable t t)
 '(lsp-ui-imenu-enable t t)
 '(lsp-ui-peek-enable t t)
 '(lsp-ui-sideline-delay 0.5)
 '(magit-commit-show-diff nil)
 '(magit-commit-signoff t)
 '(magit-completing-read-function 'magit-ido-completing-read)
 '(magit-expand-staged-on-commit 'full)
 '(magit-log-arguments '("--graph" "--decorate" "--no-merges"))
 '(magit-log-auto-more t)
 '(magit-visit-ref-behavior '(checkout-branch))
 '(make-backup-files nil)
 '(max-specpdl-size 50000)
 '(mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el" t)
 '(mm-inline-text-html-with-w3m-keymap nil)
 '(multi-compile-history-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/multi-compile.cache")))
 '(neo-theme 'icons t)
 '(nrepl-message-colors
   '("#032f62" "#6a737d" "#d73a49" "#6a737d" "#005cc5" "#6f42c1" "#d73a49" "#6a737d"))
 '(oauth2-token-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/oauth2.plstore")))
 '(olivetti-body-width 120)
 '(org-agenda-files nil)
 '(org-src-fontify-natively t)
 '(org-startup-folded nil)
 '(package-archives
   '(("melpa-unstable" . "http://melpa.org/packages/")
     ("GNU" . "http://elpa.gnu.org/packages/")))
 '(package-selected-packages
   '(olivetti dired-sidebar anaconda-mode blacken closql company dash-functional emacsql ghub git-commit helm helm-core hydra ivy lsp-mode magit magit-popup markdown-mode transient with-editor yasnippet minibuffer company-quickhelp mustache-mode github-review slack all-the-icons-ibuffer all-the-icons-gnus go-test sqlite magit-section jinja2-mode ripgrep grip-mode zoom-mode zoom emojify doom-themes centaur-tabs centaur-tab which-key awesome-tab all-the-icons-dired all-the-icons exec-path-from-shell ace-jump-buffer ace-window dashboard jira-markup-mode lsp-ui py-isort subr-x docker-tramp ibuffer-tramp kubernetes-tramp helm-org general direnv pytest ibuffer-git esh-autosuggest diredfl git-commit-insert-issue evil monokai-pro monokai-alt monokai-pro-theme monokai-theme goto-last-change company-lsp jsx-mode auto-complete multiple-cursors forge mmm-mode ag rg deadgrep inf-ruby gitconfig-mode yaml-imenu yaml-mode counsel flycheck-rust rust-auto-use rust-playground rust-mode reformatter multi-compile-run multi-compile yapf-mode yapf crux adoc color-moccur github-issues direx lorem-ipsum pyimport flycheck-plantuml plantuml-mode indent-guide projectile evil-matchit-mode elisp emacs-lisp elisp-mode emacs-lisp-mode info-colors magithub shell-mode message isearch abbrev dired dired-x lisp-mode misc anzu page diminish ns-win moe popup-kill-ring pdf-tools imenu-list github-clone indent-tools git-auto-commit-mode helm-lean applescript-mode browse-at-remote go-impl dumb-jump groovy-mode the-org-mode-expansions kubernetes flycheck-yamllint avy commenter gist zop-to-char js2-mode jsfmt go-add-tags wgrep-ag flycheck-gometalinter go-stacktracer js-auto-beautify go-guru highlight-indentation esqlite go-errcheck go-snippets go-playground golint go-rename toggle-quotes zygospore zenburn-theme window-number wgrep web use-package try smex smart-shift smart-mode-line rpm-spec-mode request-deferred regex-tool queue python-docstring pyfmt powerline php-mode pcsv pcache paredit package-safe-delete message-x marmalade magit-find-file json-rpc json-mode isearch-dabbrev ido-vertical-mode ido-completing-read+ ibuffer-vc hungry-delete htmlize highlight-numbers highlight-80+ google-this go-eldoc github-browse-file fringe-helper flycheck flx-ido find-file-in-git-repo fill-column-indicator expand-region dropdown-list dockerfile-mode csv-mode csharp-mode company-go company-anaconda comment-dwim-2 browse-kill-ring boxquote bm bbdb aggressive-indent))
 '(package-user-dir
   (expand-file-name
    (concat user-emacs-directory "/packages")))
 '(pdf-view-midnight-colors (cons "#EEFFFF" "#263238"))
 '(plantuml-default-exec-mode 'jar)
 '(plantuml-jar-path "/usr/local/Cellar/plantuml/1.2019.13/libexec/plantuml.jar" t)
 '(powerline-default-separator 'curve)
 '(powerline-display-buffer-size nil nil nil "Customized with use-package powerline")
 '(powerline-display-mule-info nil nil nil "Customized with use-package powerline")
 '(powerline-gui-use-vcs-glyph t)
 '(projectile-cache-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/projectile.cache")))
 '(projectile-keymap-prefix "")
 '(projectile-known-projects-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/projectile-bookmarks.eld")))
 '(projectile-mode-line-function 'my-projectile-mode-line)
 '(projectile-mode-line-prefix " PRJ")
 '(projectile-project-root-files
   '("rebar.config" "project.clj" "SConstruct" "pom.xml" "build.sbt" "build.gradle" "Gemfile" "requirements.txt" "package.json" "gulpfile.js" "Gruntfile.js" "bower.json" "composer.json" "Cargo.toml" "mix.exs" "tox.ini"))
 '(rcirc-always-use-server-buffer-flag t)
 '(rcirc-default-full-name "Chmouel Boudjnah")
 '(rcirc-default-nick "chmouel")
 '(rcirc-default-user-name "chmouel")
 '(rcirc-fill-column 'frame-width)
 '(rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE"))
 '(rcirc-prompt "[%t] ")
 '(rcirc-scroll-show-maximum-output t)
 '(read-mail-command 'gnus)
 '(reb-re-syntax 'sregex)
 '(recent-addresses-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/recent-addresses")))
 '(recentf-auto-cleanup 'mode)
 '(recentf-exclude '("^(/var/\\\\|/etc\\\\|/Applications\\\\).*"))
 '(recentf-filename-handlers 'abbreviate-file-name)
 '(recentf-max-saved-items 500)
 '(recentf-save-file "~/.emacs.d/auto-save-list/recent-file-list.el")
 '(regex-tool-backend 'perl)
 '(request-storage-directory
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/request")))
 '(require-final-newline 'visit-save)
 '(rg-ignore-case 'smart)
 '(rst-level-face-base-color "dark slate gray")
 '(safe-local-variable-values '((c-hanging-comment-ender-p)))
 '(save-interprogram-paste-before-kill t)
 '(save-place-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/emacs-places")))
 '(save-place-mode t nil (saveplace))
 '(savehist-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/history")))
 '(savehist-mode t)
 '(server-use-tcp nil)
 '(server-window nil)
 '(smex-save-file "~/.emacs.d/auto-save-list/smex-items" t)
 '(split-width-threshold nil)
 '(svn-status-display-full-path t)
 '(svn-status-hide-unmodified t)
 '(svn-status-wash-control-M-in-process-buffers t)
 '(swbuff-exclude-buffer-regexps '("^ " "^\\*" "^newsrc-dribble$" "^bbdb$"))
 '(synosaurus-backend 'synosaurus-backend-openthesaurus)
 '(tab-width 4)
 '(tags-revert-without-query t)
 '(tramp-chunksize 500 nil (tramp))
 '(tramp-mode t nil (tramp))
 '(tramp-persistency-file-name
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/tramp")))
 '(undo-tree-auto-save-history t)
 '(undo-tree-enable-undo-in-region t)
 '(undo-tree-incompatible-major-modes '(term-mode))
 '(url-cookie-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/cookies")))
 '(use-file-dialog nil)
 '(user-full-name "Chmouel Boudjnah")
 '(user-mail-address "chmouel@chmouel.com")
 '(vc-annotate-background "#263238")
 '(vc-annotate-color-map
   (list
    (cons 20 "#c3e88d")
    (cons 40 "#d7de81")
    (cons 60 "#ebd476")
    (cons 80 "#ffcb6b")
    (cons 100 "#fcb66b")
    (cons 120 "#f9a16b")
    (cons 140 "#f78c6c")
    (cons 160 "#e78e96")
    (cons 180 "#d690c0")
    (cons 200 "#c792ea")
    (cons 220 "#d97dc1")
    (cons 240 "#ec6898")
    (cons 260 "#ff5370")
    (cons 280 "#cd5067")
    (cons 300 "#9b4d5f")
    (cons 320 "#694a57")
    (cons 340 "#37474F")
    (cons 360 "#37474F")))
 '(vc-annotate-very-old-color nil)
 '(vc-follow-symlinks t)
 '(warning-suppress-types '((undo disard-info)))
 '(wdired-enable t)
 '(weechat-auto-monitor-buffers t)
 '(weechat-auto-monitor-new-buffers t)
 '(weechat-buffer-kill-buffers-on-disconnect nil)
 '(weechat-initial-lines 200)
 '(weechat-mode-default 'ssl)
 '(weechat-notification-mode t)
 '(weechat-port-default 9001)
 '(whitespace-display-mappings
   '((space-mark 32
                 [183]
                 [46])
     (space-mark 160
                 [164]
                 [95])
     (tab-mark 9
               [187 9]
               [92 9])))
 '(whitespace-line-column 300)
 '(window-number-meta-mode t)
 '(woman-use-own-frame nil)
 '(x-underline-at-descent-line t)
 '(yas-prompt-functions '(yas/dropdown-prompt))
 '(yas-wrap-around-region t)
 '(yas/trigger-key "C-M-SPC")
 '(yas/wrap-around-region t)
 '(zoneinfo-style-world-list
   '(("Europe/London" "London")
     ("America/Montreal" "Montreal")
     ("America/Los-Angeles" "San Francisco")
     ("Europe/Paris" "Paris"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t nil)))
 '(diff-refine-removed ((t nil)))
 '(diredfl-date-time ((t (:foreground "burlywood2"))))
 '(diredfl-file-name ((t (:foreground "gray91"))))
 '(ediff-current-diff-A ((t (:background "purple4"))))
 '(font-lock-comment-delimiter-face ((t nil)))
 '(font-lock-constant-face ((t (:foreground "goldenrod2"))))
 '(font-lock-function-face ((t (:foreground "turquoise2"))))
 '(font-lock-keyword-face ((t (:foreground "MediumOrchid1" :weight bold))))
 '(font-lock-string-face ((t (:foreground "wheat1" :slant normal))))
 '(font-lock-variable-name-face ((t (:foreground "SpringGreen1" :slant normal :weight bold))))
 '(highlight ((t (:background "cyan" :foreground "black" :weight bold))))
 '(highlight-indentation-current-column-face ((t (:background "yellow4" :weight light))))
 '(lazy-highlight ((t (:background "LightGoldenrod1" :foreground "black" :weight bold))))
 '(minibuffer-prompt ((t (:foreground "CadetBlue3" :weight bold))))
 '(mode-line-buffer-id ((t (:foreground "light green" :weight bold))))
 '(region ((t (:background "#5e5e5e"))))
 '(snails-content-buffer-face ((t (:background "#111" :height 110))))
 '(snails-header-line-face ((t (:inherit font-lock-function-name-face :underline t :height 1.1))))
 '(snails-input-buffer-face ((t (:background "#222" :foreground "gold" :height 110))))
 '(vc-annotate-face-032f62 ((t nil)) t)
 '(vc-annotate-face-22863a ((t nil)) t)
 '(vc-annotate-face-6a737d ((t nil)) t)
 '(whitespace-line ((t (:inherit default))))
 '(whitespace-space ((t (:foreground "grey19")))))

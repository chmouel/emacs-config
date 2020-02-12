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
 '(ac-dictionary-directories
   (quote
    ((expand-file-name
      (concat user-emacs-directory "/dict")))))
 '(ac-dictionary-files
   (quote
    ((expand-file-name
      (concat user-emacs-directory "/packages/auto-complete/dict/")))))
 '(ac-trigger-key "M-TAB")
 '(ace-jump-mode-gray-background nil t)
 '(ack-and-a-half-arguments (quote ("--ignore-dir .tox" "-k" "--ignore-dir vendor/")))
 '(ack-executable "/usr/bin/ack-grep")
 '(ag-reuse-buffers t)
 '(ajb-bs-configuration "files" t)
 '(all-christian-calendar-holidays t)
 '(atomic-chrome-buffer-frame-height 80)
 '(atomic-chrome-buffer-open-style (quote split))
 '(atomic-chrome-url-major-mode-alist
   (quote
    (("https://github.com/.*/issues/.*" . markdown-mode)
     ("https://mail.google.com/.*" . message-mode))))
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
 '(centaur-tabs-cycle-scope (quote tabs))
 '(centaur-tabs-gray-out-icons (quote buffer))
 '(centaur-tabs-modified-marker "﹡")
 '(centaur-tabs-set-bar (quote under))
 '(centaur-tabs-set-icons t)
 '(centaur-tabs-set-modified-marker t)
 '(company-idle-delay 0.3)
 '(compilation-ask-about-save nil)
 '(compilation-scroll-output (quote first-error))
 '(compile-command "")
 '(completion-ignored-extensions
   (quote
    (".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".pyc" ".pyo" ".gitignore" ".class")))
 '(completion-styles (quote (basic partial-completion emacs22 initials)))
 '(confirm-kill-processes nil)
 '(counsel-ack-base-command "ack --nocolor --nogroup %s")
 '(counsel-ag-base-command "ag --ignore \"vendor/*\" --nocolor --nogroup %s")
 '(ctags-update-other-options
   (quote
    ("--exclude='*.pyc'" "--exclude='*.elc'" "--exclude='*.class'" "--exclude='.git'" "--exclude='.svn'" "--exclude='SCCS'" "--exclude='RCS'" "--exclude='CVS'" "--exclude='EIFGEN'" "--exclude='.tox'" "--exclude='.venv'" "--python-kinds='-i'")))
 '(custom-safe-themes
   (quote
    ("4b0b568d63b1c6f6dddb080b476cfba43a8bbc34187c3583165e8fb5bbfde3dc" "5091eadbb87fa0a168a65f2c3e579d1a648d764f12ab9d3ab7bdefca709cd2a5" "5e0b63e0373472b2e1cf1ebcc27058a683166ab544ef701a6e7f2a9f33a23726" "669e05b25859b9e5b6b9809aa513d76dd35bf21c0f16d8cbb80fb0727dc8f842" "32fd809c28baa5813b6ca639e736946579159098d7768af6c68d78ffa32063f4" "f7b230ac0a42fc7e93cd0a5976979bd448a857cd82a097048de24e985ca7e4b2" "b60f08ddc98a95485ec19f046a81d5877b26ab80a67782ea5b91a00ea4f52170" "a4fa3280ffa1f2083c5d4dab44a7207f3f7bcb76e720d304bd3bd640f37b4bef" "c6b93ff250f8546c7ad0838534d46e616a374d5cb86663a9ad0807fd0aeb1d16" "a02836a5807a687c982d47728e54ff42a91bc9e6621f7fe7205b0225db677f07" "1897b97f63e91a792e8540c06402f29d5edcbfb0aafd64b1b14270663d6868ee" "e47c0abe03e0484ddadf2ae57d32b0f29f0b2ddfe7ec810bd6d558765d9a6a6c" "b9dda6ca36e825766dfada5274cf18d8a5bce70676b786e3260094e0cd8c0e62" "53f8223005ceb058848fb92c2c4752ffdfcd771f8ad4324b3d0a4674dec56c44" "f3455b91943e9664af7998cc2c458cfc17e674b6443891f519266e5b3c51799d" "e7666261f46e2f4f42fd1f9aa1875bdb81d17cc7a121533cad3e0d724f12faf2" "dd854be6626a4243375fd290fec71ed4befe90f1186eb5b485a9266011e15b29" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "0c9f63c9d90d0d135935392873cd016cc1767638de92841a5b277481f1ec1f4a" "09cadcc2784baa744c6a7c5ebf2a30df59c275414768b0719b800cabd8d1b842" "930f7841c24772dda4f22291e510dac1d58813b59dcb9f54ad4f1943ea89cdcd" "e7b49145d311e86da34a32a7e1f73497fa365110a813d2ecd8105eaa551969da" "e61752b5a3af12be08e99d076aedadd76052137560b7e684a8be2f8d2958edc3" "0bff60fb779498e69ea705825a2ca1a5497a4fccef93bf3275705c2d27528f2f" "f951343d4bbe5a90dba0f058de8317ca58a6822faa65d8463b0e751a07ec887c" "2bd0a595cbed0e18370692aeb9f8953b522bd2eeb9bdcb14800d0eeb15d93378" "6bc387a588201caf31151205e4e468f382ecc0b888bac98b2b525006f7cb3307" "1a1cdd9b407ceb299b73e4afd1b63d01bbf2e056ec47a9d95901f4198a0d2428" "de1f10725856538a8c373b3a314d41b450b8eba21d653c4a4498d52bb801ecd2" "43b219a31db8fddfdc8fdbfdbd97e3d64c09c1c9fdd5dff83f3ffc2ddb8f0ba0" "73c69e346ec1cb3d1508c2447f6518a6e582851792a8c0e57a22d6b9948071b4" "20bf9f519f78b247da9ccf974c31d3537bee613ff11579f539b2781246dee73b" "2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" "d8dc153c58354d612b2576fea87fe676a3a5d43bcc71170c62ddde4a1ad9e1fb" "37ba833442e0c5155a46df21446cadbe623440ccb6bbd61382eb869a2b9e9bf9" "462d6915a7eac1c6f00d5acd8b08ae379e12db2341e7d3eac44ff7f984a5e579" "0329c772ed96053a73b9ddddf96c1183e23c267955bbdf78e7933057ce9da04b" "1d2f406a342499f0098f9388b87d05ec9b28ccb12ca548f4f5fa80ae368235b6" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "d21135150e22e58f8c656ec04530872831baebf5a1c3688030d119c114233c24" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "cf284fac2a56d242ace50b6d2c438fcc6b4090137f1631e32bedf19495124600" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "0d456bc74e0ffa4bf5b69b0b54dac5104512c324199e96fc9f3a1db10dfa31f3" "f11e219c9d043cbd5f4b2e01713c2c24a948a98bed48828dc670bd64ae771aa1" "af4dc574b2f96f5345d55b98af024e2db9b9bbf1872b3132bc66dffbf5e1ba1d" "19b9349a6b442a2b50e5b82be9de45034f9b08fa36909e0b1be09433234610bb" "abe3405767afe98b35b6a2b212af1fbc34e4f4c455310d2b7f2ffd2ec81d387b" "862a0ccc73c12df4df325427f9285fa6a5bbba593a77257f43b01c84269f51b0" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "59e82a683db7129c0142b4b5a35dbbeaf8e01a4b81588f8c163bd255b76f4d21" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(cycbuf-buffer-sort-function (quote cycbuf-sort-by-recency))
 '(cycbuf-dont-show-regexp (quote ("^ " "^\\*cycbuf\\*$" "^\\*Messages\\*#")))
 '(cycbuf-mode-name-replacements
   (quote
    (("Fundamental" "Fund.")
     ("Lisp Interaction" "Lisp I.")
     ("Python" "Py"))))
 '(cycle-themes-mode t)
 '(dashboard-banner-logo-title "Welcome to ChmouMACS!!" t)
 '(dashboard-center-content t t nil "Customized with use-package dashboard")
 '(dashboard-items (quote ((recents . 10) (projects . 10) (bookmarks . 5))) t)
 '(dashboard-set-file-icons t t)
 '(dashboard-set-heading-icons t t)
 '(dashboard-startup-banner (quote logo) t)
 '(default-major-mode (quote text-mode) t)
 '(delete-by-moving-to-trash t)
 '(diff-switches "-uw")
 '(dired-auto-revert-buffer (quote dired-directory-changed-p))
 '(dired-omit-files
   "^\\.\\|^\\.?#\\|^\\.$\\|^\\.\\.$\\|^Thumbs.db$\\|\\.svn$\\|\\.git\\(ignore\\)?\\|\\.pyc$\\|^\\.coverage$\\|^TAGS$\\|^tags$\\|\\.class$\\|\\.DS_Store\\|\\.localized$\\|__pycache__$")
 '(direnv-always-show-summary t)
 '(direnv-show-paths-in-summary nil)
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
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(electric-pair-mode t)
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
 '(eshell-directory-name
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/eshell/")))
 '(eshell-modules-list
   (quote
    (eshell-alias eshell-banner eshell-basic eshell-cmpl eshell-dirs eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-rebind eshell-script)))
 '(exec-path-from-shell-check-startup-files nil)
 '(fci-rule-color "#6a737d")
 '(fill-column 80)
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(flycheck-checkers
   (quote
    (ada-gnat asciidoctor asciidoc c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint d-dmd dockerfile-hadolint elixir-dogma emacs-lisp emacs-lisp-checkdoc erlang eruby-erubis fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy javascript-jshint javascript-gjslint javascript-jscs javascript-standard json-jsonlint json-python-json less lua-luacheck lua perl perl-perlcritic php php-phpmd php-phpcs processing protobuf-protoc pug puppet-parser puppet-lint python-flake8 python-pylint python-pycompile r-lintr racket rpm-rpmlint markdown-mdl rst-sphinx rst ruby-rubocop ruby-rubylint ruby ruby-jruby rust-cargo rust scala scala-scalastyle scheme-chicken scss-lint sass/scss-sass-lint sass scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tex-chktex tex-lacheck texinfo typescript-tslint verilog-verilator xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby)))
 '(flycheck-disabled-checkers
   (quote
    (html-tidy xml-xmlint emacs-lisp emacs-lisp-checkdoc javascript-eslint)))
 '(flycheck-display-errors-delay 0.1)
 '(flycheck-highlighting-mode (quote lines))
 '(font-use-system-font t)
 '(forge-database-file
   "/Users/chmouel/.emacs.d/auto-save-list/forge-database.sqlite" t)
 '(fringe-mode (quote (1 . 1)) nil (fringe))
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
 '(gnus-user-agent (quote (gnus emacs)))
 '(go-playground-ask-for-file-name t t)
 '(grep-scroll-output t)
 '(grep-window-height 10)
 '(groovy-indent-offset 2)
 '(gud-tooltip-echo-area t)
 '(gui-select-enable-clipboard t)
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
 '(ibuffer-saved-filter-groups
   (quote
    (("default"
      ("Files"
       (not mode . dired-mode)
       (name . "^[^*]"))
      ("Directories"
       (mode . dired-mode))))))
 '(ibuffer-show-empty-filter-groups nil)
 '(ibuffer-truncate-lines nil)
 '(ibuffer-use-other-window nil)
 '(ido-enable-flex-matching t nil nil "Customized with use-package flx-ido")
 '(ido-enable-last-directory-history t)
 '(ido-enable-tramp-completion nil)
 '(ido-ignore-directories (quote ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`\\.svn/")))
 '(ido-max-prospects 5 nil nil "Customized with use-package ido-vertical-mode")
 '(ido-mode (quote buffer) nil (ido))
 '(ido-rotate-file-list-default t)
 '(ido-save-directory-list-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/ido.last")))
 '(ido-show-dot-for-dired t)
 '(ido-use-faces nil nil nil "Customized with use-package flx-ido")
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(igrep-options "-I")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "english")
 '(ispell-extra-args (quote ("--sug-mode=ultra")))
 '(ispell-message-dictionary-alist (quote (("^To:[^\\n,]+\\\\.fr[ \\t\\n,>]" . "francais"))))
 '(ispell-program-name "aspell")
 '(ivy-mode nil)
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
 '(jdee-db-active-breakpoint-face-colors (cons "#2b2a27" "#ff5d38"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#2b2a27" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#2b2a27" "#3f444a"))
 '(js-indent-level 2)
 '(kill-do-not-save-duplicates t)
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(lsp-auto-guess-root t)
 '(lsp-document-highlight-delay 2.0 t)
 '(lsp-eldoc-render-all t)
 '(lsp-enable-file-watchers nil)
 '(lsp-enable-links t)
 '(lsp-enable-snippet t)
 '(lsp-file-watch-ignored
   (quote
    ("[/\\\\]\\.git$" "[/\\\\]\\.hg$" "[/\\\\]\\.bzr$" "[/\\\\]_darcs$" "[/\\\\]\\.svn$" "[/\\\\]_FOSSIL_$" "[/\\\\]\\.idea$" "[/\\\\]\\.ensime_cache$" "[/\\\\]\\.eunit$" "[/\\\\]node_modules$" "[/\\\\]\\.fslckout$" "[/\\\\]\\.tox$" "[/\\\\]\\.stack-work$" "[/\\\\]\\.bloop$" "[/\\\\]\\.metals$" "[/\\\\]target$" "[/\\\\]\\.deps$" "[/\\\\]build-aux$" "[/\\\\]autom4te.cache$" "[/\\\\]\\.reference$")))
 '(lsp-file-watch-threshold 500)
 '(lsp-gopls-complete-unimported t t)
 '(lsp-gopls-staticcheck t t)
 '(lsp-prefer-flymake nil)
 '(lsp-ui-doc-enable t)
 '(lsp-ui-doc-max-height 15)
 '(lsp-ui-doc-max-width 30)
 '(lsp-ui-flycheck-enable t)
 '(lsp-ui-imenu-enable t)
 '(lsp-ui-peek-enable t)
 '(lsp-ui-sideline-delay 0.5)
 '(magit-commit-show-diff nil)
 '(magit-commit-signoff t)
 '(magit-completing-read-function (quote magit-ido-completing-read))
 '(magit-expand-staged-on-commit (quote full))
 '(magit-log-arguments (quote ("--graph" "--decorate" "--no-merges")))
 '(magit-log-auto-more t)
 '(magit-visit-ref-behavior (quote (checkout-branch)))
 '(make-backup-files nil)
 '(max-specpdl-size 50000)
 '(mc/list-file "~/.emacs.d/auto-save-list/mc-lists.el")
 '(mm-inline-text-html-with-w3m-keymap nil)
 '(multi-compile-history-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/multi-compile.cache")))
 '(nrepl-message-colors
   (quote
    ("#032f62" "#6a737d" "#d73a49" "#6a737d" "#005cc5" "#6f42c1" "#d73a49" "#6a737d")))
 '(oauth2-token-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/oauth2.plstore")))
 '(org-agenda-files nil)
 '(org-src-fontify-natively t)
 '(org-startup-folded nil)
 '(package-archives
   (quote
    (("melpa-unstable" . "http://melpa.org/packages/")
     ("GNU" . "http://elpa.gnu.org/packages/"))))
 '(package-selected-packages
   (quote
    (go-test sqlite magit-section jinja2-mode ripgrep grip-mode zoom-mode zoom emojify doom-themes centaur-tabs centaur-tab which-key awesome-tab all-the-icons-dired all-the-icons exec-path-from-shell vterm ace-jump-buffer ace-window dashboard jira-markup-mode lsp-ui py-isort subr-x docker-tramp ibuffer-tramp kubernetes-tramp helm-org general direnv pytest ibuffer-git esh-autosuggest diredfl git-commit-insert-issue evil monokai-pro monokai-alt monokai-pro-theme monokai-theme goto-last-change company-lsp jsx-mode auto-complete multiple-cursors forge mmm-mode ag rg deadgrep inf-ruby gitconfig-mode yaml-imenu yaml-mode counsel flycheck-rust rust-auto-use rust-playground rust-mode reformatter multi-compile-run multi-compile yapf-mode yapf crux adoc color-moccur use-package-chords github-issues direx lorem-ipsum pyimport flycheck-plantuml plantuml-mode indent-guide projectile evil-matchit-mode elisp emacs-lisp elisp-mode emacs-lisp-mode info-colors magithub shell-mode message isearch abbrev dired dired-x lisp-mode misc anzu page diminish ns-win moe popup-kill-ring pdf-tools imenu-list github-clone indent-tools git-auto-commit-mode helm-lean applescript-mode browse-at-remote go-impl dumb-jump groovy-mode the-org-mode-expansions kubernetes flycheck-yamllint avy commenter gist zop-to-char js2-mode jsfmt go-add-tags wgrep-ag flycheck-gometalinter go-stacktracer js-auto-beautify go-guru highlight-indentation esqlite go-errcheck go-snippets go-playground golint go-rename toggle-quotes zygospore zenburn-theme yasnippet yascroll window-number wgrep web use-package try smex smart-shift smart-mode-line rpm-spec-mode request-deferred regex-tool queue python-docstring pyfmt powerline php-mode pcsv pcache paredit package-safe-delete message-x marmalade magit-find-file json-rpc json-mode isearch-dabbrev ido-vertical-mode ido-completing-read+ ibuffer-vc hungry-delete htmlize highlight-numbers highlight-80+ google-this go-eldoc github-browse-file fringe-helper flycheck flx-ido find-file-in-git-repo fill-column-indicator expand-region dropdown-list dockerfile-mode csv-mode csharp-mode company-go company-anaconda comment-dwim-2 browse-kill-ring boxquote bm bbdb aggressive-indent)))
 '(package-user-dir
   (expand-file-name
    (concat user-emacs-directory "/packages")))
 '(pdf-view-midnight-colors (quote ("#6a737d" . "#fffbdd")))
 '(plantuml-default-exec-mode (quote jar))
 '(plantuml-jar-path "/usr/local/Cellar/plantuml/1.2019.13/libexec/plantuml.jar")
 '(powerline-default-separator (quote curve))
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
 '(projectile-mode-line-function (quote my-projectile-mode-line))
 '(projectile-mode-line-prefix " PRJ")
 '(projectile-project-root-files
   (quote
    ("rebar.config" "project.clj" "SConstruct" "pom.xml" "build.sbt" "build.gradle" "Gemfile" "requirements.txt" "package.json" "gulpfile.js" "Gruntfile.js" "bower.json" "composer.json" "Cargo.toml" "mix.exs" "tox.ini")))
 '(rcirc-always-use-server-buffer-flag t)
 '(rcirc-default-full-name "Chmouel Boudjnah")
 '(rcirc-default-nick "chmouel")
 '(rcirc-default-user-name "chmouel")
 '(rcirc-fill-column (quote frame-width))
 '(rcirc-omit-responses (quote ("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE")))
 '(rcirc-prompt "[%t] ")
 '(rcirc-scroll-show-maximum-output t)
 '(read-mail-command (quote gnus))
 '(reb-re-syntax (quote sregex))
 '(recent-addresses-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/recent-addresses")))
 '(recentf-auto-cleanup (quote mode))
 '(recentf-exclude (quote ("^(/var/\\\\|/etc\\\\|/Applications\\\\).*")))
 '(recentf-filename-handlers (quote abbreviate-file-name))
 '(recentf-max-saved-items 500)
 '(recentf-save-file "~/.emacs.d/auto-save-list/recent-file-list.el")
 '(regex-tool-backend (quote perl))
 '(request-storage-directory
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/request")))
 '(require-final-newline (quote visit-save))
 '(rg-ignore-case (quote smart))
 '(rst-level-face-base-color "dark slate gray")
 '(safe-local-variable-values (quote ((c-hanging-comment-ender-p))))
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
 '(smex-save-file "~/.emacs.d/auto-save-list/smex-items")
 '(split-width-threshold nil)
 '(svn-status-display-full-path t)
 '(svn-status-hide-unmodified t)
 '(svn-status-wash-control-M-in-process-buffers t)
 '(swbuff-exclude-buffer-regexps (quote ("^ " "^\\*" "^newsrc-dribble$" "^bbdb$")))
 '(synosaurus-backend (quote synosaurus-backend-openthesaurus))
 '(tab-width 4)
 '(tags-revert-without-query t)
 '(tramp-chunksize 500 nil (tramp))
 '(tramp-mode t nil (tramp))
 '(tramp-persistency-file-name
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/tramp")))
 '(undo-tree-auto-save-history t)
 '(undo-tree-enable-undo-in-region t)
 '(undo-tree-incompatible-major-modes (quote (term-mode)))
 '(url-cookie-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/cookies")))
 '(use-file-dialog nil)
 '(user-full-name "Chmouel Boudjnah")
 '(user-mail-address "chmouel@chmouel.com")
 '(vc-annotate-background "#3390ff")
 '(vc-annotate-color-map
   (quote
    ((20 . "#6a737d")
     (40 . "#032f62")
     (60 . "#6a737d")
     (80 . "#6a737d")
     (100 . "#6a737d")
     (120 . "#d73a49")
     (140 . "#6a737d")
     (160 . "#6a737d")
     (180 . "#6a737d")
     (200 . "#6a737d")
     (220 . "#22863a")
     (240 . "#005cc5")
     (260 . "#6f42c1")
     (280 . "#6a737d")
     (300 . "#005cc5")
     (320 . "#6a737d")
     (340 . "#d73a49")
     (360 . "#6a737d"))))
 '(vc-annotate-very-old-color "#6a737d")
 '(vc-follow-symlinks t)
 '(warning-suppress-types (quote ((undo disard-info))))
 '(wdired-enable t)
 '(weechat-auto-monitor-buffers t)
 '(weechat-auto-monitor-new-buffers t)
 '(weechat-buffer-kill-buffers-on-disconnect nil)
 '(weechat-initial-lines 200)
 '(weechat-mode-default (quote ssl))
 '(weechat-notification-mode t)
 '(weechat-port-default 9001)
 '(whitespace-display-mappings
   (quote
    ((space-mark 32
                 [183]
                 [46])
     (space-mark 160
                 [164]
                 [95])
     (tab-mark 9
               [187 9]
               [92 9]))))
 '(whitespace-line-column 300)
 '(window-number-meta-mode t)
 '(woman-use-own-frame nil)
 '(x-underline-at-descent-line t)
 '(yas-prompt-functions (quote (yas/dropdown-prompt)))
 '(yas-wrap-around-region t)
 '(yas/prompt-functions (quote (yas/dropdown-prompt)))
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
 '(diredfl-date-time ((t (:foreground "burlywood2"))))
 '(diredfl-file-name ((t (:foreground "gray91"))))
 '(font-lock-comment-face ((t (:foreground "#878787" :slant normal :weight bold))))
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
 '(whitespace-line ((t (:inherit default)))))

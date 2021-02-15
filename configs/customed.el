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
 '(ajb-bs-configuration "files")
 '(all-christian-calendar-holidays t)
 '(atomic-chrome-buffer-frame-height 80)
 '(atomic-chrome-buffer-open-style 'split)
 '(atomic-chrome-url-major-mode-alist
   '(("https://github.com/.*/issues/.*" . markdown-mode)
     ("https://mail.google.com/.*" . message-mode)))
 '(auto-install-directory (expand-file-name (concat user-emacs-directory "/modes/")))
 '(battery-mode-line-format "--[%b%p%%]" t)
 '(bc-bookmark-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/breadcrumb.el")))
 '(blacken-line-length 80)
 '(bookmark-save-flag 1)
 '(bufler-reverse t)
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
 '(compilation-ask-about-save nil)
 '(compilation-scroll-output 'first-error)
 '(compile-command "")
 '(confirm-kill-processes nil)
 '(ctags-update-other-options
   '("--exclude='*.pyc'" "--exclude='*.elc'" "--exclude='*.class'" "--exclude='.git'" "--exclude='.svn'" "--exclude='SCCS'" "--exclude='RCS'" "--exclude='CVS'" "--exclude='EIFGEN'" "--exclude='.tox'" "--exclude='.venv'" "--python-kinds='-i'"))
 '(custom-safe-themes
   '("b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "2c49d6ac8c0bf19648c9d2eabec9b246d46cb94d83713eaae4f26b49a8183fc4" "3df5335c36b40e417fec0392532c1b82b79114a05d5ade62cfe3de63a59bc5c6" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "8d7684de9abb5a770fbfd72a14506d6b4add9a7d30942c6285f020d41d76e0fa" "7b3d184d2955990e4df1162aeff6bfb4e1c3e822368f0359e15e2974235d9fa8" "5036346b7b232c57f76e8fb72a9c0558174f87760113546d3a9838130f1cdb74" "730a87ed3dc2bf318f3ea3626ce21fb054cd3a1471dcd59c81a4071df02cb601" "6c3b5f4391572c4176908bb30eddc1718344b8eaff50e162e36f271f6de015ca" default))
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
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
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
 '(electric-quote-replace-double t)
 '(elscreen-tab-width 23)
 '(emacs-lock-default-locking-mode 'kill)
 '(emerge-diff-options "--ignore-all-space" t nil "Customized with use-package ediff")
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
 '(fill-column 80)
 '(flycheck-check-syntax-automatically '(save mode-enabled))
 '(flycheck-checkers
   '(tex-aspell-dynamic ada-gnat asciidoctor asciidoc awk-gawk bazel-buildifier c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint css-stylelint cuda-nvcc cwl d-dmd dockerfile-hadolint elixir-credo emacs-lisp emacs-lisp-checkdoc ember-template erlang-rebar3 erlang eruby-erubis eruby-ruumba fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert go-staticcheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy javascript-eslint javascript-jshint javascript-standard json-jsonlint json-python-json json-jq jsonnet less less-stylelint llvm-llc lua-luacheck lua markdown-markdownlint-cli nix nix-linter opam perl perl-perlcritic php php-phpmd php-phpcs processing proselint protobuf-protoc protobuf-prototool pug puppet-parser puppet-lint python-flake8 python-pylint python-pycompile python-mypy r-lintr racket rpm-rpmlint rst-sphinx rst ruby-rubocop ruby-standard ruby-reek ruby-rubylint ruby ruby-jruby rust-cargo rust rust-clippy scala scala-scalastyle scheme-chicken scss-lint scss-stylelint sass/scss-sass-lint sass scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tcl-nagelfar terraform terraform-tflint tex-chktex tex-lacheck texinfo textlint typescript-tslint verilog-verilator vhdl-ghdl xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby yaml-yamllint))
 '(font-use-system-font t)
 '(forge-database-file
   "/Users/chmouel/.emacs.d/auto-save-list/forge-database.sqlite" t)
 '(fringe-mode '(1 . 1) nil (fringe))
 '(gc-cons-threshold 100000000)
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
   '(try-complete-file-name-partially try-complete-file-name yas/hippie-try-expand try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-all-abbrevs try-expand-list try-expand-line try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol) nil nil "Customized with use-package hippie-exp")
 '(hl-line-sticky-flag nil)
 '(home-end-enable t)
 '(html-inlined-install-modes '(nxml-mode nxhtmlmode html-mode php-mode))
 '(html-inlined-key [f12])
 '(ibuffer-always-compile-formats t)
 '(ibuffer-elide-long-columns t)
 '(ibuffer-expert t)
 '(ibuffer-projectile-prefix "")
 '(ibuffer-show-empty-filter-groups nil)
 '(ibuffer-truncate-lines nil)
 '(ibuffer-use-other-window nil)
 '(igrep-options "-I")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "english")
 '(ispell-extra-args '("--sug-mode=ultra"))
 '(ispell-message-dictionary-alist '(("^To:[^\\n,]+\\\\.fr[ \\t\\n,>]" . "francais")))
 '(ispell-program-name "aspell")
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
 '(js-indent-level 2)
 '(kill-do-not-save-duplicates t)
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(lsp-diagnostic-package :none)
 '(lsp-diagnostics-provider :none)
 '(lsp-modeline-diagnostics-enable nil)
 '(magit-commit-show-diff nil)
 '(magit-commit-signoff t)
 '(magit-expand-staged-on-commit 'full)
 '(magit-log-arguments '("--graph" "--decorate" "--no-merges"))
 '(magit-log-auto-more t)
 '(magit-visit-ref-behavior '(checkout-branch))
 '(make-backup-files nil)
 '(max-specpdl-size 50000)
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
 '(package-quickstart t)
 '(package-selected-packages
   '(w3m emojify bbdb ctrlxo helpful helm-swoop embark rustic mini-frame flycheck-color-mode-line avy-embark-collect icomplete-vertical svg-mode-line-themes marginalia selectrum-prescient embark-consult paste-of-code yaml-mode yaml easy-kill hungry-delete hungry-delete-mode exec-path-from-shell magit smart-mode-line-powerline-theme php-mode js2-mode jsx-mode rcirc-alertify ibuffer-projectile go-playground treemacs multi-compile aggressive-indent smartparens eshell-toggle rich-minority lsp-ui lsp-mode rg helm ido-vertical-mode plantuml-mode which-key deadgrep reformatter dockerfile-mode dumb-jump powerline yascroll auto-complete popup multiple-cursors yasnippet doom-themes crux diredfl diff-hl grip-mode markdown-mode "smex" git-messenger slack rainbow-delimiters treemacs-magit treemacs-all-the-icons poly-org poly-slim poly-markdown polymode cyphejor pinyinlib ivy-xref ivy-yasnippet ivy-prescient company-prescient yasnippet-snippets fzf evil-numbers company-box drag-stuff all-the-icons-ivy lsp-ivy lsp-treemacs yapfify bufler python-black eshell-did-you-mean go-dlv dired-sidebar blacken dash-functional minibuffer company-quickhelp mustache-mode all-the-icons-ibuffer go-test sqlite ripgrep zoom-mode centaur-tab awesome-tab all-the-icons-dired ace-window jira-markup-mode py-isort subr-x docker-tramp ibuffer-tramp kubernetes-tramp helm-org general direnv pytest ibuffer-git esh-autosuggest evil monokai-pro monokai-alt monokai-pro-theme goto-last-change ag gitconfig-mode yaml-imenu flycheck-rust rust-auto-use rust-playground multi-compile-run yapf-mode yapf adoc color-moccur github-issues direx lorem-ipsum pyimport flycheck-plantuml evil-matchit-mode elisp emacs-lisp elisp-mode emacs-lisp-mode info-colors magithub shell-mode message isearch abbrev dired dired-x lisp-mode misc anzu page diminish ns-win moe popup-kill-ring pdf-tools imenu-list github-clone indent-tools helm-lean applescript-mode go-impl the-org-mode-expansions flycheck-yamllint avy commenter gist zop-to-char jsfmt go-add-tags wgrep-ag flycheck-gometalinter go-stacktracer js-auto-beautify highlight-indentation esqlite go-errcheck go-snippets golint go-rename toggle-quotes zygospore window-number wgrep web use-package try smex smart-shift smart-mode-line rpm-spec-mode request-deferred regex-tool queue python-docstring pyfmt pcsv pcache paredit package-safe-delete message-x marmalade magit-find-file json-mode isearch-dabbrev ido-completing-read+ highlight-80+ google-this go-eldoc fringe-helper flx-ido find-file-in-git-repo expand-region dropdown-list csv-mode company-go company-anaconda comment-dwim-2 browse-kill-ring boxquote bm))
 '(package-user-dir
   (expand-file-name
    (concat user-emacs-directory "/packages")))
 '(plantuml-default-exec-mode 'jar)
 '(powerline-default-separator 'curve)
 '(powerline-gui-use-vcs-glyph t)
 '(rcirc-always-use-server-buffer-flag t)
 '(rcirc-default-full-name "Chmouel Boudjnah")
 '(rcirc-default-nick "chmouel")
 '(rcirc-default-user-name "chmouel")
 '(rcirc-fill-column 'frame-width)
 '(rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY" "MODE"))
 '(rcirc-prompt "[%t] ")
 '(rcirc-scroll-show-maximum-output t)
 '(reb-re-syntax 'sregex)
 '(recent-addresses-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/recent-addresses")))
 '(recentf-auto-cleanup 'mode)
 '(recentf-exclude '("^(/var/\\\\|/etc\\\\|/Applications\\\\).*"))
 '(recentf-filename-handlers 'abbreviate-file-name)
 '(recentf-max-saved-items 500)
 '(regex-tool-backend 'perl)
 '(request-storage-directory
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/request")))
 '(require-final-newline 'visit-save)
 '(rst-level-face-base-color "dark slate gray")
 '(safe-local-variable-values '((c-hanging-comment-ender-p)))
 '(save-interprogram-paste-before-kill t)
 '(save-place-mode t nil (saveplace))
 '(savehist-file
   (expand-file-name
    (concat user-emacs-directory "/auto-save-list/history")))
 '(savehist-mode t)
 '(server-use-tcp nil)
 '(server-window nil)
 '(sml/mode-width (if (eq (powerline-current-separator) 'arrow) 'right 'full))
 '(sml/pos-id-separator
   '(""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " " 'display
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   'powerline-active1 'powerline-active2)))
     (:propertize " " face powerline-active2)))
 '(sml/pos-minor-modes-separator
   '(""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " " 'display
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   'powerline-active1 'sml/global)))
     (:propertize " " face sml/global)))
 '(sml/pre-id-separator
   '(""
     (:propertize " " face sml/global)
     (:eval
      (propertize " " 'display
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   'sml/global 'powerline-active1)))
     (:propertize " " face powerline-active1)))
 '(sml/pre-minor-modes-separator
   '(""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " " 'display
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   'powerline-active2 'powerline-active1)))
     (:propertize " " face powerline-active1)))
 '(sml/pre-modes-separator (propertize " " 'face 'sml/modes))
 '(spaceline-all-the-icons-file-name-highlight "light blue")
 '(spaceline-all-the-icons-hide-long-buffer-path t)
 '(spaceline-all-the-icons-highlight-file-name t)
 '(spaceline-all-the-icons-window-number-always-visible t)
 '(split-width-threshold nil)
 '(svn-status-display-full-path t)
 '(svn-status-hide-unmodified t)
 '(svn-status-wash-control-M-in-process-buffers t)
 '(swbuff-exclude-buffer-regexps '("^ " "^\\*" "^newsrc-dribble$" "^bbdb$"))
 '(synosaurus-backend 'synosaurus-backend-openthesaurus)
 '(tab-bar-select-tab-modifiers '(super) nil nil "Customized with use-package tab-bar")
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
 '(world-clock-list
   '(("Europe/London" "London")
     ("Europe/Paris" "Paris")
     ("America/Chicago" "San Antonio")
     ("America/Los_Angeles" "San-Francisco")
     ("Australia/Sydney" "Sydney")))
 '(x-underline-at-descent-line t)
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
 '(diff-hl-change ((t (:background nil :foreground "green"))))
 '(diff-hl-delete ((t (:background nil :foreground "red"))))
 '(diff-hl-margin-ignored ((t (:background nil :foreground "magenta"))))
 '(diff-hl-margin-unknown ((t (:background nil :foreground "yellow"))))
 '(font-lock-variable-name-face ((t (:foreground "#50fa7b"))))
 '(gnus-summary-normal-read ((t (:foreground "gray68"))))
 '(gnus-summary-normal-unread ((t (:foreground "gray100" :bold t))))
 '(gnus-summary-selected ((t (:foreground "gray" :bold t))))
 '(helm-selection ((t (:background "gray19" :foreground "gold"))))
 '(helm-separator ((t (:foreground "white"))))
 '(highlight ((t (:background "gray19"))))
 '(highlight-indentation-face ((t (:inherit default :foreground "#878787"))))
 '(hl-line ((t (:background "DodgerBlue4"))))
 '(message-header-name ((t (:foreground "#50fa7b"))))
 '(message-header-other ((t (:foreground "white"))))
 '(message-header-subject ((t (:foreground "grey75" :weight normal))))
 '(mode-line-buffer-id ((t (:foreground "Light Blue"))))
 '(selectrum-current-candidate ((t (:inherit highlight :underline nil))))
 '(selectrum-primary-highlight ((t (:inherit ivy-minibuffer-match-face-2))))
 '(selectrum-secondary-highlight ((t (:inherit ivy-highlight-face))))
 '(tab-bar ((t (:background "gray19"))))
 '(tab-bar-tab ((t (:foreground "gray2" :background "gold"))))
 '(tab-bar-tab-inactive ((t (:background "gray19" :foreground "Grey75")))))

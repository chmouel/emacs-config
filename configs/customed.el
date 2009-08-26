
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(all-christian-calendar-holidays t)
 '(anything-c-adaptive-history-file "~/.emacs.d/auto-save-list/anything-c-adaptive-history")
 '(auto-insert-directory "~/.emacs.d/snippets/autoinsert/")
 '(auto-insert-mode t)
 '(auto-insert-query nil)
 '(battery-mode-line-format "--[%b%p%%]")
 '(bc-bookmark-file "~/.emacs.d/auto-save-list/breadcrumb.el")
 '(bookmark-save-flag 1)
 '(c-basic-offset 4)
 '(canlock-password "38ebb79c7f0ece35d1103834941558b48e754833")
 '(color-theme-is-global t)
 '(compilation-ask-about-save nil)
 '(completion-ignored-extensions (quote (".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".pyc" ".pyo")))
 '(cursor-in-non-selected-windows nil)
 '(default-major-mode (quote text-mode))
 '(diff-switches "-uw")
 '(dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^Thumbs.db$\\|\\.svn$\\|\\.git\\(ignore\\)?\\|\\.pyc$\\|^\\.coverage$\\|^TAGS$\\|^tags$")
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(elscreen-tab-width 23)
 '(emerge-diff-options "--ignore-all-space")
 '(enable-local-variables :all)
 '(eshell-directory-name "~/.emacs.d/auto-save-list/eshell/")
 '(eshell-modules-list (quote (eshell-alias eshell-banner eshell-basic eshell-cmpl eshell-dirs eshell-glob eshell-hist eshell-ls eshell-pred eshell-prompt eshell-rebind eshell-script)))
 '(flymake-start-syntax-check-on-newline nil)
 '(gnus-init-file "~/.emacs.d/gnus/init.el")
 '(grep-scroll-output t)
 '(grep-window-height 10)
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
 '(ido-ignore-directories (quote ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`\\.svn/")))
 '(ido-mode (quote buffer) nil (ido))
 '(ido-save-directory-list-file "~/.emacs.d/auto-save-list/ido.last")
 '(ido-show-dot-for-dired t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-extra-args (quote ("--sug-mode=ultra")))
 '(ispell-message-dictionary-alist (quote (("^To:[^\\n,]+\\\\.fr[ \\t\\n,>]" . "francais"))))
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
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(mail-user-agent (quote gnus-user-agent))
 '(make-backup-files nil)
 '(max-specpdl-size 50000)
 '(mm-inline-text-html-with-w3m-keymap nil)
 '(rcirc-server-alist (quote (("localhost" :port 3333))))
 '(rcirc-track-minor-mode t)
 '(read-mail-command (quote gnus))
 '(reb-re-syntax (quote sregex))
 '(recentf-auto-cleanup 300)
 '(recentf-exclude (quote (".*/\\.news.*" ".*/\\.bbdb.*" ".*bookmarks.bmk.*" "/usr/share/emacs/.*/etc/.*" ".*loaddefs.el$")) t)
 '(recentf-save-file "~/.emacs.d/auto-save-list/recent-file-list.el")
 '(require-final-newline (quote visit-save))
 '(safe-local-variable-values (quote ((c-hanging-comment-ender-p))))
 '(save-place t nil (saveplace))
 '(save-place-file "~/.emacs.d/auto-save-list/emacs-places")
 '(savehist-file "~/.emacs.d/auto-save-list/history")
 '(savehist-mode t nil (savehist))
 '(server-mode t)
 '(server-window nil)
 '(svn-status-display-full-path t)
 '(svn-status-hide-unmodified t)
 '(svn-status-wash-control-M-in-process-buffers t)
 '(swbuff-exclude-buffer-regexps (quote ("^ " "^\\*" "^newsrc-dribble$" "^bbdb$")))
 '(tab-width 4)
 '(tags-revert-without-query t)
 '(tramp-chunksize 500)
 '(tramp-persistency-file-name "~/.emacs.d/auto-save-list/tramp")
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(user-full-name "Chmouel Boudjnah")
 '(user-mail-address "chmouel.boudjnah@rackspace.co.uk")
 '(wdired-enable t)
 '(woman-use-own-frame nil)
 '(x-select-enable-clipboard t))
(if 'nil
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:background "Brown" :foreground "LightSalmon" :weight bold))))
 '(flymake-warnline ((((class color)) (:background "Salmon" :foreground "White" :weight bold))))
 '(hl-line ((t (:foreground "Orange"))))
 '(jabber-roster-user-away ((t (:foreground "grey" :slant italic :weight normal))))
 '(jabber-roster-user-online ((t (:foreground "cyan" :slant normal :weight bold))))
 '(mode-line ((t (:background "#3e3e5e" :foreground "#ffdab9" :box (:line-width -1 :style released-button) :weight bold))))
 '(which-func ((((class color) (min-colors 88) (background dark)) (:foreground "Green"))))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(erc-input-face ((t (:foreground "white" :weight extra-bold))))
 '(erc-prompt-face ((t (:background "black" :foreground "Green"))))
 '(flymake-errline ((nil (:foreground "orange" :weight bold)))))

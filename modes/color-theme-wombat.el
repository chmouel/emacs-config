(require 'color-theme)
(defun color-theme-wombat ()
  "Color theme by Chmouel Boudjnah, created 2009-04-28."
  (interactive)
  (color-theme-install
   '(color-theme-wombat
     ((background-color . "#242424")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "#656565")
      (foreground-color . "#f6f3e8")
      (mouse-color . "black"))
     ((Man-overstrike-face . bold)
      (Man-reverse-face . highlight)
      (Man-underline-face . underline)
      (compilation-message-face . underline)
      (ibuffer-deletion-face . font-lock-type-face)
      (ibuffer-filter-group-name-face . bold)
      (ibuffer-marked-face . font-lock-warning-face)
      (ibuffer-title-face . font-lock-type-face)
      (ispell-highlight-face . flyspell-incorrect)
      (list-matching-lines-buffer-name-face . underline)
      (list-matching-lines-face . match)
      (rst-block-face . font-lock-keyword-face)
      (rst-comment-face . font-lock-comment-face)
      (rst-definition-face . font-lock-function-name-face)
      (rst-directive-face . font-lock-builtin-face)
      (rst-emphasis1-face quote italic)
      (rst-emphasis2-face quote bold)
      (rst-external-face . font-lock-type-face)
      (rst-level-face-base-color . "grey")
      (rst-literal-face . font-lock-string-face)
      (rst-reference-face . font-lock-variable-name-face)
      (snippet-bound-face . bold)
      (snippet-field-face . highlight)
      (view-highlight-face . highlight)
      (widget-mouse-face . highlight))
     (default ((t (:stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
     (anything-bookmarks-su-face ((t (:foreground "red"))))
     (anything-dir-heading ((t (:background "Pink" :foreground "Blue"))))
     (anything-dir-priv ((t (:background "LightGray" :foreground "DarkRed"))))
     (anything-file-name ((t (:foreground "Blue"))))
     (anything-gentoo-match-face ((t (:foreground "red"))))
     (anything-header ((t (:foreground "grey90" :background "grey20" :box (:line-width -1 :style released-button)))))
     (anything-isearch-match ((t (:background "Yellow"))))
     (anything-overlay-line-face ((t (:background "IndianRed4" :underline t))))
     (anything-visible-mark ((t (:background "green1" :foreground "black"))))
     (anything-w3m-bookmarks-face ((t (:foreground "cyan1" :underline t))))
     (bold ((t (:bold t :weight bold))))
     (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (bookmark-menu-heading ((t (:foreground "#cae682"))))
     (border ((t (nil))))
     (buffer-menu-buffer ((t (:bold t :weight bold))))
     (button ((t (:underline t))))
     (comint-highlight-input ((t (:bold t :weight bold))))
     (comint-highlight-prompt ((t (:foreground "cyan1"))))
     (compilation-column-number ((t (:foreground "#cae682"))))
     (compilation-error ((t (:bold t :weight bold :foreground "Pink"))))
     (compilation-info ((t (:bold t :foreground "Green1" :weight bold))))
     (compilation-line-number ((t (:foreground "#cae682"))))
     (compilation-warning ((t (:bold t :foreground "Orange" :weight bold))))
     (completions-common-part ((t (:family "DejaVu Sans Mono" :foundry "unknown" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#f6f3e8" :background "#242424" :stipple nil :height 120))))
     (completions-first-difference ((t (:bold t :weight bold))))
     (cursor ((t (:background "#656565"))))
     (custom-button ((t (:background "lightgrey" :foreground "black" :box (:line-width 2 :style released-button)))))
     (custom-button-mouse ((t (:background "grey90" :foreground "black" :box (:line-width 2 :style released-button)))))
     (custom-button-pressed ((t (:background "lightgrey" :foreground "black" :box (:line-width 2 :style pressed-button)))))
     (custom-button-pressed-unraised ((t (:underline t :foreground "violet"))))
     (custom-button-unraised ((t (:underline t))))
     (custom-changed ((t (:background "blue1" :foreground "white"))))
     (custom-comment ((t (:background "dim gray"))))
     (custom-comment-tag ((t (:foreground "gray80"))))
     (custom-documentation ((t (nil))))
     (custom-face-tag ((t (:bold t :weight bold :foreground "light blue"))))
     (custom-group-tag ((t (:bold t :family "Sans Serif" :foreground "light blue" :weight bold :height 1.2))))
     (custom-group-tag-1 ((t (:bold t :family "Sans Serif" :foreground "pink" :weight bold :height 1.2))))
     (custom-invalid ((t (:background "red1" :foreground "yellow1"))))
     (custom-link ((t (:bold t :weight bold :underline t :foreground "#8ac6f2"))))
     (custom-modified ((t (:background "blue1" :foreground "white"))))
     (custom-rogue ((t (:background "black" :foreground "pink"))))
     (custom-saved ((t (:underline t))))
     (custom-set ((t (:background "white" :foreground "blue1"))))
     (custom-state ((t (:foreground "lime green"))))
     (custom-themed ((t (:background "blue1" :foreground "white"))))
     (custom-variable-button ((t (:bold t :underline t :weight bold))))
     (custom-variable-tag ((t (:bold t :foreground "light blue" :weight bold))))
     (custom-visibility ((t (:bold t :weight bold :underline t :foreground "#8ac6f2" :height 0.8))))
     (dired-directory ((t (:foreground "#cae682"))))
     (dired-flagged ((t (:bold t :weight bold :foreground "Pink"))))
     (dired-header ((t (:foreground "#cae682"))))
     (dired-ignored ((t (:foreground "grey70"))))
     (dired-mark ((t (:foreground "#e5786d"))))
     (dired-marked ((t (:bold t :weight bold :foreground "Pink"))))
     (dired-perm-write ((t (:italic t :foreground "#99968b" :slant italic))))
     (dired-symlink ((t (:foreground "#8ac6f2"))))
     (dired-warning ((t (:bold t :weight bold :foreground "Pink"))))
     (eldoc-highlight-function-argument ((t (:bold t :weight bold))))
     (escape-glyph ((t (:foreground "cyan"))))
     (ffap ((t (:background "darkolivegreen"))))
     (file-name-shadow ((t (:foreground "grey70"))))
     (fixed-pitch ((t (:family "Monospace"))))
     (flyspell-duplicate ((t (:bold t :foreground "Gold3" :underline t :weight bold))))
     (flyspell-incorrect ((t (:bold t :foreground "OrangeRed" :underline t :weight bold))))
     (font-lock-builtin-face ((t (:foreground "#8ac6f2"))))
     (font-lock-comment-delimiter-face ((t (:italic t :slant italic :foreground "#99968b"))))
     (font-lock-comment-face ((t (:italic t :foreground "#99968b" :slant italic))))
     (font-lock-constant-face ((t (:foreground "#e5786d"))))
     (font-lock-doc-face ((t (:italic t :foreground "#99968b" :slant italic))))
     (font-lock-function-name-face ((t (:foreground "#cae682"))))
     (font-lock-keyword-face ((t (:foreground "#8ac6f2"))))
     (font-lock-negation-char-face ((t (:foreground "#e7f6da"))))
     (font-lock-preprocessor-face ((t (:foreground "#e5786d"))))
     (font-lock-regexp-grouping-backslash ((t (:bold t :weight bold))))
     (font-lock-regexp-grouping-construct ((t (:bold t :weight bold))))
     (font-lock-string-face ((t (:italic t :foreground "#95e454" :slant italic))))
     (font-lock-type-face ((t (:foreground "#cae682"))))
     (font-lock-variable-name-face ((t (:foreground "#cae682"))))
     (font-lock-warning-face ((t (:bold t :foreground "Pink" :weight bold))))
     (fringe ((t (:background "grey10"))))
     (header-line ((t (:box (:line-width -1 :style released-button) :background "grey20" :foreground "grey90" :box nil))))
     (help-argument-name ((t (:italic t :slant italic))))
     (highlight ((t (:background "darkolivegreen"))))
     (isearch ((t (:background "palevioletred2" :foreground "brown4"))))
     (isearch-fail ((t (:background "red4"))))
     (iswitchb-current-match ((t (:foreground "#cae682"))))
     (iswitchb-invalid-regexp ((t (:bold t :weight bold :foreground "Pink"))))
     (iswitchb-single-match ((t (:italic t :slant italic :foreground "#99968b"))))
     (iswitchb-virtual-matches ((t (:foreground "#8ac6f2"))))
     (italic ((t (:italic t :slant italic))))
     (lazy-highlight ((t (:background "yellow" :foreground "black"))))
     (link ((t (:bold t :foreground "#8ac6f2" :underline t :weight bold))))
     (link-visited ((t (:bold t :weight bold :underline t :foreground "violet"))))
     (match ((t (:background "RoyalBlue3"))))
     (menu ((t (nil))))
     (message-cited-text ((t (:foreground "LightPink1"))))
     (message-header-cc ((t (:bold t :foreground "chartreuse1" :weight bold))))
     (message-header-name ((t (:foreground "green"))))
     (message-header-newsgroups ((t (:italic t :bold t :foreground "blue4" :slant italic :weight bold))))
     (message-header-other ((t (:foreground "VioletRed1"))))
     (message-header-subject ((t (:bold t :foreground "white" :weight bold))))
     (message-header-to ((t (:bold t :foreground "white" :weight bold))))
     (message-header-xheader ((t (:foreground "white"))))
     (message-mml ((t (:foreground "MediumSpringGreen"))))
     (message-separator ((t (:foreground "LightSkyBlue1"))))
     (minibuffer-prompt ((t (:foreground "cyan"))))
     (mode-line ((t (:background "grey75" :foreground "black" :box (:line-width -1 :style released-button)))))
     (mode-line-buffer-id ((t (:bold t :weight bold))))
     (mode-line-emphasis ((t (:bold t :weight bold))))
     (mode-line-highlight ((t (:box (:line-width 2 :color "grey40" :style released-button)))))
     (mode-line-inactive ((t (:background "grey30" :foreground "grey80" :box (:line-width -1 :color "grey40" :style nil) :weight light))))
     (mouse ((t (nil))))
     (next-error ((t (:foreground "#f6f3e8" :background "#444444"))))
     (nobreak-space ((t (:foreground "cyan" :underline t))))
     (query-replace ((t (:foreground "brown4" :background "palevioletred2"))))
     (rcirc-bright-nick ((t (:foreground "Aquamarine"))))
     (rcirc-dim-nick ((t (:family "DejaVu Sans Mono" :foundry "unknown" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#f6f3e8" :background "#242424" :stipple nil :height 120))))
     (rcirc-keyword ((t (:background "darkolivegreen"))))
     (rcirc-my-nick ((t (:background "yellow" :foreground "blue"))))
     (rcirc-nick-in-message ((t (:foreground "Cyan1"))))
     (rcirc-nick-in-message-full-line ((t (:bold t :weight bold))))
     (rcirc-other-nick ((t (:foreground "LightGoldenrod"))))
     (rcirc-prompt ((t (:foreground "cyan1"))))
     (rcirc-server ((t (:foreground "chocolate1"))))
     (rcirc-server-prefix ((t (:foreground "chocolate1"))))
     (rcirc-timestamp ((t (:family "DejaVu Sans Mono" :foundry "unknown" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#f6f3e8" :background "#242424" :stipple nil :height 120))))
     (rcirc-track-keyword ((t (:bold t :weight bold))))
     (rcirc-track-nick ((t (nil))))
     (rcirc-url ((t (:bold t :weight bold))))
     (region ((t (:background "#444444" :foreground "#f6f3e8"))))
     (rst-level-1-face ((t (:background "grey85"))))
     (rst-level-2-face ((t (:background "grey78"))))
     (rst-level-3-face ((t (:background "grey71"))))
     (rst-level-4-face ((t (:background "grey64"))))
     (rst-level-5-face ((t (:background "grey57"))))
     (rst-level-6-face ((t (:background "grey50"))))
     (scroll-bar ((t (nil))))
     (secondary-selection ((t (:background "SkyBlue4"))))
     (shadow ((t (:foreground "grey70"))))
     (show-paren-match ((t (:background "steelblue3"))))
     (show-paren-mismatch ((t (:background "purple" :foreground "white"))))
     (swbuff-current-buffer-face ((t (:bold t :foreground "red" :underline t :weight bold))))
     (swbuff-default-face ((t (nil))))
     (swbuff-separator-face ((t (:foreground "blue"))))
     (tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tooltip ((t (:family "Sans Serif" :background "lightyellow" :foreground "black"))))
     (trailing-whitespace ((t (:background "red1"))))
     (twitter-header-face ((t (:background "sienna" :foreground "white"))))
     (twitter-status-overlong-face ((t (:foreground "red"))))
     (twitter-time-stamp-face ((t (:italic t :foreground "white" :background "sienna" :slant italic))))
     (twitter-user-name-face ((t (:bold t :background "firebrick" :foreground "white" :weight bold))))
     (underline ((t (:underline t))))
     (variable-pitch ((t (:family "Sans Serif"))))
     (vertical-border ((t (nil))))
     (widget-button ((t (:bold t :weight bold))))
     (widget-button-pressed ((t (:foreground "red1"))))
     (widget-documentation ((t (:foreground "lime green"))))
     (widget-field ((t (:background "dim gray"))))
     (widget-inactive ((t (:foreground "grey70"))))
     (widget-single-line-field ((t (:background "dim gray"))))
     (woman-addition ((t (:foreground "orange"))))
     (woman-bold ((t (:bold t :foreground "green2" :weight bold))))
     (woman-italic ((t (:italic t :underline t :slant italic))))
     (woman-unknown ((t (:foreground "cyan1")))))))

(provide 'color-theme-wombat)

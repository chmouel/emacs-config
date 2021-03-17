(use-package emacs
  :ensure nil
  :defer t
  :bind
  (:map prog-mode-map
		("C-'" . toggle-quotes)
		("C-<return>" . recompile)
		("RET" . newline-and-indent))
  :hook
  (prog-mode . subword-mode)
  (prog-mode . highlight-numbers-mode))

(use-package highlight-indentation)

(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

(use-package toggle-quotes)

(use-package multi-compile
  :demand t
  :custom
  (multi-compile-history-file
   (locate-user-emacs-file "auto-save-list/multi-compile.cache"))
  :bind
  (:map prog-mode-map
        ("C-<return>" . multi-compile-run)))
  
(use-package highlight-parentheses
  :hook (prog-mode . highlight-parentheses-mode))

(use-package whitespace-cleanup-mode
  :hook (prog-mode . whitespace-cleanup-mode))

;; My github-browse-remote that worksie for me
;; Probably should handle master/main thing
(use-package github-browse-remote
  :if (and (boundp 'my-github-browse-remote-location)
		   (file-directory-p my-github-browse-remote-location))
  :load-path my-github-browse-remote-location
  :commands (github-browse-remote)
  :bind
  ("<f6>" . github-browse-remote))

;; Eldoc-Mode
(use-package smartparens
  :diminish smartparens-mode
  :bind
  (:map lisp-interaction-mode-map
		("C-S-<right>" . sp-forward-sexp)
		("C-S-<left>" . sp-backward-sexp))
  (:map emacs-lisp-mode-map
		("C-S-<right>" . sp-forward-sexp)
		("C-S-<left>" . sp-backward-sexp))
  :hook
  (prog-mode . smartparens-mode))

;; Dockerfile
(use-package dockerfile-mode)

(use-package yasnippet
  :diminish yas-minor-mode
  :hook
  (after-init . yas-global-mode)
  :custom
  (yas-prompt-functions '(yas-completing-prompt))
  (yas-key-syntaxes '("w_" "w_." "^ "))
  (yas-installed-snippets-dir "~/elisp/yasnippet-snippets")
  (yas-expand-only-for-last-commands nil)
  :config
  (add-hook 'hippie-expand-try-functions-list 'yas-hippie-try-expand))

(provide 'init-programming)

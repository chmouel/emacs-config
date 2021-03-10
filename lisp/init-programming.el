(use-package emacs
  :bind
  (:map prog-mode-map
		("C-'" . toggle-quotes)
		("C-<return>" . my-recompile)
		("RET" . newline-and-indent))
  :hook
  (prog-mode . subword-mode)
  (prog-mode . rainbow-delimiters-mode)
  (prog-mode . highlight-numbers-mode) )

(use-package highlight-indentation)
(use-package highlight-numbers)
(use-package toggle-quotes)
(use-package multi-compile)
(use-package rainbow-delimiters)

;; Whitespace cleanup
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

(provide 'init-programming)

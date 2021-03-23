(use-package emacs
  :ensure nil
  :defer t
  :bind
  (:map prog-mode-map
        ("M-RET" . (lambda () (interactive) (move-end-of-line 1) (newline-and-indent)))
		("RET" . newline-and-indent))
  :hook
  (prog-mode . subword-mode)
  (prog-mode . highlight-numbers-mode))

(use-package highlight-indentation)

(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

(use-package toggle-quotes
  :bind
  (:map prog-mode-map
		("C-'" . toggle-quotes)))

(use-package multi-compile
  :demand t
  :custom
  (multi-compile-history-file
   (locate-user-emacs-file "auto-save-list/multi-compile.cache"))
  :bind
  (:map prog-mode-map
        ("C-<return>" . recompile)
        ("C-<return>" . multi-compile-run)))
  
(use-package highlight-parentheses
  :hook (prog-mode . highlight-parentheses-mode))

(use-package whitespace-cleanup-mode
  :hook (prog-mode . whitespace-cleanup-mode))

;; https://github.com/chmouel/chmouzies/blob/master/emacs/github-browse-remote.el
;; 
;; My github-browse-remote fork that worksie for me when we have `upstream`
;; branch instead of origin.
;; It uses this binary
;; https://github.com/chmouel/chmouzies/blob/master/git/git-browse
;;
;; Probably can be an advice.
(use-package github-browse-remote
  :if (and my-github-browse-remote-location
           (file-directory-p my-github-browse-remote-location))
  :load-path my-github-browse-remote-location
  :commands (github-browse-remote)
  :bind
  ("<f6>" . github-browse-remote))

;; Eldoc-Mode
(use-package smartparens
  :bind
  (([remap forward-sexp] . sp-forward-sexp)
   ([remap backward-sexp] . sp-backward-sexp))
  :custom-face
  (sp-show-pair-match-face ((t (:background "blue violet" :foreground "black"))))
  :diminish smartparens-mode
  :hook
  (prog-mode . show-smartparens-mode)
  (prog-mode . smartparens-mode))

;; Dockerfile
(use-package dockerfile-mode)

(provide 'init-programming)

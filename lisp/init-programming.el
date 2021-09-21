(use-package emacs
  :ensure nil
  :defer t
  ;; :hook
  ;; (before-save . before-save-clean-whitespace
  :hook
  (before-save . (lambda ()
                   (interactive)
                   (when (or (derived-mode-p 'markdown-mode)
                             (derived-mode-p 'yaml-mode))
                     (delete-trailing-whitespace))))
  :config
  (defun my-recompile (args)
    (interactive "P")
    (cond
     ((get-buffer "*Go Test*")
      (progn
        (pop-to-buffer "*Go Test*")
        (recompile)))
     ((get-buffer "*compilation*")
      (progn
        (pop-to-buffer "*compilation*")
        (recompile)))
     ((call-interactively 'compile))))
  :bind
  (:map prog-mode-map
        ("<backtab>" . yas-insert-snippet)
        ("C-M-<return>" . compile)
        ("C-<return>" . my-recompile)
        ("RET" . newline-and-indent)))

(use-package highlight-indentation)

(use-package treemacs
  :bind
  ("<f10>" . treemacs)
  :custom
  (treemacs-position 'right))
(use-package treemacs-all-the-icons)

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
   (locate-user-emacs-file "auto-save-list/multi-compile.cache")))

(use-package highlight-parentheses
  :hook (prog-mode . highlight-parentheses-mode))

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

(use-package json-mode
  :config
  (setq jsons-path-printer 'jsons-print-path-jq))

;; Dockerfile
(use-package dockerfile-mode)

;; Lua
(use-package lua-mode)

;; Format buffers!
(use-package format-all)

(provide 'init-programming)

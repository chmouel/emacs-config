(use-package emacs
  :ensure nil
  :defer t
  :config
  (add-hook 'before-save-hook
            (lambda ()
              (interactive)
              (when (or (derived-mode-p 'markdown-mode)
                        (derived-mode-p 'yaml-mode))
                (delete-trailing-whitespace))))
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

(use-package ansi-color
  :config
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  :hook (compilation-filter . my-colorize-compilation-buffer))

(use-package highlight-indentation)

(use-package treemacs
  :custom
  (treemacs-position 'right)
  :bind
  ("<f10>" . treemacs))
(use-package treemacs-all-the-icons)

(use-package tree-sitter
  :init
  (global-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs :after tree-sitter)

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
  :hook
  (json-mode . lsp)
  (json-mode . hs-minor-mode)
  :bind
  (:map json-mode-map
        ("C-M-<right>" . hs-show-block)
        ("C-M-<left>" . hs-hide-block))
  :config
  (setcdr (assoc 'js-mode hs-special-modes-alist) '("[{[]" "[}\\]]" "/[*/]" nil))
  (setq jsons-path-printer 'jsons-print-path-jq))

;; Dockerfile
(use-package dockerfile-mode)

;; Lua
(use-package lua-mode)

;; Format buffers!
(use-package format-all
  :commands (format-all-mode format-all-ensure-formatter))

(use-package restclient
  :commands (restclient-mode)
  :mode ("\\.rest\\'" . restclient-mode)
  :config
  (add-to-list 'restclient-content-type-modes '("application/json" . json-mode)))

(provide 'init-programming)

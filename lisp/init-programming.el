(use-package highlight-indentation)
(use-package highlight-numbers)
(use-package toggle-quotes)
(use-package multi-compile)
(use-package rainbow-delimiters)

;; Whitespace cleanup
(use-package whitespace-cleanup-mode
  :hook (after-init . global-whitespace-cleanup-mode))

;; Flycheck
(use-package flycheck-indicator
  :defer t
  :hook (flycheck-mode . flycheck-indicator-mode)
  :custom
  (flycheck-indicator-status-icons
   '((no-checker . "")
     (not-checked . "")
     (running . "*")
     (finished "")
     (interrupted "!")
     (suspicious "!"))))

(use-package flycheck
  :defer t
  :hook
  (prog-mode . flycheck-mode)
  :custom
  ((flycheck-mode-line-prefix "")
   (flycheck-disabled-checkers
    '(go-unconvert
      html-tidy xml-xmlint
      emacs-lisp emacs-lisp-checkdoc))
   (flycheck-display-errors-delay 0.2)
   (flycheck-highlighting-mode 'lines))
  :config
  (global-flycheck-mode t))

(use-package flycheck-yamllint
  :after flycheck
  :hook (flycheck-mode  . flycheck-yamllint-setup)
  :ensure t
  :defer t)

;; My github-browse-remote that worksie for me
;; Probably should handle master/main thing
(use-package github-browse-remote
  :if (file-directory-p "~/GIT/chmouzies/emacs")
  :load-path "~/GIT/chmouzies/emacs"
  :commands (github-browse-remote)
  :bind
  ("<f6>" . github-browse-remote))

;; Yasnippet
(use-package yasnippet
  :defer t
  :custom
  ((auto-insert-query nil)
   (yas-prompt-functions '(yas/dropdown-prompt)))
  :config
  (add-hook 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
  (setq yas-key-syntaxes '("w_" "w_." "^ "))
  (setq yas-installed-snippets-dir "~/elisp/yasnippet-snippets")
  (setq yas-expand-only-for-last-commands nil)
  (bind-key "\t" 'hippie-expand yas-minor-mode-map)
  
  ;; Yassnippet
  (defun yas--expand-by-uuid (mode uuid)
    "Exapnd snippet template in MODE by its UUID"
    (yas-expand-snippet
     (yas--template-content
      (yas--get-template-by-uuid mode uuid))))

  (defun yas--magit-email-or-default ()
    "Get email from GIT or use default"
    (require 'magit-process)
    (if (magit-toplevel ".")
		(magit-get "user.email")
      user-mail-address))
  (yas-global-mode 1)
  (require 'autoinsert)
  (auto-insert-mode)
  (setq auto-insert-query nil)
  (setq auto-insert-alist nil)
  (define-auto-insert "\.py"
    '(lambda () (yas--expand-by-uuid 'python-mode "header"))))

(use-package yasnippet-snippets :after yasnippet)

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

(use-package yasnippet
  :diminish yas-minor-mode
  :hook
  (after-init . yas-global-mode)
  :custom
  (yas-key-syntaxes '("w_" "w_." "^ "))
  (yas-installed-snippets-dir "~/elisp/yasnippet-snippets")
  (yas-expand-only-for-last-commands nil)
  :config
  (add-hook 'hippie-expand-try-functions-list 'yas-hippie-try-expand))

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

(provide 'init-programming)
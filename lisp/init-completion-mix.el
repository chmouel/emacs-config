(use-package counsel)

(use-package ivy
  :ensure t
  :demand
  :bind
  ("C-\\" . ivy-switch-buffer)
  (:map ivy-minibuffer-map
        ("C-s" . ivy-next-line)
        ("C-M-j" . ivy-partial)
        ("C-j" . ivy-immediate-done)
        ("C-\\" . ivy-next-line))
  :custom
  (ivy-use-virtual-buffers t))

(use-package ivy-prescient
  :commands ivy-prescient-re-builder
  :init
  (setq ivy-prescient-retain-classic-highlighting nil
        ivy-re-builders-alist
        '((t . ivy-prescient-re-builder))
        ivy-prescient-sort-commands
        '(:not swiper swiper-isearch ivy-switch-buffer
               lsp-ivy-workspace-symbol ivy-resume ivy--restore-session
               counsel-grep counsel-git-grep counsel-rg counsel-ag
               counsel-ack counsel-fzf counsel-pt counsel-imenu
               counsel-org-capture counsel-load-theme counsel-yank-pop
               counsel-recentf counsel-buffer-or-recentf
               centaur-load-theme))
  (ivy-prescient-mode 1))

(use-package ivy-rich
  :after counsel
  :hook ((ivy-rich-mode . (lambda ()
                            (setq ivy-virtual-abbreviate
                                  (or (and ivy-rich-mode 'abbreviate) 'name)))))
  :init
  ;; For better performance
  (ivy-rich-mode t)
  (setq ivy-rich-parse-remote-buffer nil))

(use-package orderless
  :demand t
  :custom
  (completion-styles '(orderless))
  (orderless-matching-styles
   '(orderless-flex
     orderless-strict-leading-initialism
     orderless-regexp
     orderless-prefixes
     orderless-literal))
  (orderless-component-separator " ")
  (completion-category-defaults nil))

(use-package vertico
  ;; :custom-face
  ;; (vertico-current ((t (:foreground "thistle"))))
  :custom
  (vertico-count-format '())
  :config
  (define-key vertico-map (kbd "C-j") #'vertico-exit-input)
  (define-key vertico-map (kbd "C-s") #'vertico-next)
  :init
  (vertico-mode))


(provide 'init-completion-mix)

(use-package evil
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-define-key 'normal 'global (kbd "C-k") (lambda () (interactive)(previous-logical-line 10)))
  (evil-define-key 'normal 'global (kbd "C-j") (lambda () (interactive)(next-logical-line 10)))
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "SPC") nil)
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "TAB") nil))
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'view-mode 'emacs)
  ;; I prefer Emacs way after pressing ":" in evil-mode
  (define-key evil-ex-completion-map (kbd "C-a") 'move-beginning-of-line)
  (define-key evil-ex-completion-map (kbd "C-b") 'backward-char)
  (define-key evil-ex-completion-map (kbd "M-p") 'previous-complete-history-element)
  (define-key evil-ex-completion-map (kbd "M-n") 'next-complete-history-element)
  (define-key evil-normal-state-map "go" 'avy-goto-char)
  (define-key evil-normal-state-map (kbd "q") nil)
  :custom
  (evil-undo-system 'undo-redo)
  (evil-want-integration nil)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  :bind
  ("<f9>" . evil-mode)
  :commands (evil-local-mode))

(use-package evil-commentary
  :after evil
  :ensure t
  :bind (:map evil-normal-state-map
              ("gc" . evil-commentary)))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-matchit
  :config
  (define-key evil-normal-state-map (kbd "%") 'evilmi-jump-items)
  (global-evil-matchit-mode t))

(provide 'init-evil)

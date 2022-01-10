(use-package evil
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-define-key 'normal 'global (kbd "C-k") (lambda () (interactive)(scroll-lock-previous-line 5)))
  (evil-define-key 'normal 'global (kbd "C-j") (lambda () (interactive)(scroll-lock-next-line 5)))
  (evil-define-key 'normal 'global (kbd "<tab>") 'next-buffer)
  (evil-define-key 'normal 'global (kbd "<S-tab>") 'previous-buffer)
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'view-mode 'emacs)
  :custom
  (evil-undo-system 'undo-redo)
  (evil-want-integration nil)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  :commands (evil-local-mode))

(use-package scroll-lock
  :ensure nil
  :commands
  (scroll-lock-previous-line scroll-lock-next-line))

(use-package evil-commentary
  :after evil
  :ensure t
  :bind (:map evil-normal-state-map
              ("gc" . evil-commentary)))

(provide 'init-evil)

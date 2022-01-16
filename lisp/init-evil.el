(use-package evil
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-define-key 'normal 'global (kbd "C-k") (lambda () (interactive)(previous-logical-line 5)))
  (evil-define-key 'normal 'global (kbd "C-j") (lambda () (interactive)(next-logical-line 5)))
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "SPC") nil)
    (define-key evil-motion-state-map (kbd "RET") nil)
    (define-key evil-motion-state-map (kbd "TAB") nil))
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'view-mode 'emacs)
  :custom
  (evil-undo-system 'undo-redo)
  (evil-want-integration nil)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  :bind
  ("C-~" . evil-mode)
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

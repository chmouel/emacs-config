(use-package evil
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  :custom
  (evil-want-integration nil)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  :commands (evil-local-mode))

(use-package evil-commentary
  :after evil
  :ensure t
  :bind (:map evil-normal-state-map
              ("gc" . evil-commentary)))

(provide 'init-evil)

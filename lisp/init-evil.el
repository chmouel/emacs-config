(use-package evil
  :hook
  (after-init . evil-mode)
  (evil-normal-state-entry . (lambda ()(interactive)(setq-local display-line-numbers 'relative)))
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-define-key 'normal 'global (kbd "TAB") (lambda () (interactive)(tab-next)))
  (evil-define-key 'normal 'global (kbd "backtab") (lambda () (interactive)(tab-previous)))
  (evil-define-key 'normal 'global (kbd "C-f") (lambda () (interactive)(project-find-file)))
  (evil-define-key 'normal 'global (kbd "C-0") (lambda () (interactive)(call-interactively 'avy-goto-word-0)))
  (evil-define-key 'normal 'global (kbd "C-.") (lambda () (interactive)(call-interactively 'er/expand-region)))
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
  :commands (evil-local-mode))

(use-package evil-anzu
  :after evil)

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
  :after evil
  :config
  (global-evil-matchit-mode t))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround mode t))

(provide 'init-evil)

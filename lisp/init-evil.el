(use-package evil
  :hook
  (after-init . evil-mode)
  (evil-normal-state-entry . (lambda ()(interactive)
                               (setq-local display-line-numbers 'relative)))
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-define-key 'normal 'global (kbd "TAB") 'tab-next)
  (evil-define-key 'normal 'global (kbd "RET") 'next-line)
  (evil-define-key 'normal 'global (kbd "<backtab>") 'tab-previous)
  (evil-define-key 'normal 'global (kbd "C-f") 'project-find-file)
  (evil-define-key 'normal 'global (kbd "C-.") 'er/expand-region)
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
  (define-key evil-normal-state-map (kbd "M-.") 'evil-goto-definition)
  (define-key evil-normal-state-map (kbd "q") nil)
  (add-hook 'evil-insert-state-exit-hook
            (lambda ()
              (call-interactively #'save-buffer)))
  :custom
  (evil-vsplit-window-right t)
  (evil-undo-system 'nil)
  (evil-want-integration nil)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  :bind
  :commands (evil-local-mode))

(use-package undo-fu
  :custom
  (evil-undo-system 'undo-fu))

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

(use-package evil-leader
  :hook (evil-local-mode . evil-leader-mode) ;
  :after evil
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
   "w" (lambda ()
         (interactive)
         (call-interactively #'save-buffer))))

(use-package evil-matchit
  :bind
  ("C-=" . 'evilmi-jump-items-native)
  :hook (evil-local-mode . evil-matchit-mode)) ;
  

(use-package evil-surround
  :after evil)

(provide 'init-evil)

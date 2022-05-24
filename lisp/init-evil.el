(use-package evil
  :hook
  (after-init . evil-mode)
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (evil-define-key 'normal 'global (kbd "TAB") 'tab-next)
  (evil-define-key 'normal 'global (kbd "RET") 'next-line)
  (evil-define-key 'normal 'global (kbd "<backtab>") 'tab-previous)
  (evil-define-key 'normal 'global (kbd "C-e") 'evil-end-of-line)
  (evil-define-key 'normal 'global (kbd "C-p") 'evil-previous-line)
  (evil-define-key 'normal 'global (kbd "C-n") 'evil-next-line)
  (evil-define-key 'normal 'global (kbd "M-.") 'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "C-.") 'er/expand-region)
  (evil-define-key 'insert 'global (kbd "C-y") 'evil-paste-after)
  (evil-define-key 'insert 'global (kbd "C-e") 'evil-end-of-line)
  (evil-define-key 'insert 'global (kbd "C-a") 'crux-move-beginning-of-line)
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
  (define-key evil-normal-state-map (kbd "q") nil)
  :custom
  (evil-default-state 'emacs)
  (evil-vsplit-window-right t)
  (evil-undo-system 'nil)
  (evil-want-integration nil)
  (evil-want-Y-yank-to-eol t)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-Y-yank-to-eol)
  (evil-want-fine-undo 't)
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

(use-package evil-leader
  :hook (evil-local-mode . evil-leader-mode) ;
  :after evil
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "C-f" 'project-find-file)
  (evil-leader/set-key "k" (lambda ()(interactive)(kill-buffer)))
  (evil-leader/set-key "K" (lambda ()(interactive)(tab-close)))
  (evil-leader/set-key "`" 'vterm-toggle)
  (evil-leader/set-key "2" (lambda ()(interactive)(tab-bar-select-tab 2)))
  (evil-leader/set-key "3" (lambda ()(interactive)(tab-bar-select-tab 3)))
  (evil-leader/set-key "4" (lambda ()(interactive)(tab-bar-select-tab 4)))
  (evil-leader/set-key "5" (lambda ()(interactive)(tab-bar-select-tab 5)))
  (evil-leader/set-key "6" (lambda ()(interactive)(tab-bar-select-tab 6)))
  (evil-leader/set-key "7" (lambda ()(interactive)(tab-bar-select-tab 7)))
  (evil-leader/set-key "8" (lambda ()(interactive)(tab-bar-select-tab 8)))
  (evil-leader/set-key "9" (lambda ()(interactive)(tab-bar-select-tab 9)))
  (evil-leader/set-key
    "w" (lambda ()
          (interactive)
          (call-interactively #'save-buffer))))

(use-package evil-numbers
  :bind
  ("C-c +" . evil-numbers/inc-at-pt)
  ("C-c -" . evil-numbers/dec-at-pt))

(use-package evil-matchit
  :bind
  ("C-=" . 'evilmi-jump-items-native)
  :hook (evil-local-mode . evil-matchit-mode)) ;

(use-package evil-surround
  :hook (evil-local-mode . evil-surround-mode) ;
  :after evil)

(provide 'init-evil)

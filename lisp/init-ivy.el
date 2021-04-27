;; IVY Disabled
(use-package ivy
  :ensure t
  :demand
  :hook (after-init . ivy-mode)
  :bind
  (:map ivy-minibuffer-map
        ("C-s" . ivy-next-line)
        ("C-M-j" . ivy-partial)
        ("C-j" . ivy-immediate-done)
        ("C-\\" . ivy-next-line))
  :custom
  (consult-project-root-function #'projectile-project-root)
  (counsel-switch-buffer-preview-virtual-buffers nil)
  (ivy-extra-directories '("./"))
  (ivy-count-format "")
  (ivy-use-virtual-buffers t)
  :config
  (setq ivy-height 10
        ivy-wrap nil
        ivy-re-builders-alist '((t . orderless-ivy-re-builder))
        ivy-count-format ""
        ivy-use-virtual-buffers t))

(use-package all-the-icons-ivy
  :after (all-the-icons ivy)
  :custom
  (all-the-icons-spacer " ")
  (all-the-icons-ivy-file-commands
   '(counsel-dired-jump
     counsel-find-file
     counsel-file-jump
     counsel-find-library
     counsel-git
     counsel-projectile-find-dir
     counsel-projectile-find-file
     counsel-recentf))
  :config (all-the-icons-ivy-setup))

(use-package ivy-prescient
  :disabled
  :ensure t
  :config
  (ivy-prescient-mode 1))

(provide 'init-ivy)

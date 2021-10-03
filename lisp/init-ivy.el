;; IVY Disabled
(use-package ivy
  :ensure t
  :demand
  :hook (after-init . ivy-mode)
  :bind
  ("C-\\" . ivy-switch-buffer)
  (:map ivy-minibuffer-map
        ("C-s" . ivy-next-line)
        ("C-M-j" . ivy-partial)
        ("C-j" . ivy-immediate-done)
        ("C-\\" . ivy-next-line))
  :custom
  (consult-project-root-function #'project-root)
  (counsel-switch-buffer-preview-virtual-buffers nil)
  (ivy-extra-directories '("./"))
  (ivy-count-format "")
  (ivy-use-virtual-buffers t)
  (ivy-height 12)
  (ivy-on-del-error-function #'ignore)
  (ivy-magic-tilde nil)
  (ivy-fixed-height-minibuffer t)
  (ivy-wrap nil)
  (ivy-count-format "")
  (ivy-use-virtual-buffers t))

(use-package counsel)

(use-package ivy-rich
  :hook ((ivy-rich-mode . (lambda ()
                            "Use abbreviate in `ivy-rich-mode'."
                            (setq ivy-virtual-abbreviate
                                  (or (and ivy-rich-mode 'abbreviate) 'name)))))
  :init
  ;; For better performance
  (ivy-rich-mode t)
  (setq ivy-rich-parse-remote-buffer nil))

;; Additional key bindings for Ivy
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
     counsel-recentf))
  :config (all-the-icons-ivy-setup))

(use-package ivy-prescient
  :commands ivy-prescient-re-builder
  :custom-face
  (ivy-minibuffer-match-face-1 ((t (:inherit font-lock-doc-face :foreground nil))))
  :init
  (defun ivy-prescient-non-fuzzy (str)
    "Generate an Ivy-formatted non-fuzzy regexp list for the given STR.
This is for use in `ivy-re-builders-alist'."
    (let ((prescient-filter-method '(literal regexp)))
      (ivy-prescient-re-builder str)))

  (setq ivy-prescient-retain-classic-highlighting t
        ivy-re-builders-alist
        '((counsel-unicode-char . ivy-prescient-non-fuzzy)
          (t . ivy-prescient-re-builder))
        ivy-prescient-sort-commands
        '(:not swiper swiper-isearch ivy-switch-buffer
               lsp-ivy-workspace-symbol ivy-resume ivy--restore-session
               counsel-grep counsel-git-grep counsel-rg counsel-ag
               counsel-ack counsel-fzf counsel-pt counsel-imenu
               counsel-org-capture counsel-load-theme counsel-yank-pop
               counsel-recentf counsel-buffer-or-recentf
               centaur-load-theme))
  (ivy-prescient-mode 1))

(use-package ivy-posframe
  :custom-face
  (ivy-posframe-border ((t (:background ,(face-foreground 'font-lock-comment-face)))))
  :hook (ivy-mode . ivy-posframe-mode)
  :init
  (setq ivy-posframe-display-functions-alist
        '((t . ivy-posframe-display-at-frame-center)))
  
  (setq ivy-posframe-border-width 3
        ivy-posframe-parameters
        `((background-color . ,(face-background 'tooltip))))

  :config
  (ivy-posframe-mode)
  (add-hook 'after-load-theme-hook
            (lambda ()
              (posframe-delete-all)
              (custom-set-faces
               `(ivy-posframe-border
                 ((t (:background ,(face-foreground 'font-lock-comment-face))))))
              (setf (alist-get 'background-color ivy-posframe-parameters)
                    (face-background 'tooltip)))))


(provide 'init-ivy)

;; Prettiness
(use-package marginalia
  :ensure t
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy
     marginalia-annotators-light))
  :init
  (marginalia-mode +1)
  :config
  ;; When using Selectrum, ensure that Selectrum is refreshed when cycling annotations.
  (advice-add
   #'marginalia-cycle :after
   (lambda ()
     (when
         (bound-and-true-p
          selectrum-mode)
       (selectrum-exhibit)))))

(use-package prescient
  :ensure t
  :config
  (prescient-persist-mode t)
  :custom
  (prescient-sort-length-enable nil)
  (prescient-filter-method '(literal regexp initialism fuzzy prefix)))

(use-package selectrum-prescient
  :ensure t
  :after selectrum
  :init
  (selectrum-prescient-mode +1))

(use-package selectrum
  :ensure t
  :init
  (selectrum-mode +1)

  :custom-face
  (selectrum-current-candidate ((t
                                 (:inherit highlight
                                           :underline nil))))
  (selectrum-secondary-highlight ((t
                                   (:inherit ivy-highlight-face))))
  (selectrum-primary-highlight ((t
                                 (:inherit ivy-minibuffer-match-face-2 ))))
  :bind
  (:map selectrum-minibuffer-map
        ("C-s" . selectrum-next-candidate)
        ("C-RET" . selectrum-submit-exact-input)
        ("C-\\" . selectrum-next-candidate))
  :custom
  (selectrum-count-style 'nil)
  (selectrum-max-window-height 25)
  (selectrum-extend-current-candidate-highlight t))

(use-package consult
  :custom
  (consult-async-default-split "")
  (consult-find-command '("fdfind" "--color=never" "--full-path"))
  (consult-project-root-function #'projectile-project-root)
  :ensure t
  :bind (("M-s i"   . consult-imenu)
         ("M-s g"   . consult-grep)
         ("M-g o"   . consult-outline)
         ("M-g g"   . consult-goto-line)
         ("C-\\"    . consult-buffer)
         ("C-x b"   . consult-buffer)
         ("M-s y"   . consult-yank)
         ("C-x 4 b" . consult-buffer-other-window)
         ("M-g m"   . consult-mark)
         ("M-s m" . consult-multi-occur)
         ("C-c U" . consult-ripgrep)
         ("C-x 5 b" . consult-buffer-other-frame)         
         ("C-x r b" . consult-bookmark)
         ("C-x C-r" . consult-recent-file)))

(use-package all-the-icons-ivy
  :disabled
  :ensure t
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

(use-package ivy
  :disabled
  :ensure t
  :bind
  (("C-\\" . (lambda() (interactive) (ivy-rich-mode +1) (ivy-switch-buffer)))
   ("C-x b" . (lambda() (interactive) (ivy-rich-mode +1) (ivy-switch-buffer)))
   :map ivy-minibuffer-map
   ("C-s" . ivy-next-line)
   ("C-M-j" . ivy-partial)
   ("C-j" . ivy-immediate-done)
   ("C-\\" . ivy-next-line))
  :custom
  (ivy-height 25)
  (counsel-switch-buffer-preview-virtual-buffers nil)
  (ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (ivy-extra-directories '("./"))
  (ivy-count-format "")
  (ivy-use-virtual-buffers t))

(use-package ivy-rich
  :disabled
  :ensure t
  :custom
  (ivy-rich-path-style 'abbrev)
  (ivy-rich-modify-columns
   'ivy-switch-buffer
   '((ivy-rich-switch-buffer-size (:align right))
     (ivy-rich-switch-buffer-major-mode (:width 20 :face font-lock-keyword-face)))))

(use-package ivy-prescient
  :disabled
  :ensure t
  :config
  (ivy-prescient-mode 1))

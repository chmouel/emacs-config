;; Prettiness
(use-package marginalia
  :ensure t
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy
     marginalia-annotators-light))
  :bind (:map minibuffer-local-completion-map
              ("C-i" . marginalia-cycle-annotators))
  :config
  ;; When using Selectrum, ensure that Selectrum is refreshed when cycling annotations.
  (advice-add
   #'marginalia-cycle :after
   (lambda ()
     (when
         (bound-and-true-p
          selectrum-mode)
       (selectrum-exhibit))))
  (marginalia-mode 1))

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
  :config
  (selectrum-prescient-mode +1))

(use-package selectrum
  :hook (after-init . selectrum-mode)
  :ensure t
  :custom-face
  (selectrum-current-candidate ((t
                                 (:inherit highlight
                                           :underline nil))))
  (selectrum-primary-highlight ((t
                                 (:foreground "DeepSkyBlue1"
                                              :weight bold))))
  :bind
  (:map selectrum-minibuffer-map
        ("C-s" . selectrum-next-candidate)
        ("C-\\" . selectrum-next-candidate))
  :custom
  (selectrum-count-style 'nil)
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
         ("C-c u"   . my-consult-projectile-rg)
         ("M-s y"   . consult-yank)
         ("C-x 4 b" . consult-buffer-other-window)
         ("M-g m"   . consult-mark)
         ("M-s m" . consult-multi-occur)
         ("C-x 5 b" . consult-buffer-other-frame)         
         ("C-x r b" . consult-bookmark)
         ("C-x C-r" . consult-recent-file))
  :config
  (defun my-consult-projectile-rg (&optional initial)
    (interactive "P")
    (if (and (eq projectile-require-project-root 'prompt)
             (not (projectile-project-p)))
        (projectile-switch-project)
      (let ((thingapt (if initial (thing-at-point 'symbol) nil))
            (ignored
             (mapconcat (lambda (i)
                          (concat "--glob !" (shell-quote-argument i)))
                        (append
                         (projectile--globally-ignored-file-suffixes-glob)
                         (projectile-ignored-files-rel)
                         (projectile-ignored-directories-rel))
                        " ")))
        (consult-ripgrep (projectile-project-root) thingapt)))))

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
  (prescient-save-file (locate-user-emacs-file "auto-save-list/prescient-cache.el"))
  (prescient-sort-length-enable nil)
  (prescient-filter-method '(literal-prefix regexp initialism)))

(use-package selectrum-prescient
  :disabled
  :ensure t
  :after selectrum
  :init
  (selectrum-prescient-mode +1))

(use-package selectrum
  :disabled
  :ensure t
  :init
  (selectrum-mode +1)
  :config
  ;; https://github.com/raxod502/selectrum/issues/172#issuecomment-758039766
  (defun my-filename-good-p (fn)
    (not (seq-contains-p completion-ignored-extensions (file-name-extension fn t))))

  (defun my-advice-selectrum-read-file-name (oldfun
					                         prompt &optional dir default-filename mustmatch initial predicate)
    "advice making `selectrum-read-file-name' honoring `completion-ignored-extensions'."
    (let* ((predicate-new (if predicate
			                  (lambda (fn) (and (funcall predicate fn)
					                            (my-filename-good-p fn)))
			                #'my-filename-good-p)))
      (funcall oldfun prompt dir default-filename mustmatch initial predicate-new)))
  (advice-add #'selectrum-read-file-name :around
	          #'my-advice-selectrum-read-file-name)

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
  (selectrum-max-window-height 15)
  (selectrum-extend-current-candidate-highlight t))

(use-package consult
  :disabled
  :config
  (defmacro my-consult-with-preview (binding &rest body)
    (global-set-key
     (kbd binding)
     `(lambda nil (interactive)(let ((consult-preview-key 'any)) ,@body))))
  (my-consult-with-preview "C-c U" (consult-ripgrep  (projectile-project-root) (thing-at-point 'symbol)))
  (my-consult-with-preview "M-g g" (consult-goto-line))
  (my-consult-with-preview "M-g M-g" (consult-goto-line))
  :custom
  (consult-preview-key 'nil)
  (consult-async-default-split "")
  (consult-project-root-function #'projectile-project-root)
  :ensure t
  :bind (("M-s i"   . consult-imenu)
         ("M-s g"   . consult-grep)
         ("M-g o"   . consult-outline)
         ("C-\\"    . consult-buffer)
         ("M-s y"   . consult-yank)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("M-g m"   . consult-mark)
         ("M-s m" . consult-multi-occur)
         ("C-x 5 b" . consult-buffer-other-frame)         
         ("C-x r b" . consult-bookmark)
         ("C-x C-r" . consult-recent-file)))

(use-package embark
  :disabled
  :ensure t
  :after selectrum
  :bind (:map minibuffer-local-map
              ("C-o" . embark-act)))              

;;;IVY Disabled
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
  :ensure t
  :init
  (ivy-mode +1)
  :bind
  (("C-\\" . (lambda() (interactive) (ivy-rich-mode +1) (ivy-switch-buffer)))
   ("C-x b" . (lambda() (interactive) (ivy-rich-mode +1) (ivy-switch-buffer)))
   :map ivy-minibuffer-map
   ("C-s" . ivy-next-line)
   ("C-M-j" . ivy-partial)
   ("C-j" . ivy-immediate-done)
   ("C-\\" . ivy-next-line))
  :custom
  (consult-project-root-function #'projectile-project-root)
  (counsel-switch-buffer-preview-virtual-buffers nil)
  (ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (ivy-extra-directories '("./"))
  (ivy-count-format "")
  (ivy-use-virtual-buffers t))

(use-package counsel :ensure t
  :bind
  (("M-x" . counsel-M-x)
   ("C-c U" . counsel-grep)
   ))

(use-package ivy-rich
  :init
  (ivy-rich-mode +1)
  :ensure t
  :custom
  (ivy-rich-path-style 'abbrev)
  (ivy-rich-modify-columns
   'ivy-switch-buffer
   '((ivy-rich-switch-buffer-size (:align right))
     (ivy-rich-switch-buffer-major-mode (:width 20 :face font-lock-keyword-face)))))

(use-package ivy-prescient
  :ensure t
  :config
  (ivy-prescient-mode 1))

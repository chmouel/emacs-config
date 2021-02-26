;; Prettiness
(use-package marginalia
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy
     marginalia-annotators-light))
  :init
  (marginalia-mode +1))

(use-package swivb
  :if (file-directory-p "~/GIT/projects/emacs-swivb")
  :commands (swivb)
  :load-path "~/GIT/projects/emacs-swivb" ; TODO: need to upload it in melpa
  :config
  (setq swivb-actions '((:name "*Gnus*" :function "gnus" :buffer "*Group*")))
  :bind
  ("C-\\" . swivb))

(use-package orderless
  :ensure t
  :custom
  (orderless-regexp-separator " +")
  (orderless-matching-styles
   '(orderless-strict-leading-initialism
     orderless-regexp
     orderless-prefixes
     orderless-literal
     orderless-flex))
  (completion-styles '(orderless)))

(use-package icomplete
  :custom
  (icomplete-delay-completions-threshold 0)
  (icomplete-max-delay-chars 2)
  (icomplete-compute-delay 0)
  (icomplete-show-matches-on-no-input t)
  (icomplete-hide-common-prefix nil)
  (icomplete-prospects-height 10)
  (icomplete-in-buffer nil)
  (icomplete-with-completion-tables t)
  :bind
  (:map
   icomplete-minibuffer-map
   ("C-m" . minibuffer-complete-and-exit)
   ("C-j" . exit-minibuffer)
   ("C-s" . icomplete-forward-completions)
   ("C-n" . icomplete-forward-completions)
   ("C-p" . icomplete-backward-completions)
   ("<tab>" . minibuffer-complete)
   ("<return>" . icomplete-force-complete-and-exit))
  :hook (after-init . icomplete-mode))

(use-package company-prescient
  :config
  (company-prescient-mode))

(use-package prescient
  :config
  (prescient-persist-mode t)
  :custom
  (prescient-save-file (locate-user-emacs-file "auto-save-list/prescient-cache.el"))
  (prescient-sort-length-enable nil)
  (prescient-filter-method '(literal regexp fuzzy)))

(use-package icomplete-vertical
  :hook (after-init . icomplete-vertical-mode))

(use-package company
  :diminish
  :ensure t
  :custom
  (company-idle-delay 0.3)
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  :config
  (add-to-list 'company-backends 'company-capf)
  :bind
  (:map company-mode-map
		("<backtab>" . company-yasnippet)
		:map company-active-map
		("C-p" . company-select-previous)
		("C-n" . company-select-next)
		("<tab>" . company-complete-common-or-cycle)
		("<backtab>" . my-company-yasnippet)
		:map company-search-map
		("C-p" . company-select-previous)
		("C-n" . company-select-next)))

(use-package consult
  :bind
  ("C-c U" . consult-git-grep)
  ("M-g M-g" . consult-goto-line))

(use-package company-box
  :diminish
  :ensure t
  :hook (company-mode . company-box-mode))

(provide 'init-completion)

;; ;; ;;;IVY Disabled
;; (use-package ivy
;;   :bind
;;   ("C-\\" . ivy-switch-buffer)
;;   ("C-x C-r" . ivy-switch-buffer)
;;   :config
;;   (setq ivy-height 10
;;	ivy-re-builders-alist '((t . ivy--regex-fuzzy))
;;	ivy-count-format ""
;;	ivy-use-virtual-buffers t))
;; ;; (use-package all-the-icons-ivy
;; ;;   :disabled
;; ;;   :after (all-the-icons ivy)
;; ;;   :custom
;; ;;   (all-the-icons-spacer " ")
;; ;;   (all-the-icons-ivy-file-commands
;; ;;    '(counsel-dired-jump
;; ;;      counsel-find-file
;; ;;      counsel-file-jump
;; ;;      counsel-find-library
;; ;;      counsel-git
;; ;;      counsel-projectile-find-dir
;; ;;      counsel-projectile-find-file
;; ;;      counsel-recentf))
;; ;;   :config (all-the-icons-ivy-setup))
;; ;; :bind
;; ;; (("C-\\" . ivy-switch-buffer)
;; ;;  ("C-x b" . ivy-switch-buffer)
;; ;;  :map ivy-minibuffer-map
;; ;;  ("C-s" . ivy-next-line)
;; ;;  ("C-M-j" . ivy-partial)
;; ;;  ("C-j" . ivy-immediate-done)
;; ;;  ("C-\\" . ivy-next-line))
;; ;; :config
;; ;; (setq read-file-name-function
;; ;;	(lambda (&rest args)
;; ;;	  (let ((completing-read-function #'completing-read-default))
;; ;;	    (apply #'read-file-name-default args))))
;; ;; :custom
;; ;; (ivy-wrap t)
;; ;; (consult-project-root-function #'projectile-project-root)
;; ;; (counsel-switch-buffer-preview-virtual-buffers nil)
;; ;; (ivy-extra-directories '("./"))
;; ;; (ivy-count-format "")
;; ;; (ivy-use-virtual-buffers t))

;; (use-package counsel :ensure t
;;   :disabled
;;   :bind
;;   (("M-x" . counsel-M-x)
;;    ("C-c U" . counsel-grep)))

;; (use-package ivy-rich
;;   :disabled
;;   :custom
;;   (ivy-rich-path-style 'abbrev)
;;   (ivy-rich-modify-columns
;;    'ivy-switch-buffer
;;    '((ivy-rich-switch-buffer-size (:align right))
;;      (ivy-rich-switch-buffer-major-mode (:width 20 :face font-lock-keyword-face)))))

;; (use-package ivy-prescient
;;   :disabled
;;   :ensure t
;;   :config
;;   (ivy-prescient-mode 1))
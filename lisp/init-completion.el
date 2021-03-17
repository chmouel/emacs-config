;; Prettiness
(use-package marginalia
  :custom
  (marginalia-annotators
   '(marginalia-annotators-heavy
     marginalia-annotators-light))
  :init
  (marginalia-mode +1))

(use-package swivb
  :if (and (boundp 'my-swivb-location) (file-directory-p my-swivb-location))
  :commands (swivb)
  :load-path my-swivb-location ; TODO: need to upload it in melpa
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
  (completion-styles '(regexp orderless)))

(use-package minibuffer
  :defer t
  :ensure nil
  :config
  (defun defer-garbage-collection-h ()
    (setq gc-cons-threshold most-positive-fixnum))

  (defun restore-garbage-collection-h ()
    (run-at-time
     1 nil (lambda () (setq gc-cons-threshold my-gc-cons-threshold))))  
  :hook ((minibuffer-setup . defer-garbage-collection-h)
         (minibuffer-exit . restore-garbage-collection-h)))

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
   ("<return>" . icomplete-force-complete-and-exit)))

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

(use-package company-box
  :diminish
  :ensure t
  :hook (company-mode . company-box-mode))

(use-package consult
  :bind
  ("C-x C-r" . counsult-recent-file)
  ("C-c U" . consult-git-grep)
  ("M-g M-g" . consult-goto-line))

(use-package selectrum
  :hook (after-init . selectrum-mode)
  :preface (declare-function chmou-selectrum-insert-or-submit-current-candidate nil)
  :init
  (defun chmou-selectrum-classic-find-file-completion ()
    "This tries to mimic the classic find file completion

If multiple matches, go to next candidates, and rotate if we are at the bottom.
If only one match, select it.
If current selection is a directory insert it in the current completion."
    (interactive)
    (progn
      (let* ((index
              (if (and selectrum--current-candidate-index
                       (not (< selectrum--current-candidate-index 0)))
                  selectrum--current-candidate-index 0))
             (matchesn (length (selectrum-get-current-candidates)))
             (selection (selectrum--get-candidate index)))
        (cond
         ((string-suffix-p "/" selection)
          (selectrum-insert-current-candidate))
         ((> (length (selectrum-get-current-candidates)) 1)
          (if (= (+ 1 index) matchesn) ;; Rotate if we are at the end
              (selectrum-next-candidate (-(- matchesn 1)))
            (selectrum-next-candidate)))
         ((= (length (selectrum-get-current-candidates)) 1)
          (selectrum-select-current-candidate))))))
  :ensure t
  :custom-face
  (selectrum-current-candidate ((t
                                 (:inherit highlight
                                           :underline nil))))
  :bind
  (:map selectrum-minibuffer-map
        ("C-s" . selectrum-next-candidate)
        ("TAB" . chmou-selectrum-classic-find-file-completion)        
        ("C-RET" . selectrum-submit-exact-input)
        ("C-\\" . selectrum-next-candidate))
  :custom
  (selectrum-count-style 'nil)
  (selectrum-max-window-height 15)
  (selectrum-extend-current-candidate-highlight t))

(use-package selectrum-prescient
  :ensure t
  :after selectrum
  :init
  (selectrum-prescient-mode +1))

;; IVY Disabled
(use-package ivy
  :ensure t
  :bind
  (:map ivy-minibuffer-map
        ("C-s" . ivy-next-line)
        ("C-M-j" . ivy-partial)
        ("C-j" . ivy-immediate-done)
        ("C-\\" . ivy-next-line))
  :custom
  (ivy-wrap t)
  (consult-project-root-function #'projectile-project-root)
  (counsel-switch-buffer-preview-virtual-buffers nil)
  (ivy-extra-directories '("./"))
  (ivy-count-format "")
  (ivy-use-virtual-buffers t)
  :config
  (setq ivy-height 10
	    ivy-re-builders-alist '((t . ivy--regex-fuzzy))
	    ivy-count-format ""
	    ivy-use-virtual-buffers t))

(use-package all-the-icons-ivy
  :disabled
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

(provide 'init-completion)


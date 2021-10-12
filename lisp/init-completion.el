;; Prettiness
(use-package marginalia
  :custom
  (marginalia-annotators
   '(;; marginalia-annotators-heavy
     marginalia-annotators-light))
  :init
  (marginalia-mode +1))

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

(use-package prescient
  :config
  (prescient-persist-mode t)
  :custom
  (prescient-save-file (locate-user-emacs-file "auto-save-list/prescient-cache.el"))
  (prescient-sort-length-enable nil)
  (prescient-filter-method '(literal regexp fuzzy)))

(use-package consult
  :bind
  ("C-x C-r" . consult-recent-file)
  ("C-c U" . consult-ripgrep)
  ("C-S-s" . consult-isearch)
  ("s-g" . consult-goto-line)
  ("M-g M-g" . consult-goto-line))

(use-package consult-dir
  :bind
  ("C-c o" . consult-dir)
  :config
  ;; https://karthinks.com/software/jumping-directories-in-eshell/
  (defun eshell/j (&optional regexp)
    (let ((eshell-dirs (delete-dups
                        (mapcar 'abbreviate-file-name
                                (ring-elements eshell-last-dir-ring)))))
      (cond
       ((and (not regexp) (featurep 'consult-dir))
        (let* ((consult-dir--source-eshell
                `(:name "Eshell"
                        :narrow ?e
                        :category file
                        :face consult-file
                        :items ,eshell-dirs))
               (consult-dir-sources (cons consult-dir--source-eshell
                                          consult-dir-sources)))
          (eshell/cd (substring-no-properties
                      (consult-dir--pick "Switch directory: ")))))
       (t (eshell/cd (if regexp (eshell-find-previous-directory regexp)
                       (completing-read "cd: " eshell-dirs))))))))

(use-package embark
  :bind
  ("M-o" . embark-act))

(use-package embark-consult
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))

(provide 'init-completion)


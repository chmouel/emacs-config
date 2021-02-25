;;; init-dired.el ---                                -*- lexical-binding: t; -*-
(use-package dired-x
  :ensure nil
  :hook ((dired-mode . dired-omit-mode))
  :custom
  ((dired-omit-files
    (concat "^\\.\\|^\\.?#\\|^\\.$\\|^\\.\\.$\\|"
            "^Thumbs.db$\\|\\.svn$\\|\\.git\\(ignore\\)?\\|"
            "\\.pyc$\\|^\\.coverage$\\|^TAGS$\\|^tags$\\|"
            "\\.class$\\|\\.DS_Store\\|\\.localized$\\|__pycache__$")))
  :config
  (setq dired-omit-verbose nil)
  ;; hide backup, autosave, *.*~ files
  ;; omit mode can be toggled using `C-x M-o' in dired buffer.
  (setq dired-omit-files
        (concat dired-omit-files "\\|^.DS_STORE$\\|^.projectile$\\|^.git$")))

;; Dired
(use-package dired
  :ensure nil  
  :hook
  (dired-mode . my-dired-mode-hook)
  :config
  (if (executable-find "gls")
      (setq insert-directory-program "gls"))
  
  (defun my-dired-mode-hook ()
    (when (featurep 'tooltip) (tooltip-mode 0)))
  
  :bind
  ("C-x C-j" . dired-jump)
  (:map dired-mode-map
        ("W" . browse-url-of-dired-file)
        ("O" . dired-omit-mode)
        ("E" . wdired-change-to-wdired-mode)
        ("s" . dired-up-directory)
        ("j" . dired-next-line)
        ("k" . dired-previous-line)))

(use-package all-the-icons-dired
  :diminish
  :hook (dired-mode . all-the-icons-dired-mode))

;; diredfl:Extra Emacs font lock rules for a more colourful dired
(use-package diredfl
  :after dired
  :hook
  (dired-mode . diredfl-mode))

(use-package dired-quick-sort
  :hook
  (dired-mode . dired-quick-sort-setup))

(provide 'init-dired)
;;; init-dired.el ends here

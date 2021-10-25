(use-package desktop
  :custom
  (desktop-path (list (locate-user-emacs-file "auto-save-list")))
  (desktop-auto-save-timeout 600)
  (desktop-save nil)
  (desktop-globals-to-save
   '((comint-input-ring        . 50)
     (compile-history          . 30)
     desktop-missing-file-warning
     (dired-regexp-history     . 20)
     (extended-command-history . 30)
     (face-name-history        . 20)
     (file-name-history        . 100)
     (grep-find-history        . 30)
     (grep-history             . 30)
     (ivy-history              . 100)
     (magit-revision-history   . 50)
     (minibuffer-history       . 50)
     (org-clock-history        . 50)
     (org-refile-history       . 50)
     (org-tags-history         . 50)
     (query-replace-history    . 60)
     (read-expression-history  . 60)
     (regexp-history           . 60)
     (regexp-search-ring       . 20)
     register-alist
     (search-ring              . 20)
     (shell-command-history    . 50)
     tags-file-name
     tags-table-list))
  :hook (after-init . desktop-save-mode))

(provide 'init-sessions)

; HELM
;; (Package 'helm
;;   (require 'helm-config)
;;   (Package 'helm-git-files))

(defun my-helm()
  (interactive)
  (require 'helm-files)
  (define-key helm-map (kbd "C-S-p") 'helm-previous-source)
  (define-key helm-map (kbd "C-S-n") 'helm-next-source)
  (helm-other-buffer '(helm-source-buffers-list
                       helm-git-files:all-source
                       helm-source-magit-repos
                       helm-source-bookmarks
                       helm-source-ctags
                       helm-source-recentf)
                     "*helm chmou*"))

(defvar helm-source-magit-repos
  '((name . "Magit Repos")
    (init . (lambda ()
              (require 'magit)))
    (candidates . (lambda () (magit-list-repos magit-repo-dirs)))
    (action
     ("Open Dir" . dired)
     ("Magit" . magit-status))
  "See (info \"(emacs)magit\")."))


(setq helm-c-adaptive-history-file
    "~/.emacs.d/auto-save-list/anything-c-adaptive-history")

;(global-set-key (read-kbd-macro "C-z") 'my-helm)

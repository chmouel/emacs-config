; HELM
(push "~/.emacs.d/packages/helm" load-path)
(push "~/.emacs.d/packages/helm-ls-git" load-path)
(push "~/.emacs.d/packages/emacs-helm-ack" load-path)

(require 'helm-config)
(require 'helm-ls-git)
(require 'helm-ack)

(defun my-helm()
  (interactive)
  (require 'helm-files)
  (helm-other-buffer '(helm-source-buffers-list
                       helm-source-ls-git
                       helm-source-browse-code
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

(define-key helm-map (kbd "C-S-p") 'helm-previous-source)
(define-key helm-map (kbd "C-S-n") 'helm-next-source)
(global-set-key (read-kbd-macro "C-z") 'my-helm)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

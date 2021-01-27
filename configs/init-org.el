;; Org-Mode

(defconst  org-directory "~/Documents/orgs")
(defconst org-inbox-file (expand-file-name "inbox.org" org-directory))
(defconst org-capture-file (expand-file-name "capture.org" org-directory))

(set-register ?o (cons 'file org-inbox-file))
(set-register ?c (cons 'file org-capture-file))

(use-package org
  :mode (("\\.org$" . org-mode))
  :commands (org-agenda org-capture)
  :bind
  (:map org-mode-map
        ("C-c k" . org-cut-subtree))
  :init
  (setq org-replace-disputed-keys t)
  :custom
  (org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
  (org-yank-adjusted-subtrees t)
  (org-completion-use-ido t)
  (org-return-follows-link t))

(use-package org-capture
  :commands (org-capture)
  :bind
  ("C-c v c" . org-capture)
  ("C-c v l" . (lambda () (interactive) (org-capture nil "l"))) ;; Link from Mozilla
  ("C-c v r" . (lambda () (interactive) (org-capture nil "r"))) ;; Region from somewhere
  ("C-c v t" . (lambda () (interactive) (org-capture nil "t"))) ;; TODO
  :config
  (setq org-capture-templates
        '(("t" "TODO" entry
           (file+olp+datetree org-inbox-file)
           "* TODO %?"
           :empty-lines 1)
          ("l" "Link" entry
           (file+olp+datetree org-capture-file)
           "* %?\n%x\n%i"
           :empty-lines 1)
          ("r" "Snippet" entry
           (file+olp+datetree org-capture-file)
           "* %?\n%x"
           :empty-lines 1))))


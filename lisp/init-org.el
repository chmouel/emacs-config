;; Org-Mode

(defconst org-directory "~/Documents/orgs")

(defconst org-todo-file (expand-file-name "todo.org" org-directory))
(defconst org-notes-file (expand-file-name "notes.org" org-directory))
(defconst org-links-file (expand-file-name "links.org" org-directory))

(set-register ?o (cons 'file org-todo-file))
(set-register ?c (cons 'file org-notes-file))

(require 'org-protocol nil t)

(use-package ob-restclient :after (restclient org))

(use-package org-capture
  :ensure nil
  :commands (org-capture)
  :bind
  ("C-c v c" . org-capture)
  ("C-c v t" . (lambda () (interactive) (org-capture nil "t"))) 
  ("C-c v n" . (lambda () (interactive) (org-capture nil "n"))) 
  ("C-c v l" . (lambda () (interactive) (org-capture nil "l"))) 
  ("C-c v j" . (lambda () (interactive) (find-file org-todo-file))) ;; TODO
  :config
  (setq org-capture-templates
        '(
          ("t" "TODO" entry
           (file+olp+datetree org-todo-file)
           "* TODO %?\nCaptured at %U"
           :empty-lines 1)

          ("l" "Link" entry
           (file org-links-file)
           "* %a\n%U\n%?\n%i"
           :empty-lines 1)

          ("Pn" "Notes" entry (file+headline org-notes-file "Notes from the web")
           "* %:description\nCaptured at %U\n%c\n #+BEGIN_QUOTE %?\n%i\n#+END_QUOTE\n\n")

          ("Pb" "Links" entry (file+datetree org-links-file)
           "* %:description \nCaptured at %U\n[[%:link][%:description]]\n%?\n")
          
          ("r" "Snippet" entry
           (file+olp+datetree org-capture-file)
           "* %?\n%x"
           :empty-lines 1))))

(use-package org
  :ensure nil
  :mode (("\\.org$" . org-mode))
  :commands (org-agenda org-capture)
  :bind
  (:map org-mode-map
        ("C-c k" . org-cut-subtree))
  :custom
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)" "CANCELED(c@/!)")))
  (org-todo-state-tags-triggers '(("CANCELLED" ("CANCELLED" . t))
                                  ("WAITING" ("WAITING" . t))
                                  (done ("WAITING"))
                                  ("TODO" ("WAITING") ("CANCELLED"))
                                  ("NEXT" ("WAITING") ("CANCELLED"))
                                  ("DONE" ("WAITING") ("CANCELLED"))))
  (org-use-tag-inheritance t)
  (org-tag-alist '(("linux")
                   ("pac")
                   ("emacs")
                   ("org")
                   ("openshift")
                   ("redhat")
                   ("tektoncd")
                   ("docs")
                   ("code")
                   ("review")
                   (:startgroup . nil)
                   ("#home" . ?h) ("#work" . ?w) ("#errand" . ?e) ("#health" . ?l)
                   (:endgroup . nil)
                   (:startgroup . nil)
                   ("#link" . ?i) ("#read" . ?r) ("#project" . ?p)
                   (:endgroup . nil)))
  (org-replace-disputed-keys t)
  (org-log-done 'time)
  (org-log-redeadline 'time)
  (org-log-reschedule 'time)
  (org-log-into-drawer t)
  (org-enforce-todo-dependencies t)
  (org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
  (org-yank-adjusted-subtrees t)
  (org-completion-use-ido t)
  (org-return-follows-link t))

(provide 'init-org)

;; Org-Mode

(defconst org-directory "~/Sync/orgs")

(defconst org-todo-file (expand-file-name "todo.org" org-directory))
(defconst org-notes-file (expand-file-name "notes.org" org-directory))
(defconst org-links-file (expand-file-name "links.org" org-directory))
(defconst org-snippet-file (expand-file-name "snippets.org" org-directory))

(set-register ?o (cons 'file org-todo-file))
(set-register ?c (cons 'file org-notes-file))

(require 'org-protocol nil t)

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill)
  :config
  (defun efs/org-mode-visual-fill ()
    (setq visual-fill-column-width 140
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1)))

(setq org-bars-installation-dir (expand-file-name "org-bars" package-user-dir))
(use-package org-bars
  :after org
  :if (file-directory-p org-bars-installation-dir)
  :load-path org-bars-installation-dir
  :hook (org-mode . org-bars-mode))

(use-package org-capture
  :ensure nil
  :commands (org-capture)
  :hook
  (org-shiftup-final . windmove-up)
  (org-shiftleft-final . windmove-left)
  (org-shiftdown-final . windmove-down)
  (org-shiftright-final . windmove-right)
  :bind
  ("C-c c c" . org-capture)
  ("C-c c t" . (lambda () (interactive) (org-capture nil "t"))) 
  ("C-c c n" . (lambda () (interactive) (org-capture nil "n"))) 
  ("C-c c l" . (lambda () (interactive) (org-capture nil "l"))) 
  ("C-c c p" . (lambda () (interactive) (org-capture nil "p"))) 
  ("C-c c j" . (lambda () (interactive) (find-file org-todo-file))) ;; TODO
  :config
  (defun my-capture-code-snippet ()
    (format
     "file:%s::%s

In function ~%s~
#+BEGIN_SRC %s
%s
#+END_SRC"
     (abbreviate-file-name buffer-file-name)
     (if (region-active-p)
         (format "%s-%s"
                 (line-number-at-pos
                  (region-beginning))
                 (line-number-at-pos (region-end)))
       (line-number-at-pos))
     (cond
      ((fboundp 'which-function)
       (which-function))
      ((eq major-mode 'go-mode)
       (save-excursion
         (go-goto-function-name)
         (substring-no-properties (thing-at-point 'sexp))))
      ((eq major-mode 'python-mode) ;; pytest regexp
       (save-excursion
         (re-search-backward
          "^[ \t]\\{0,4\\}\\(class\\|\\(?:async \\)?def\\)[ \t]+\\([a-zA-Z0-9_]+\\)" nil t)
         (buffer-substring-no-properties (match-beginning 2) (match-end 2)))))
     (replace-regexp-in-string "-mode$" "" (symbol-name major-mode))
     (if (region-active-p)
         (buffer-substring-no-properties (region-beginning) (region-end))
       (buffer-substring-no-properties
        (line-beginning-position)
        (line-end-position)))))
  (setq org-capture-templates
        '(("t" "Simple>TODO" entry
           (file+olp org-todo-file "TODOS")
           "* TODO %?\nCaptured at %U"
           :empty-lines 1)

          ("n" "Simple>NOTES" entry
           (file+olp org-notes-file "NOTES")
           "* %c %?\nCaptured at %U"
           :empty-lines 1)

          ("p" "Pipelines as Code>TODO" entry
           (file+olp org-todo-file "Pipelines as Code")
           "* TODO %?\n\n%(with-current-buffer (org-capture-get :original-buffer) (my-capture-code-snippet))\n
Captured at %U"
           :empty-lines 1)

          ("P" "Pipelines as Code>Notes" entry
           (file+olp org-notes-file "Pipelines as Code")
           "* %?\nCaptured at %U"
           :empty-lines 1)
          
          ("l" "Link" entry
           (file+olp org-links-file "LINKS")
           "* %a\n%U\n%?\n%i"
           :empty-lines 1)

          ("Pl" "Protocol Link" entry (file+olp org-links-file "WEB") "* %?[[%:link][%:description]]\n")
          ("Pn" "Protocol Notes" entry (file+olp org-notes-file "WEB") "* [[%:link][%:description]]\n#+BEGIN_QUOTE %?\n%:initial\n#+END_QUOTE\n\n" :empty-lines 1))))

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
  (org-tag-alist '(("pac")
                   ("emacs")
                   ("openshift")
                   ("redhat")
                   ("tektoncd")
                   (:startgroup . nil)
                   ("#link" . ?i) ("#read" . ?r) ("#project" . ?p)
                   (:endgroup . nil)))
  
  (org-special-ctrl-a/e t)
  (org-log-done 'time)
  (org-log-redeadline 'time)
  (org-log-reschedule 'time)
  (org-log-into-drawer t)
  (org-enforce-todo-dependencies t)
  (org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
  (org-yank-adjusted-subtrees t)
  (org-completion-use-ido t)
  (org-return-follows-link t))

(use-package org-superstar
  :disabled
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (set-face-attribute 'org-superstar-header-bullet nil :inherit 'fixed-pitched :height 180)
  :custom
  ;; set the leading bullet to be a space. For alignment purposes I use an em-quad space (U+2001)
  (org-superstar-headline-bullets-list '(" "))
  (org-superstar-todo-bullet-alist '(("DONE" . ?✔)
                                     ("TODO" . ?⌖)
                                     ("ISSUE" . ?)
                                     ("BRANCH" . ?)
                                     ("FORK" . ?)
                                     ("MR" . ?)
                                     ("MERGED" . ?)
                                     ("GITHUB" . ?A)
                                     ("WRITING" . ?✍)
                                     ("WRITE" . ?✍)
                                     ))
  (org-superstar-special-todo-items t)
  (org-superstar-leading-bullet ""))

(use-package org-download
  :hook (org-mode . org-download-enable)
  :after org)


(provide 'init-org)


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

          ("p" "Work>TODO" entry
           (file+olp org-todo-file "Work")
           "* TODO %?\n\n%(with-current-buffer (org-capture-get :original-buffer) (my-capture-code-snippet))\n
Captured at %U"
           :empty-lines 1)

          ("P" "Work>Notes" entry
           (file+olp org-notes-file "Work")
           "* %?\nCaptured at %U"
           :empty-lines 1)
          
          ("l" "Link" entry
           (file+olp org-links-file "LINKS")
           "* %a\n%U\n%?\n%i"
           :empty-lines 1)

          ("Pl" "Protocol Link" entry (file+olp org-notes-file "Random") "* %?[[%:link][%:description]]\n")
          ("Pn" "Protocol Notes" entry (file+olp org-notes-file "Random") "* [[%:link][%:description]]\n#+BEGIN_QUOTE %?\n%:initial\n#+END_QUOTE\n\n" :empty-lines 1))))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(use-package org
  :ensure nil
  :mode (("\\.org$" . org-mode))
  :commands (org-agenda org-capture)
  :hook
  (org-mode . org-indent-mode)
  :bind
  (:map org-mode-map
        ("C-o" . crux-smart-open-line-above))
  :custom
  (org-archive-location "archives.org::* Archives %s")
  (org-use-speed-commands t)
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)" "CANCELED(c@/!)" "ONEDAY(o)" )))
  (org-todo-state-tags-triggers '(("CANCELLED" ("CANCELLED" . t))
                                  ("WAITING" ("WAITING" . t))
                                  (done ("WAITING"))
                                  ("TODO" ("WAITING") ("CANCELLED"))
                                  ("NEXT" ("WAITING") ("CANCELLED"))
                                  ("DONE" ("WAITING") ("CANCELLED"))))
  (org-use-tag-inheritance t)
  (org-tag-alist '(("linux")
                   ("emacs")
                   ("programming")
                   (:startgroup . nil)
                   ("pipelinesascode") ("openshift") ("redhat") ("tektoncd")
                   (:endgroup . nil)))
  
  (org-special-ctrl-a/e t)
  (org-special-ctrl-o nil)
  (org-startup-truncated nil)
  (org-completion-use-ido t)
  (org-todo-keyword-faces
   '(("IDEA" . (:foreground "GoldenRod" :weight bold))
     ("NEXT" . (:foreground "IndianRed1" :weight bold))
     ("STARTED" . (:foreground "OrangeRed" :weight bold))
     ("WAITING" . (:foreground "coral" :weight bold))
     ("CANCELED" . (:foreground "LimeGreen" :weight bold))
     ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
     ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))))
  (org-adapt-indentiation nil))

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

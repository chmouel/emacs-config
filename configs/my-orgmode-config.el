;Org-Mode
(require 'org)

(push '("\\.org$" . org-mode) auto-mode-alist)
(setq
 org-replace-disputed-keys t
 org-default-notes-file (concat org-directory "/notes.org")
 org-return-follows-link t)

(require 'the-org-mode-expansions)

(define-key global-map "\C-cc" 'org-capture)

(setq org-link-abbrev-alist
      '(("lp" . "https://bugs.launchpad.org/+bug/")))

(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline (concat org-directory "/gtd.org") "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("l" "Link" entry
         (file+headline  (concat org-directory "/links.org") "Links to Read")
         "* %?\n %i")))

(defvar org-electric-pairs '((?\' . ?\')(?\* . ?\*) (?/ . ?/) (?= . ?=)
                             (?\_ . ?\_) (?~ . ?~) (?+ . ?+)) "Electric pairs for org-mode.")

(defun org-add-electric-pairs ()
  (setq-local electric-pair-pairs (append electric-pair-pairs org-electric-pairs))
  (setq-local electric-pair-text-pairs electric-pair-pairs))

(add-to-list 'org-emphasis-alist
             '("*" (:foreground "grey" :weight bold)))

(defun my-org-mode-hook ()
  (local-set-key (kbd "M-n") 'outline-next-visible-heading)
  (local-set-key (kbd "M-p") 'outline-previous-visible-heading)
  (local-set-key (kbd "C-c a") 'org-agenda)
  (org-display-inline-images t t)
  (org-add-electric-pairs)
  (auto-fill-mode)
  (electric-indent-mode)
  (flyspell-mode))

(dolist (k
         '("<S-down>" "<S-up>" "<S-left>"
           "<S-right>" "<C-TAB>" "<M-up>"
           "<M-down>"))
  (define-key org-mode-map (kbd k) nil))
(add-hook 'org-mode-hook 'my-org-mode-hook)

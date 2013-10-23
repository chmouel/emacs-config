;Org-Mode
(require 'org)

(push '("\\.org$" . org-mode) auto-mode-alist)
(setq
 org-replace-disputed-keys t
 org-default-notes-file (concat org-directory "/notes.org")
 org-return-follows-link t)

(setq org-link-abbrev-alist
      '(("lp" . "https://bugs.launchpad.org/+bug/")))

(defun my-org-mode-hook ()
  (auto-fill-mode)
  (electric-indent-mode)
  (flyspell-mode)
  (global-set-key '[(control tab)]            'other-window))
(add-hook 'org-mode-hook 'my-org-mode-hook)

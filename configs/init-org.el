;Org-Mode
(require 'org)

(push '("\\.org$" . org-mode) auto-mode-alist)
(setq
 org-replace-disputed-keys t
 org-default-notes-file (concat org-directory "/notes.org")
 org-return-follows-link t)

(require 'the-org-mode-expansions)

(define-key global-map "\C-cc" (lambda () (interactive) (org-capture nil "d")))
(define-key global-map "\C-cv" (lambda () (interactive) (org-capture nil "t")))

(setq org-link-abbrev-alist
      '(("lp" . "https://bugs.launchpad.org/+bug/")))

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
           "<S-right>" "<M-up>" "[C-Tab]"
           "<M-down>" "<M-right>" "<M-left>"))
  (define-key org-mode-map (kbd k) nil))
(add-hook 'org-mode-hook 'my-org-mode-hook)

;; Get the current chrome tab and insert the title and the issue number link in
;; org format, gets the labels of the issue too via the github json api
;; Leverage on https://github.com/rejeep/chrome-cli.el for getting current tab
(defun my-get-labels-info-gh(issuenumber)
  (let* ((url
          (format "https://api.github.com/repos/openshiftio/openshift.io/issues/%s" issuenumber))
         (myt (my-github-parse-response (url-retrieve-synchronously url))))
    (string-join
     (mapcar
      (lambda (x)
        (if (string-match "^SEV" (plist-get x :name))
            (concat ":" (plist-get x :name) ":")))
      (plist-get myt :labels)))))

(defun my-github-parse-response (buffer)
  "Parses the JSON response from a GitHub API call."
  (let ((json-object-type 'plist))
    (unwind-protect
        (with-current-buffer buffer
          (save-excursion
            (url-http-parse-response)
            (goto-char (point-min))
            (search-forward "\n\n")
            (json-read)))
      (kill-buffer buffer))))

(defun my-org-insert-github-from-current-tab ()
  (interactive)
  (let* ((chrome-info (chrome-cli-tab))
         (url (plist-get chrome-info :url))
         (issuenumber (replace-regexp-in-string "https://github.com/.*/issues/" "" url))
         (labels)
         (title (concat (truncate-string-to-width (plist-get chrome-info :title) 50) "...")))
    (if (not issuenumber)
        (error "%s does not seem a github url" url))
    (if (and title issuenumber)
        (insert (format "[[%s][#%s - %s]] %s" url issuenumber title (my-get-labels-info-gh issuenumber))))))

(defun my-org-mode-chrome-cli-insert-current-tab-title-url ()
  (interactive)
  (let* ((chrome-info (chrome-cli-tab))
         (title (concat (truncate-string-to-width (plist-get chrome-info :title) 50) "..."))
         (url (plist-get chrome-info :url)))
    (insert (format "[[%s][%s]]" url title))))

(defun my-org-capture-mode-hook ()
  (interactive)
  (local-set-key (kbd "C-+") 'my-org-mode-chrome-cli-insert-current-tab-title-url)
  (local-set-key (kbd "C-=") 'my-org-insert-github-from-current-tab))
(add-hook 'org-capture-mode-hook 'my-org-capture-mode-hook)

(provide 'init-org)

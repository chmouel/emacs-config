(require 'message)
;(use-package message-x :ensure t)

; Use message
(fset 'mail 'message-mail)

(setq
 message-auto-save-directory "~/Gnus/Mail/drafts"
 message-directory "~/Gnus/Mail")

(push '("\\.eml\\'" . message-mode) auto-mode-alist)

(defvar my-message-upstream-mode nil)
(defun my-change-background-on-upstream-ml()
  (if my-message-upstream-mode
      (progn
        (face-remap-add-relative 'default '(:foreground "#242424" :background "#f6f3e8")))))

(require 'lbdb nil t)
(when (featurep 'lbdb)
  (define-key message-mode-map (kbd "C--") 'lbdb))

(defun my-change-ispell-local-to-francais ()
  (interactive)
  (progn
    (ispell-change-dictionary "francais")
    (ispell-message)))

;;Messages
(defun my-message-mode-hook()
  (my-change-background-on-upstream-ml)
  (footnote-mode)
  (flyspell-mode)
  (local-set-key (kbd "C-$") 'my-change-ispell-local-to-francais)
  (local-set-key '[(control return)] 'my-email-adress-switch)
  (local-set-key (kbd "C-M-m") 'expand-abbrev)
  (local-set-key (read-kbd-macro "M-;") 'boxquote-region)
  (local-set-key (read-kbd-macro "C-;") 'comment-dwim)
  (local-set-key '[(f2)] 'mail-abbrev-insert-alias)
  (local-set-key '[(f8)] 'my-ispell-message-and-switch))
(add-hook 'message-mode-hook 'my-message-mode-hook)

(setq my-email-adresses
      '(("samuel@chmouel.com")
        ("chmouel@chmouel.com")
        ("cboudjna@chmouel.com")
        ("chmouel@redhat.com")))

;; Switch Email Adresses
(defun my-email-adress-switch ()
  (interactive)
  (save-excursion
	(let ((email-adress
           (completing-read
            "Email adress: "
            my-email-adresses nil t)))
      (message-goto-from)
      (goto-char (point-at-bol))
      (kill-line)
      (insert (format "From: %s <%s>" user-full-name email-adress)))))

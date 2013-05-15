(global-set-key '[(f11)] 'switch-to-irc)
(defun switch-to-irc (&optional arg)
  (interactive "P")
  (let (candidate
        (alist '(("#enovance-priv"))))
    (catch 'none-found
      (dolist (item alist)
        (let (last
              (regexp (nth 0 item))
              (optional (nth 1 item))
              (test (nth 2 item)))
          (dolist (buf (buffer-list))
            (when (and (string-match regexp (buffer-name buf))
                       (> (buffer-size buf) 0))
              (setq last buf)))
          (cond ((and last (or (not test) (funcall test)))
                 (setq candidate last))
                (optional
                 nil)
                (t
                 (throw 'none-found t))))))
    (cond (candidate
           (switch-to-buffer candidate))
          (t
           (znc-erc "OFTC"))
          (t
           (error "No candidate found")))))

;Switch to Gnus
(global-set-key '[(f7)] 'switch-to-gnus)
(defun switch-to-gnus (&optional arg)
  (interactive "P")
  (let (candidate
        (alist '(("^\\*\\(mail\\|\\(wide \\)?reply\\)" t)
                 ("^\\*Group")
                 ("^\\*Summary")
                 ("^\\*Article" nil (lambda ()
                                      (buffer-live-p gnus-article-current-summary))))))
    (catch 'none-found
      (dolist (item alist)
        (let (last
              (regexp (nth 0 item))
              (optional (nth 1 item))
              (test (nth 2 item)))
          (dolist (buf (buffer-list))
            (when (and (string-match regexp (buffer-name buf))
                       (> (buffer-size buf) 0))
              (setq last buf)))
          (cond ((and last (or (not test) (funcall test)))
                 (setq candidate last))
                (optional
                 nil)
                (t
                 (throw 'none-found t))))))
    (cond (candidate
           (switch-to-buffer candidate))
          (t
           (gnus))
          (t
           (error "No candidate found")))))

;; I-search with initial contents
(global-set-key '[(control *)] 'isearch-forward-at-point)
(defvar isearch-initial-string nil)
(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))
(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
      "Interactive search forward for the symbol at point."
      (interactive "P\np")
      (if regexp-p (isearch-forward regexp-p no-recursive-edit)
        (let* ((end (progn (skip-syntax-forward "w_") (point)))
               (begin (progn (skip-syntax-backward "w_") (point))))
          (if (eq begin end)
              (isearch-forward regexp-p no-recursive-edit)
            (setq isearch-initial-string (buffer-substring begin end))
            (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
            (isearch-forward regexp-p no-recursive-edit)))))

;
;Duplicate current line down
(global-set-key '[(control meta d)] 'my-duplicate-line-or-region)
(defun my-duplicate-region (beg end &optional sep)
  "Duplicate the region"
  (interactive "*r")
  (let ((p (point)))
    (copy-region-as-kill beg end)
    (message "%d" (point))
    (goto-char end)
    (if (stringp sep) (insert sep))
    (yank)
    (goto-char p)))

(defun my-duplicate-line-or-region ()
  "duplicate the region if active otherwise the current line"
  (interactive)
  (if mark-active
      (my-duplicate-region (point) (mark))
    (progn (my-duplicate-region (point-at-bol) (point-at-eol) "\n")(next-line))))

;Down/UP the current line
(global-set-key '[(control x) (up)] 'my-up-line)
(global-set-key '[(control x) (down)] 'my-down-line)
(defun my-down-line()
  (interactive)
  (let ((col (current-column)))
    (forward-line 1)
    (transpose-lines 1)
    (forward-line -1)
    (forward-char col)
    )
  )

(defun my-up-line()
  (interactive)
  (let ((col (current-column)))
    (transpose-lines 1)
    (forward-line -2)
    (forward-char col)
    )
  )

 ;; behave like vi's o command
 (defun open-next-line (arg)
   "Move to the next line and then opens a line.
 See also `newline-and-indent'."
   (interactive "p")
   (end-of-line)
   (open-line arg)
   (next-line 1)
   (when newline-and-indent
     (indent-according-to-mode)))

 ;; behave like vi's O command
 (defun open-previous-line (arg)
   "Open a new line before the current one.

  See also `newline-and-indent'."
   (interactive "p")
   (beginning-of-line)
   (open-line arg)
   (when newline-and-indent
     (indent-according-to-mode)))
 (global-set-key (kbd "C-o") 'open-previous-line)

 ;; autoindent open-*-lines
 (defvar newline-and-indent t
   "Modify the behavior of the open-*-line functions to cause them to autoindent.")

; if no selection just comment line or comment selection
(defun my-comment-line-or-region ()
  (interactive "*")
  (if (and mark-active transient-mark-mode)
      (comment-or-uncomment-region (region-beginning) (region-end) nil)
    (progn
      (save-excursion
        (move-beginning-of-line nil)
        (set-mark-command nil)
        (move-end-of-line nil)
        (comment-dwim nil)
        ))))
(global-set-key (read-kbd-macro "C-;") 'my-comment-line-or-region)
(global-set-key (read-kbd-macro "M-;") 'comment-dwim)

;Hack dired to launch files with 'l' key.
;http://omniorthogonal.blogspot.com/2008/05/useful-emacs-dired-launch-hack.html
(defun my-dired-launch-command ()
  (interactive)
  (dired-do-shell-command
   (case system-type
     (gnu/linux "gnome-open") ;right for gnome (ubuntu), not for other systems
     (darwin "open"))
   nil
   (dired-get-marked-files t current-prefix-arg)))


;; Remap goto-line to show temporary the line number.
;; http://whattheemacsd.com//key-bindings.el-01.html
(global-set-key [remap goto-line] 'goto-line-with-feedback)
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

; Insert an empty line after the current line.
; Position the cursor at its beginning, according to the current mode.
(defun smart-open-line ()
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))
(global-set-key [(shift return)] 'smart-open-line)

; Kill to the beginning of line (i.e: reverse c-k)
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))


;Kill whole line but stay at the same place.
(global-set-key (kbd "C-S-k") (lambda ()
                                (interactive)
                                (let ((p (point)))
                                  (kill-whole-line)
                                  (goto-char p))))


; https://github.com/jedrz/.emacs.d/blob/master/defuns/misc-defuns.el
(defun my-hippie-expand-lines ()
  "Try to expand entire line."
  (interactive)
  (let ((hippie-expand-try-functions-list '(try-expand-line
                                            try-expand-line-all-buffers)))
    (hippie-expand nil)))
(global-set-key (kbd "C-?") 'my-hippie-expand-lines)

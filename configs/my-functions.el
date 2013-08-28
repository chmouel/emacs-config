;; Magit and git quick open files for projects.
(defun my-magit-open-directory-and-file ()
  "Open quickly a magit directory and open a git file in there"
  (interactive)
  (let ((default-directory (magit-read-top-dir nil)))
    (find-file-in-git-repo)))
(global-set-key (read-kbd-macro "C-S-p") 'my-magit-open-directory-and-file)

(defun my-magit-open-repository ()
  "Open quickly a magit directory."
  (interactive)
  (dired (magit-read-top-dir nil)))
(global-set-key (read-kbd-macro "C-S-o") 'my-magit-open-repository)

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

;http://emacsredux.com/blog/2013/05/30/joining-lines/
(defun my-top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))
(global-set-key (kbd "C-S-j") 'my-top-join-line)

;http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
(defun smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line] 'smarter-move-beginning-of-line)

; From http://git.naquadah.org/?p=~jd/emacs.d.git;a=summary
(defun my-google (keywords)
  "Form a google query URL and give it to browse-url"
  (interactive
   (list
    (if (use-region-p)
	(buffer-substring (region-beginning) (region-end))
      (read-string "Search Google for: " (thing-at-point 'word)))))
  (browse-url
   (concat "http://www.google.com/search?q="
	   (replace-regexp-in-string
	    "[[:space:]]+"
	    "+"
	    keywords))))

; From http://www.emacswiki.org/emacs/FullScreen#toc23
(defun my-toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

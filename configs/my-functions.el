;; Duplicate current line down
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

;; Remap goto-line to show temporary the line number.
;; http://whattheemacsd.com//key-bindings.el-01.html
(global-set-key [remap goto-line] 'goto-line-with-feedback)
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (display-line-numbers-mode 1)
        (goto-line (read-number "Goto line: ")))
    (display-line-numbers-mode -1)))

;; https://github.com/bbatsov/crux/blob/308f17d914e2cd79cbc809de66d02b03ceb82859/crux.el#L166
(defun crux-smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (insert "\n")
  (if electric-indent-inhibit
      ;; We can't use `indent-according-to-mode' in languages like Python,
      ;; as there are multiple possible indentations with different meanings.
      (let* ((indent-end (progn (move-to-mode-line-start) (point)))
             (indent-start (progn (move-beginning-of-line nil) (point)))
             (indent-chars (buffer-substring indent-start indent-end)))
        (forward-line -1)
        ;; This new line should be indented with the same characters as
        ;; the current line.
        (insert indent-chars))
    ;; Just use the current major-mode's indent facility.
    (forward-line -1)
    (indent-according-to-mode)))
(global-set-key (kbd "C-o") 'crux-smart-open-line-above)

;; Insert an empty line after the current line.
;; Position the cursor at its beginning, according to the current mode.
(defun smart-open-line ()
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))
(global-set-key [(shift return)] 'smart-open-line)

;; Kill to the beginning of line (i.e: reverse c-k)
(global-set-key
 (kbd "C-<backspace>")
 (lambda ()
   (interactive)
   (kill-line 0)
   (indent-according-to-mode)))

;; Kill whole line but stay at the same place.
(global-set-key
 (kbd "C-S-k")
 (lambda ()
   (interactive)
   (let ((p (point)))
     (kill-whole-line)
     (goto-char p))))

;; http://emacsredux.com/blog/2013/05/30/joining-lines/
(defun my-top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))
(global-set-key (kbd "C-S-j") 'my-top-join-line)

;; http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
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


;; From http://www.emacswiki.org/emacs/FullScreen#toc23
(defun my-toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; Emacswiki
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
(define-key global-map (kbd "C-S-SPC") 'copy-line)

;; I have a bunch of different 'profiles' for kubernetes by different cluster so
;; i don't mess between things
;; This allow me to set the KUBECONFIG variable between those easily
;; TODO: add the current profile in modeline
(defun my-switch-kubeconfig-env (&optional kubeconfig)
  (interactive
   (list
    (completing-read
     "Kubeconfig: "
     (mapcar
      (lambda (x)
        (replace-regexp-in-string
         "^config\." ""
         (file-name-nondirectory(directory-file-name x))))
      (directory-files-recursively
       (expand-file-name "~/.kube") "^config\.")) nil t )))
  (setq kubeconfig (expand-file-name (format "~/.kube/config.%s" kubeconfig)))
  (if (file-exists-p kubeconfig)
      (setenv "KUBECONFIG" kubeconfig)
    (error "Cannot find kubeconfig: %s" kubeconfig)))

;; Is that useful?
(defun my-generate-commit()
  (interactive)
  (goto-char (point-min))
  (re-search-forward "^# Everything starting" nil t)
  (kill-region (point-min) (match-beginning 0))
  (goto-char (point-min))
  (Lorem-ipsum-insert-sentences 1)
  (insert "\n\n")
  (Lorem-ipsum-insert-list 10)
  (insert "\n")
  (goto-char (point-min))
  (save-buffer)
  (server-edit)
  )

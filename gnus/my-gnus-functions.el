;; Remove the backlash of GMAIL folders labels thingy
(defun gnus-user-format-function-mapped (group) ()
       (let ((mapped-name (assoc group my-group-name-map)))
         (if (null mapped-name) group
           (cdr mapped-name))))

(defun gnus-user-format-function-g (arg)
  (let ((splitted
         (cdr (split-string-and-unquote gnus-tmp-group "/"))))
    (if splitted
        (gnus-user-format-function-mapped
         (combine-and-quote-strings
          (cdr (split-string-and-unquote gnus-tmp-group "/")) "."))
      (gnus-user-format-function-mapped gnus-tmp-group))))
(setq gnus-group-line-format "%M%S%p%P%5y:%B%(%ug%)\n")


(defun gnus-demon-scan-mail-or-news-and-update (level)
  "Scan for new mail, updating the *Group* buffer."
  (let ((win (current-window-configuration)))
    (unwind-protect
        (save-window-excursion
          (save-excursion
            (when (gnus-alive-p)
              (save-excursion
                (set-buffer gnus-group-buffer)
                (gnus-group-get-new-news level)))))
      (message "scanning for new mail done")
      (set-window-configuration win))))

;; Add topic-mode with custom format
(defun gnus-user-format-function-topic-line (dummy)
  (let ((topic-face
         (if (zerop total-number-of-articles) 'bold-italic 'bold)))
    (propertize
     (format "%s %d" name total-number-of-articles)
     'face topic-face)))

;; Export the unread inbox as json to plug into external command line
;; emacsclient --eval "(my-is-there-any-mail-out-there-json)"|sed -e \
;;              's/^"//;s/"$//' -e 's/\\"/"/g'|jq
(defconst my-is-there-any-mail-out-there-limit-to ".*")
(defun my-is-there-any-mail-out-there-json ()
  (interactive)
  (let ((win (current-window-configuration))
        (hashtb (make-hash-table :size 20 :test #'equal))
        unread current)
    (unwind-protect
        (save-window-excursion
          (when (gnus-alive-p)
            (with-current-buffer gnus-group-buffer
              (beginning-of-buffer)
              (while (and (not (eobp)))
                (beginning-of-line)
                (when (and
                       (get-text-property (point) 'gnus-group)
                       (string-match
                        my-is-there-any-mail-out-there-limit-to
                        (gnus-group-name-at-point)))
                  (setq unread (get-text-property (point) 'gnus-unread))
                  (when (and (numberp unread) (> unread 0))
                    (let ((gnus-tmp-group (gnus-group-name-at-point)))
                      (puthash (gnus-user-format-function-g gnus-tmp-group) unread hashtb))))
                (forward-line)))))
      (set-window-configuration win))
    (json-serialize hashtb)))

(defun my-is-there-any-mail-out-there-focus-group (group-regexp)
  (let ((win (current-window-configuration))
        found)
    (unwind-protect
        (save-window-excursion
          (save-excursion
            (when (gnus-alive-p)
              (save-excursion
                (set-buffer gnus-group-buffer)
                (goto-char (point-min))
                (when (re-search-forward group-regexp)
                  (setq found (point))
                  ))))))
    (if found (progn
                (switch-to-buffer gnus-group-buffer)
                (goto-char found)
                (gnus-group-select-group)
                (gnus-summary-first-unread-article))
      (set-window-configuration win))))

(provide 'my-gnus-functions)

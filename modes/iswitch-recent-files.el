;http://www.emacswiki.org/cgi-bin/wiki/IswitchRecentFiles

(require 'iswitchb)

(defcustom my-open-recent-file-history-sources '(file-name-history)
  "*Determines which history source `my-open-recent-file' uses.
Normal file name history uses the file name history saved by
`find-file', saved in the variable `file-name-history', Recentf
history uses `recentf-list' from recentf.el (enable recentf-mode
to use this) and Session uses `session-file-alist' from
session.el (external package)."
  :type '(set (const :tag "Normal file name history" file-name-history)
              (const :tag "Recentf history" recentf-list)
              (const :tag "Session" session))
  :group 'files)

(defun my-open-recent-file (fname)
  "Using iswitchb, interactively open recently opened file.
Configure `my-open-recent-file-history-sources' to control from
where to get the file name history."
  (interactive (list (flet ((iswitchb-make-buflist
                             (default)
                             (setq iswitchb-buflist 
                                   (my-open-recent-file-list))))
                       (iswitchb-read-buffer "Open file: "))))
  (find-file fname))

(defun my-open-recent-file-list ()
  (let (result)
    (dolist (x my-open-recent-file-history-sources result)
      (setq result (append result (symbol-value x))))
    (remove-duplicates result :test 'equal)))

;; I don't use `frame-configuration-to-register'
(global-set-key (kbd "C-x r f") 'my-open-recent-file)

(provide 'iswitch-recent-files)

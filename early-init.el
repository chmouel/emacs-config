(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

;;
;; Buffer *Messages* avec timestamp
;;
(defun my/ad-timestamp-message (FORMAT-STRING &rest args)
  "Advice to run before `message' that prepends a timestamp to each message.
Activate this advice with:
  (advice-add 'message :before 'my/ad-timestamp-message)
Deactivate this advice with:
  (advice-remove 'message 'my/ad-timestamp-message)"
  (if message-log-max
      (let ((deactivate-mark nil)
            (inhibit-read-only t))
        (with-current-buffer "*Messages*"
          (goto-char (point-max))
          (if (not (bolp))
              (newline))
          (insert (format-time-string "[%F %T.%3N] "))))))
(advice-add 'message :before 'my/ad-timestamp-message)

(defun my-short-hostname()
  (string-match "[0-9A-Za-z-]+" (system-name))
  (downcase (substring system-name (match-beginning 0) (match-end 0))))

;; Set warnings to error only
(setq log-warning-minimum-level :error)

;;
;; Frame by default
;;
(defvar init-default-font-size "14" )

(cond
 ((string= (my-short-hostname) "thebatman")
  (setq init-default-font-size "17" ))
 ((string= (my-short-hostname) "ibra")
  (setq init-default-font-size "15" )))

(setq default-frame-alist
      `((tool-bar-lines . 0)
        (menu-bar-lines . ,(if (display-graphic-p) 1 0))
	(font . ,(format "Roboto Mono Light %s" init-default-font-size))
        (width . 132)
        (height . 43)))

(setq frame-inhibit-implied-resize t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

(setq use-file-dialog nil)
(setq inhibit-splash-screen t)

(setq package-quickstart t)

(provide 'early-init)

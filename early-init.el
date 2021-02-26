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

;;
;; Frame by default
;;
(cond
 ((string= (system-name) "TheBatman.local")
  (setq init-default-font-size "17" ))
 ((string= (system-name) "ibra")
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

(setq inhibit-splash-screen t)

(provide 'early-init)
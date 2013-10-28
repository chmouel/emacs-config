(defun rcirc-detach-buffer ()
  (interactive)
  (let ((buffer (current-buffer)))
    (when (and (rcirc-buffer-process)
           (eq (process-status (rcirc-buffer-process)) 'open))
      (with-rcirc-server-buffer
        (setq rcirc-buffer-alist
              (rassq-delete-all buffer rcirc-buffer-alist)))
      (rcirc-update-short-buffer-names)
      (if (rcirc-channel-p rcirc-target)
          (rcirc-send-string (rcirc-buffer-process)
                             (concat "DETACH " rcirc-target))))
    (setq rcirc-target nil)
    (kill-buffer buffer)))

(eval-after-load 'rcirc
  '(defun-rcirc-command reconnect (arg)
     "Reconnect the server process."
     (interactive "i")
     (unless process
       (error "There's no process for this target"))
     (let* ((server (car (process-contact process)))
	    (port (process-contact process :service))
	    (nick (rcirc-nick process))
	    channels query-buffers)
       (dolist (buf (buffer-list))
	 (with-current-buffer buf
	   (when (eq process (rcirc-buffer-process))
	     (remove-hook 'change-major-mode-hook
			  'rcirc-change-major-mode-hook)
	     (if (rcirc-channel-p rcirc-target)
		 (setq channels (cons rcirc-target channels))
	       (setq query-buffers (cons buf query-buffers))))))
       (delete-process process)
       (rcirc-connect server port nick
		      rcirc-default-user-name
		      rcirc-default-full-name
		      channels))))

(define-key rcirc-mode-map [(control x) (control k)] 'rcirc-detach-buffer)

(defun my-jump-rcirc(&optional arg)
  "Jump to rcirc back and forth saving window configuration"
  (interactive "P")
  (cond (arg
         (window-configuration-to-register :rcirc))
        ((get-register :rcirc-pre)
         (progn
           (jump-to-register :rcirc-pre)
           (setq register-alist
                 (delq (assq :rcirc-pre register-alist)
                       register-alist))))
        ((get-register :rcirc)
         (progn
           (window-configuration-to-register :rcirc-pre)
           (jump-to-register :rcirc)))))
(global-set-key (read-kbd-macro "C-S-k") 'my-jump-rcirc)

; Switch to buffer on private messages.
(defun my-switch-to-buffer-on-privmsg (proc sender response target text)
  (when (and (string= response "PRIVMSG")
             (not (string= sender (rcirc-nick proc)))
             (not (rcirc-channel-p target)))
    (switch-to-buffer (rcirc-get-buffer proc target))
    (goto-char rcirc-prompt-end-marker)))

(add-hook 'rcirc-print-hooks 'my-switch-to-buffer-on-privmsg)

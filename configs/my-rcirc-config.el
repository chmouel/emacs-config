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

; Switch to buffer on private messages.
(defun my-switch-to-buffer-on-privmsg (proc sender response target text)
  (when (and (string= response "PRIVMSG")
             (not (string= sender (rcirc-nick proc)))
             (not (rcirc-channel-p target)))
    (switch-to-buffer (rcirc-get-buffer proc target))
    (goto-char rcirc-prompt-end-marker)))
(add-hook 'rcirc-print-hooks 'my-switch-to-buffer-on-privmsg)

(add-hook 'rcirc-mode-hook
          (lambda ()
            (set (make-local-variable 'scroll-conservatively)
                 8192)))

(setq rcirc-debug-flag t)
(setq rcirc-time-format "%Y-%m-%d %H:%M ")


(Package 'rcirc-alertify
  (rcirc-alertify-enable))

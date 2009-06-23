;; You can autoload, but at the end of this block we'll
;; connect to two networks anyway.
(require 'rcirc)

;; Don't print /away messages.
;; This does not require rcirc to be loaded already,
;; since rcirc doesn't define a 301 handler (yet).
(defun rcirc-handler-301 (process cmd sender args)
  "/away message handler.")

;; Turn on spell checking.
(add-hook 'rcirc-mode-hook (lambda ()
			     (flyspell-mode 1)))

;; Keep input line at bottom.                                                                               
(add-hook 'rcirc-mode-hook
	  (lambda ()
	    (set (make-local-variable 'scroll-conservatively)
		 8192)))

;; Turn on logging everything to a special buffer, for debugging.
(setq rcirc-debug-flag nil)

;; Adjust the colours of one of the faces.
(set-face-background 'rcirc-my-nick "yellow" nil)
(set-face-foreground 'rcirc-my-nick "blue" nil)

;; Include date in time stamp.
(setq rcirc-time-format "%Y-%m-%d %H:%M ")

;; Change user info
(setq rcirc-default-nick "Chmouel")
(setq rcirc-default-user-name "chmouel.boudjnah")
(setq rcirc-default-user-full-name "Chmouel Boudjnah")

;; Join these channels at startup.
(setq rcirc-startup-channels-alist
      '(("localhost$""#nast")))


;;; rcirc-auto-away.el

(defvar rcirc-auto-away-server-regexps nil
  "List of regexps to match servers for auto-away.")

(defvar rcirc-auto-away-after 3600
  "Auto-away after this many seconds.")

(defvar rcirc-auto-away-reason "idle"
  "Reason sent to server when auto-away.")

(defun rcirc-auto-away ()
  (message "rcirc-auto-away")
  (rcirc-auto-away-1 rcirc-auto-away-reason)
  (add-hook 'post-command-hook 'rcirc-auto-unaway))

(defun rcirc-auto-away-1 (reason)
  (let ((regexp (mapconcat (lambda (x) (concat "\\(" x "\\)")) 
                              rcirc-auto-away-server-regexps "\\|")))
    (dolist (process (rcirc-process-list))
      (when (string-match regexp (process-name process))
        (rcirc-send-string process (concat "AWAY :" reason))))))

(defun rcirc-auto-unaway ()
  (remove-hook 'post-command-hook 'rcirc-auto-unaway)
  (rcirc-auto-away-1 ""))

(run-with-idle-timer rcirc-auto-away-after t 'rcirc-auto-away)
;;(cancel-function-timers 'rcirc-auto-away)


(add-to-list 'iswitchb-buffer-ignore
             (lambda (name)
               (catch 'rcirc
                 (mapc (lambda (process)
                         (when (string= name (buffer-name (process-buffer process)))
                           (throw 'rcirc t))
                         (mapc (lambda (buffer)
                                 (when (string= name (buffer-name buffer))
                                   (throw 'rcirc t)))
                               (with-rcirc-process-buffer process
                                 (mapcar 'cdr rcirc-buffer-alist))))
                       (rcirc-process-list))
                 nil)))

(defun rcirc-complete-nick ()
  "Cycle through nick completions from list of nicks in channel."
  (interactive)
  (if (eq last-command this-command)
      (setq rcirc-nick-completions
            (append (cdr rcirc-nick-completions)
                    (list (car rcirc-nick-completions))))
    (setq rcirc-nick-completion-start-offset
          (- (save-excursion
               (if (re-search-backward " " rcirc-prompt-end-marker t)
                   (1+ (point))
                 rcirc-prompt-end-marker))
             rcirc-prompt-end-marker))
    (setq rcirc-nick-completions
          (let ((completion-ignore-case t))
            (all-completions
                  (buffer-substring
                         (+ rcirc-prompt-end-marker
                             rcirc-nick-completion-start-offset)
                               (point))
                       (append (rcirc-channel-nicks (rcirc-buffer-process)
                                                      rcirc-target)
                                    (rcirc-commands))))))
  (let ((completion (car rcirc-nick-completions)))
    (when completion
      (rcirc-put-nick-channel (rcirc-buffer-process) completion rcirc-target)
      (delete-region (+ rcirc-prompt-end-marker
                        rcirc-nick-completion-start-offset)
                          (point))
      (insert (concat completion
                      (if (= (+ rcirc-prompt-end-marker
                                rcirc-nick-completion-start-offset)
                             rcirc-prompt-end-marker)
                          (if (eq (aref completion 0) ?/) " " ": ")))))))

;; FIXME: This needs a drastic speedup or some caching
(defun rcirc-commands ()
  "Return a list of defined IRC commands.
If a command called rcirc-cmd-foo exists, the IRC command /FOO
will be part of the list returned."
  (let ((commands))
    (mapatoms (lambda (sym)
                (let ((name (symbol-name sym)))
                    (when (and (commandp sym)
                                    (string= (substring name 0 (min (length name) 10))
                                                   "rcirc-cmd-"))
                          (setq commands (cons (concat"/" (upcase (substring name 10)))
                                                commands))))))
    commands))

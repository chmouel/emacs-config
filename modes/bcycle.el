;;; bcycle.el --- buffer cycling with skip patterns

;; Intro
;; --------------------
;; This file is a simple alternative to next-buffer/previous-buffer.
;; It adds the ability to include patterns to match buffers to skip.

;; Usage
;; --------------------
;; Download this repository into your .emacs.d directory.
;; Include the directory in your load-path.
;; Require the package and configure it to your liking.

;; Example Code in .emacs:
;; (add-to-list 'load-path "~/.emacs.d/bcycle")
;; (require 'bcycle)
;; (setq bcycle-skip-patterns (cons "^my-new-pattern$" bcycle-skip-patterns))
;; (global-set-key (kbd "M-TAB") 'bcycle-next-buffer)
;; (global-set-key (kbd "M-`") 'bcycle-previous-buffer)

;;; Code:

(defvar bcycle-skip-patterns '("^\s*?\\*" "^\s*?%"))

(defun bcycle-matches-regexp (str regexp-list)
  "Return non-nil if str matches anything in regexp-list."
  (let ((case-fold-search nil))
    (catch 'done
      (dolist (regexp regexp-list)
        (when (string-match regexp str)
          (throw 'done t))))))

(defun bcycle-next-buffer ()
  "Goes to the next buffer that doesn't match any exclusion patterns."
  (interactive)
  (let ((curr-bname (buffer-name (current-buffer))))
    (next-buffer)
    (while (and
            (bcycle-matches-regexp (buffer-name (current-buffer)) bcycle-skip-patterns)
            (not (equal curr-bname (buffer-name (current-buffer)))))
      (next-buffer))))

(defun bcycle-previous-buffer ()
  "Goes to the previous buffer that doesn't match any exclusion patterns."
  (interactive)
  (let ((curr-bname (buffer-name (current-buffer))))
    (previous-buffer)
    (while (and
            (bcycle-matches-regexp (buffer-name (current-buffer)) bcycle-skip-patterns)
            (not (equal curr-bname (buffer-name (current-buffer)))))
      (previous-buffer))))

(provide 'bcycle)

;;; bcycle ends here

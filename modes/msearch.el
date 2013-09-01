;;; msearch.el --- Highlight all occurences of mouse selection

;; Copyright (C) 2010  Tobias.Naehring

;; Author: Tobias.Naehring <i@tn-home.de>

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Keywords: mouse search selection (highlight occurences of mouse selection)

;;; Commentary:

;; After activating the minor mode "msearch-mode" mouse-dragging over
;; some text highlightes all matches of this text in the current
;; buffer. Msearch-mode can be (de)activated by (un)checking msearch
;; in the minor-mode menu of the mode line.
;;
;; Installation:
;; Put msearch.el into your load-path and add the following line into
;; your emacs start-up file (e.g. "~/.emacs"):
;; (require 'msearch.el)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Changes:
;;
;; 2010-06-22, 18:45, TN:
;;
;; Error: Infinite recursion of msearch-event-handler at re-activation
;; of msearch-mode.
;;
;; Fix: Reset event handler by (local-unset-key (kbd
;; "<drag-mouse-1>")) rather than by (local-set-key (kbd ...)
;; msearch-next-event-handler).
;;
;; 2010-06-23, 23:00, TN:
;;
;; Error: msearch-event-handler didn't call msearch-next-handler. Thus
;; mouse-set-region was not called.
;;
;; Fix: Return value 't of (msearch-next-handler-ok).
;;
;; Feature: User can remove all highlights by dragging a region of zero length.
;;
;; Implementation: Allow msearch-word of zero length.
;;
;; 2010-06-24, 22:00, TN + SCZ:
;;
;; local-set-key is not buffer-local but major-mode local. Thus msearch-event-handler has been activated in all buffers with the same major-mode but local variables were missing.
;;
;; Fix: Introduced new mouse event handler for <drag-mouse-1>.
;;
;; 2010-07-25, 22:00, TN:
;;
;; Added msearch-enslave-buffer.
;;
;; 2010-07-26, 22:00, TN:
;;
;; Added minor-mode-menu.
;;
;; 2010-07-27, 18:40, TN:
;;
;; Better menu and defaults for msearch-enslave-buffer and
;; msearch-release-buffer.
;;
;; 2010-08-19, 0:0, TN:
;; Added menu button for explicitely setting msearch-word.
;;
;; 2011-03-10, 16:15, TN:
;; Added custom-variable msearch-max-length and avoid crash through
;; too long msearch words.
;;
;; 2013-08-22, TN:
;; Freezing of highlights, swtich on msearch for the window with event posn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:

(defcustom msearch-face 'msearch-level-1 ;; was '(background-color . "yellow")
  "Face for highlighting matchings of mouse-selected text. See also msearch-mode."
  :type 'custom-face
  :group 'msearch)

(defcustom msearch-max-length 1000
  "Maximal length of search string."
  :type 'integer
  :group 'msearch)

(defvar msearch-face-idx 0)
(defvar msearch-word nil
  "Current word to be highlighted by msearch (yit).")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;

(defface msearch-level-1 ;; originally copied from font-lock-function-name-face
  '((((class color) (min-colors 88) (background light)) (:foreground "Blue1" :background "Yellow"))
    (((class color) (min-colors 88) (background dark)) (:foreground "LightSkyBlue" :background "Yellow"))
    (((class color) (min-colors 16) (background light)) (:foreground "Blue" :background "Yellow"))
    (((class color) (min-colors 16) (background dark)) (:foreground "LightSkyBlue" :background "Yellow"))
    (((class color) (min-colors 8)) (:foreground "blue" :bold t))
    (t (:bold t)))
  "Face used for level 1 headlines."
  :group 'msearch-faces)

(defface msearch-level-2 ;; originally copied from font-lock-variable-name-face
    '((((class color) (min-colors 16) (background light)) (:foreground "DarkGoldenrod" :background "Yellow"))
      (((class color) (min-colors 16) (background dark))  (:foreground "LightGoldenrod" :background "Yellow"))
      (((class color) (min-colors 8)  (background light)) (:foreground "yellow" :background "Yellow"))
      (((class color) (min-colors 8)  (background dark))  (:foreground "yellow" :bold t))
      (t (:bold t)))
  "Face used for level 2 headlines."
  :group 'msearch-faces)

(defface msearch-level-3 ;; originally copied from font-lock-keyword-face
    '((((class color) (min-colors 88) (background light)) (:foreground "Purple" :background "Yellow"))
      (((class color) (min-colors 88) (background dark))  (:foreground "Cyan1" :background "Yellow"))
      (((class color) (min-colors 16) (background light)) (:foreground "Purple" :background "Yellow"))
      (((class color) (min-colors 16) (background dark))  (:foreground "Cyan" :background "Yellow"))
      (((class color) (min-colors 8)  (background light)) (:foreground "purple" :bold t))
      (((class color) (min-colors 8)  (background dark))  (:foreground "cyan" :bold t))
      (t (:bold t)))
  "Face used for level 3 headlines."
  :group 'msearch-faces)

(defface msearch-level-4   ;; originally copied from font-lock-comment-face
    '((((class color) (min-colors 88) (background light)) (:foreground "Firebrick" :background "Yellow"))
      (((class color) (min-colors 88) (background dark))  (:foreground "chocolate1" :background "Yellow"))
      (((class color) (min-colors 16) (background light)) (:foreground "red" :background "Yellow"))
      (((class color) (min-colors 16) (background dark))  (:foreground "red1" :background "Yellow"))
      (((class color) (min-colors 8) (background light))  (:foreground "red" :bold t))
      (((class color) (min-colors 8) (background dark))   (:foreground "red" :bold t))
      (t (:bold t)))
  "Face used for level 4 headlines."
  :group 'msearch-faces)

(defface msearch-level-5 ;; originally copied from font-lock-type-face
    '((((class color) (min-colors 16) (background light)) (:foreground "ForestGreen" :background "Yellow"))
      (((class color) (min-colors 16) (background dark)) (:foreground "PaleGreen" :background "Yellow"))
      (((class color) (min-colors 8)) (:foreground "green"))
      (t (:bold t)))
  "Face used for level 5 headlines."
  :group 'msearch-faces)

(defface msearch-level-6 ;; originally copied from font-lock-constant-face
    '((((class color) (min-colors 16) (background light)) (:foreground "CadetBlue" :background "Yellow"))
      (((class color) (min-colors 16) (background dark)) (:foreground "Aquamarine" :background "Yellow"))
      (((class color) (min-colors 8)) (:foreground "magenta"))
      (t (:bold t)))
  "Face used for level 6 headlines."
  :group 'msearch-faces)

(defface msearch-level-7 ;; originally copied from font-lock-builtin-face
    '((((class color) (min-colors 16) (background light)) (:foreground "Orchid" :background "Yellow"))
      (((class color) (min-colors 16) (background dark)) (:foreground "LightSteelBlue" :background "Yellow"))
      (((class color) (min-colors 8)) (:foreground "blue"))
      (t (:bold t)))
  "Face used for level 7 headlines."
  :group 'msearch-faces)

(defface msearch-level-8 ;; originally copied from font-lock-string-face
    '((((class color) (min-colors 16) (background light)) (:foreground "RosyBrown" :background "Yellow"))
      (((class color) (min-colors 16) (background dark)) (:foreground "LightSalmon" :background "Yellow"))
      (((class color) (min-colors 8)) (:foreground "green"))
      (t (:bold t)))
  "Face used for level 8 headlines."
  :group 'msearch-faces)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defcustom msearch-faces
  (eval-when-compile (nreverse
		      (loop for f in (face-list) if (string-match "msearch-level-" (symbol-name f)) collect f)))
  "Face for highlighting matchings of mouse-selected text. See also msearch-mode."
  :type 'list
  :group 'msearch)

(eval-when-compile
  (defvar msearch-word) ;; word or list of cons (word . face) to be highlighted
  (defvar msearch-old-word)
  (defvar msearch-slaves)
  (defvar msearch-mode-menu-bar-map))

(defun msearch-lock-word (b e word face)
  "Highlight all matches of mouse-selection within the visible region."
  (when (and (stringp word) (> (length word) 0))
    (setq face (if (facep face) face msearch-face))
    (save-excursion
      (goto-char b)
      (while (search-forward word e 'noError)
	(unless (get-char-property (match-beginning 0) 'msearch)
	  (let ((ov (make-overlay (match-beginning 0) (match-end 0))))
	    (overlay-put ov 'face face)
	    (overlay-put ov 'msearch 't)))
	))))

(defun msearch-lock-function (b e)
  "Highlight all matches of mouse-selection within the visible region."
  (remove-overlays b e 'msearch 't) ;; remove old highlighting
  (cond
   ((stringp msearch-word)
    (msearch-lock-word b e msearch-word msearch-face))
   ((listp msearch-word)
    (loop for wordFace in msearch-word do
	 (msearch-lock-word b e (car wordFace) (cdr wordFace))))))

(defun msearch-cleanup (&optional all)
  "Remove overlays of msearch and deactivate msearch-lock-function."
  (interactive)
  (setq msearch-old-word nil)
  (if all
      (progn
	(setq msearch-word nil)
	(remove-overlays nil nil 'msearch 't)
	(jit-lock-unregister 'msearch-lock-function)
	)
    (setq msearch-word (cdr-safe msearch-word))
    (jit-lock-refontify)
    ))

(defun msearch-cleanup-all ()
  "Calls msearch-cleanup with ALL=t"
  (interactive)
  (msearch-cleanup 't))

(defun msearch-freeze ()
  "Freeze current highlighting of msearch-expressions and choose
the next face from msearch-faces for next highlighting."
  (interactive)
  (setq msearch-face-idx (mod (1+ msearch-face-idx) (length msearch-faces)))
  (setq msearch-face (nth msearch-face-idx msearch-faces))
  (setq msearch-word (cons (cons "" msearch-face) msearch-word)))

(defvar drag-mouse-1-handler-list (list (key-binding (kbd "<drag-mouse-1>")))
  "List of event handlers for <drag-mouse-1> events.
Don't set this directly. Use the function
register-drag-mouse-1-handler instead.")
(make-variable-buffer-local 'drag-mouse-1-handler-list)

(defun drag-mouse-1-handler (e)
  "Generic handler for <drag-mouse-1> events."
  (interactive "e")
  (let ((n drag-mouse-1-handler-list))
    (while n
      (apply (car n) (list e))
      (setq n (cdr n)))))

(global-set-key (kbd "<drag-mouse-1>") 'drag-mouse-1-handler)

(defun msearch-set-word (word)
  "Set word to be highlighted."
  (interactive "sSet msearch word:")
  (if (and (listp msearch-word) (> (length msearch-word) 0))
      (setcar msearch-word (cons word msearch-face))
    (setq msearch-word (list (cons word msearch-face))))
  (unless (equal msearch-old-word (if (stringp msearch-word) msearch-word (car-safe msearch-word)))
    (setq msearch-old-word msearch-word)
    (jit-lock-register 'msearch-lock-function)))

(defun msearch-event-handler (e)
  "Must be bound to a mouse event."
  (interactive "e")
  (let ((start (posn-point (event-start e)))
	(end (posn-point (event-end e))))
    (if (> start end)
	(let ((tmp start)) (setq start end) (setq end tmp)))
    (if (> (- end start) msearch-max-length)
	(setq end (+ start msearch-max-length)))
    (let ((new-word (buffer-substring-no-properties start end))
	  (slaves msearch-slaves)
	  slaves-released
	  (curbuf (current-buffer)))
      (msearch-set-word new-word)
      (save-excursion
	(while slaves
	  (if (get-buffer (car slaves))
	      (progn
		(set-buffer (car slaves))
		(if msearch-mode
		    (msearch-set-word new-word))))
	  (setq slaves (cdr slaves))
	  )))))

(defun internal-buffer-p (buf-or-name)
  (let (buf bufname)
    (or
     (null (setq buf (get-buffer buf-or-name)))
     (null (setq bufname (buffer-name buf)))
     (and (string= (substring bufname 0 1) " ") (null (buffer-file-name buf)))
     )))

(defun user-buffer-list ()
  (let* ((p (buffer-list (selected-frame)))
	 buflist)
    (while p
      (unless (internal-buffer-p (car p))
	(add-to-list 'buflist (car p) 'append))
	(setq p (cdr p)))
    buflist))

(defun msearch-enslave-buffer (buf)
  "Let the current buffer be the master of buf.
Msearch-strings of the current buffer are also high-lighted in buf.
The slave buf is released when msearch of the master is switched off."
  (interactive
   (list (let ((buflist (mapcar 'buffer-name (cdr (user-buffer-list)))))
	   (completing-read (concat "Enslave buffer (default:" (car buflist) "):" ) buflist nil 'require-match nil nil (car buflist)))))
  ;; Make sure that the current buffer is in msearch mode:
  (if (null msearch-mode)
      (msearch-mode))
  ;; Make sure that the slave is in msearch mode:
  (unless (string-equal (buffer-name) buf)
    (with-current-buffer buf
      (if (null msearch-mode)
	  (msearch-mode)))
    (add-to-list 'msearch-slaves buf)))

(defun msearch-release-buffer (buf)
  "Release slave buf."
  (interactive (list (completing-read (concat "Slave to be released (default:" (car msearch-slaves) "):") msearch-slaves nil 'require-match nil nil (car msearch-slaves))))
  (setq msearch-slaves (remove buf msearch-slaves)))

(defun msearch-release-all ()
  "Release all slaves."
  (interactive)
  (setq msearch-slaves nil))

(defun msearch-help ()
  "Give help on msearch mode."
  (interactive)
  (describe-function 'msearch-mode))

(defvar msearch-mode-map (make-sparse-keymap)
  "Menu for msearch mode.")

(easy-menu-define msearch-mode-menu msearch-mode-map
  "Menu for msearch mode."
  '("MSearch"
    ["Switch Off msearch" msearch-mode 't]
    ("Unhighlight" ["Current" msearch-cleanup 't]
		     ["All" msearch-cleanup-all 't])
    ["Freeze Highlights" msearch-freeze 't]
    ["Help On msearch" msearch-help 't]
    ["Enslave Buffer" msearch-enslave-buffer 't]
    ["Release Buffer" msearch-release-buffer 't]
    ["Release All Buffers" msearch-release-all 't]
    ["Set msearch word" msearch-set-word 't]
    ))

(define-minor-mode msearch-mode
  "Mouse-drag high-lightes all corresponding matches within the current buffer."
  :lighter " msearch"
  :keymap (list (cons [menu-bar] msearch-mode-menu-bar-map))
  (if msearch-mode
      (progn
	(set (make-local-variable 'msearch-word) nil)
	(set (make-local-variable 'msearch-old-word) "")
	(set (make-local-variable 'msearch-slaves) nil)
	(add-to-list 'drag-mouse-1-handler-list 'msearch-event-handler))
    (msearch-cleanup)
    (kill-local-variable 'msearch-word)
    (kill-local-variable 'msearch-old-word)
    (kill-local-variable 'msearch-slaves)
    (setq drag-mouse-1-handler-list
	  (delete 'msearch-event-handler drag-mouse-1-handler-list))
    ))

(defun msearch-mode-event (event)
  "Toggle msearch mode."
  (interactive "e")
  (save-selected-window
    (select-window (posn-window (event-start event)))
    (msearch-mode)
    ))

(define-key mode-line-mode-menu [msearch-mode]
  `(menu-item ,(purecopy "msearch") msearch-mode-event
	      :help ,(purecopy "MSearch mode: Mouse-drag high-lightes all corresponding matches within the current buffer.")
	      :button (:toggle . msearch-mode)))

(provide 'msearch)
;;; msearch.el ends here

; Stoled adapted
;; change faces for better-looking tabs (and more obvious selected tab!)
;; full face specification to avoid inheriting from the frame font
;; or from mode-line
(Package 'tabbar)
(require 'tabbar)
(set-face-attribute 'tabbar-default nil
		    :inherit nil
		    :height 110
		    :weight 'normal
		    :width 'normal
		    :slant 'normal
		    :underline nil
		    :strike-through nil
;; inherit from frame		    :inverse-video
		    :stipple nil
		    :background "grey"
		    :foreground "black"
;		    :box '(:line-width 2 :color "white" :style nil)
		    :box nil
		    :family "Lucida Grande")

(set-face-attribute 'tabbar-selected nil
		    :background "gray95"
		    :foreground "gray20"
		    :inherit 'tabbar-default
		    :box '(:line-width 3 :color "grey95" :style nil))
;; 		    :box '(:line-width 2 :color "white" :style released-button))

(set-face-attribute 'tabbar-unselected nil
		    :inherit 'tabbar-default
		    :background "gray69"
		    :box '(:line-width 3 :color "grey80" :style nil))

(defface tabbar-selected-highlight '((t
                                      :foreground "black"
                                      :background "gray95"))
  "Face for selected, highlighted tabs."
  :group 'tabbar)

(defface tabbar-unselected-highlight '((t
                                        :foreground "black"
                                        :background "grey75"
                                        :box (:line-width 3 :color "grey75" :style nil)))
  "Face for unselected, highlighted tabs."
  :group 'tabbar)

(set-face-attribute 'tabbar-button nil
		    :inherit 'tabbar-default
		    :box nil)

(set-face-attribute 'tabbar-separator nil
		    :background "grey50"
 		    :foreground "grey50"
		    :height 1.0)

(setq tabbar-separator '(1)) ;; set tabbar-separator size to 1 pixel

(defface tabbar-selected-modified
  '((t
     :inherit tabbar-selected
     :weight bold
     :height 110
     ))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-unselected-modified
  '((t
     :inherit tabbar-unselected
     :weight bold
     :height 110
     ))
  "Face used for unselected tabs."
  :group 'tabbar)

(defface tabbar-key-binding '((t
				 :foreground "white"))
    "Face for unselected, highlighted tabs."
    :group 'tabbar)

(defun tabbar-define-access-keys (&optional modifiers keys)
  "Set tab access keys for `tabbar-mode'.
MODIFIERS as in `tabbar-key-binding-modifier-list', and
KEYS defines the elements to use for `tabbar-key-binding-keys'."
  (if modifiers (setq tabbar-key-binding-modifier-list modifiers))
  (if keys (setq tabbar-key-binding-keys keys))
  (loop for keys in tabbar-key-binding-keys
	for ni from 1 to 10 do
	(let ((name (tabbar-key-command ni)))
	  (eval `(defun ,name ()
		   "Select tab in selected window."
		   (interactive)
		   (tabbar-select-tab-by-index ,(- ni 1))))
	  ;; store label in property of command name symbol
	  (put name 'label
	       (format "%c" (car keys)))
	  (loop for key in keys do
		(define-key tabbar-mode-map
		  (vector (append
			   tabbar-key-binding-modifier-list
			   (list key)))
		  name)))))

(defvar tabbar-key-binding-keys '((49 kp-1) (50 kp-2) (51 kp-3) (52 kp-4) (53 kp-5) (54 kp-6) (55 kp-7) (56 kp-8) (57 kp-9) (48 kp-0))
  "Codes of ten keys bound to tabs (without modifiers.
This is a list with 10 elements, one for each of the first 10
tabs.  Each element is a list of keys, either of which can be
used in conjunction with the modifiers defined in
`tabbar-key-binding-modifier-list'. Must call
`tabbar-define-access-keys' or toggle `tabbar-mode' for changes
to this variable to take effect.")

(defsubst tabbar-key-command (index)	; command name
  (intern (format "tabbar-select-tab-%s" index)))

(defvar tabbar-key-binding-modifier-list '(super)
  "List of modifiers to be used for keys bound to tabs.
Must call `tabbar-define-access-keys' or toggle `tabbar-mode' for
changes to this variable to take effect.")

(defun tabbar-select-tab-by-index (index)
  ;; (let ((vis-index (+ index (or (get (tabbar-current-tabset) 'start) 0))))
  (unless (> (length (tabbar-tabs (tabbar-current-tabset))) 1)
    ;; better window (with tabs)in this frame?

    (let ((better-w))
      (walk-windows (lambda (w)
		      (and (not better-w)
			   (with-selected-window w
			     (if (> (length (tabbar-tabs (tabbar-current-tabset t))) 1)
				 (setq better-w w)))))
		    'avoid-minibuf (selected-frame))
      (if better-w (select-window better-w))))

  (tabbar-window-select-a-tab
   (nth index (tabbar-tabs (tabbar-current-tabset)))))

(defun tabbar-window-select-a-tab (tab)
  "Select TAB"
  (let ((one-buffer-one-frame nil)
	(buffer (tabbar-tab-value tab)))
    (when buffer

      (set-window-dedicated-p (selected-window) nil)
      (let ((prevtab (tabbar-get-tab (window-buffer (selected-window))
				     (tabbar-tab-tabset tab)))
	    (marker (cond ((bobp) (point-min-marker))
				((eobp) (point-max-marker))
				(t (point-marker)))))
	(set-marker-insertion-type marker t)
	(assq-set prevtab marker
		  'tab-points))
      (switch-to-buffer buffer)
      (let ((new-pt (cdr (assq tab tab-points))))
	(and new-pt
	     (eq (marker-buffer new-pt) (window-buffer (selected-window)))
	     (let ((pos (marker-position new-pt)))
	       (unless (eq pos (point))
		 (if transient-mark-mode
		     (deactivate-mark))
		 (goto-char pos))
	       (set-marker new-pt nil) ;; delete marker
	       ))))))

(defun assq-set (key val alist)
  "Sets value associated with KEY to VAL in ALIST.
ALIST must be a symbol giving the variable name.
Comparison of keys is done with `eq'.
New key-value pair will be in car of ALIST."
  (set alist (cons (cons key val)
		   (assq-delete-all key (eval alist)))))


(defvar tab-points nil)

(custom-set-variables
 '(tabbar-buffer-home-button (quote (("") "")))
 '(tabbar-home-button (quote (("") "")))
 '(tabbar-scroll-left-button (quote ((" <") " ")))
 '(tabbar-scroll-right-button (quote ((" ") "")))
 ;;'(tabbar-separator 0.1)
 ;; '(tabbar-default ((t (:inherit nil :stipple nil :background "grey" :foreground "black" :box nil :strike-through nil :underline nil :slant normal :weight normal :height 110 :width normal :family "Lucida Grande"))))
 )

(setq tabbar-separator (list 0.2))

(defun tabbar-new-tab (&optional mode)
  "Creates a new tab, containing an empty buffer (with major-mode MODE
if specified), in current window."
  (interactive)
  (let ((one-buffer-one-frame nil))
    (new-empty-buffer nil mode)))

(defun new-tab (&optional major-mode)
  "Creates a new tab.
Turns on `tabbar-mode'."
  (interactive)
  (tabbar-mode 1)
  (tabbar-new-tab major-mode))

(setq aquamacs-default-major-mode nil)

(defun get-window-for-other-buffer (&optional dont-make-frame buffer)
  "Find a suitable window for other buffers.
Preferably the selected one.
If a frame is created for the other buffer,
show BUFFER in that frame."
  (let ((sel-win (selected-window))) ; search all visible&iconified frames
    (unless
	(and sel-win
	     (window-live-p sel-win)
	     (eq t (frame-visible-p (window-frame sel-win)))
	     (not (special-display-p
		   (or (buffer-name (window-buffer sel-win)) ""))))
      ;; search visible frames (but not dedicated ones)
      (setq sel-win (get-largest-window 'visible nil)))
    (unless
	(and sel-win
	     (window-live-p sel-win)
	     (eq t (frame-visible-p (window-frame sel-win)))
	     (not (special-display-p
		   (or (buffer-name (window-buffer sel-win)) ""))))
      (unless dont-make-frame
	  (setq sel-win (frame-first-window
			 (with-current-buffer (or buffer (current-buffer))
			   ;; make sure we're not creating some "special" frame
			   (make-frame))))))
    (if sel-win
	(unless (eq t (frame-visible-p (window-frame sel-win)))
	  (make-frame-visible (window-frame sel-win))))
    sel-win))

(defun new-empty-buffer  (&optional other-frame mode)
  "Visits an empty buffer.
The major mode is set to MODE, or, if that is nil,
the value of `aquamacs-default-major-mode'."
  (interactive)
  (let ((buf (generate-new-buffer (mac-new-buffer-name "untitled"))))
    ;; setting mode is done before showing the new frame
    ;; because otherwise, we get a nasty animation effect
    (save-excursion
      (set-buffer buf)
      (funcall (or mode aquamacs-default-major-mode (default-value 'major-mode) 'ignore)))
    (if other-frame
        (switch-to-buffer-other-frame buf)
      (let ((one-buffer-one-frame-force nil))
	;; change window in case its unsuitable (dedicated or special display)
	(select-window (get-window-for-other-buffer))
	;; force new frame
	(switch-to-buffer buf)
	(select-frame-set-input-focus (window-frame (selected-window)))))
    (setq buffer-offer-save t)
    (put 'buffer-offer-save 'permanent-local t)
    (set-buffer-modified-p nil)))

(defun mac-new-buffer-name (name &optional n)

  (if (not (get-buffer name))
      name
    (setq n (if n (+ n 1) 2))
    (let ((new-name (concat name " " (int-to-string n))))
      (if (not (get-buffer new-name))
	  new-name
	(mac-new-buffer-name name n)
	))
    )
  )

(global-set-key (read-kbd-macro "s-t") 'tabbar-new-tab)
(global-set-key (read-kbd-macro "s-w") (lambda () (interactive) (kill-buffer nil)))
(global-set-key (read-kbd-macro "s-]") 'tabbar-forward)
(global-set-key (read-kbd-macro "s-[") 'tabbar-backward)

(provide 'my-tabbar)

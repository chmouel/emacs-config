;; FSET
(fset 'yes-or-no-p 'y-or-n-p)

;KeyBinding
(global-set-key '[(control meta l)] (lambda () (interactive) (switch-to-buffer (other-buffer))))
(global-set-key '[(control next)] 'end-of-buffer)
(global-set-key '[(control prior)] 'beginning-of-buffer)
(global-set-key '[(control tab)] 'other-window)
(global-set-key '[(control c)(\])] 'next-error)
(global-set-key '[(control c)(\[)] 'previous-error)
(global-set-key (read-kbd-macro "C-x C-=") 'ediff-buffers)
(global-set-key (read-kbd-macro "C-x C-k") 'kill-current-buffer)
(global-set-key (read-kbd-macro "C-x f") 'find-file-at-point)
(global-set-key (read-kbd-macro "M-q") 'fill-region)
(global-set-key (read-kbd-macro "M-l") 'downcase-word)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)

(global-set-key (read-kbd-macro "C-x <left>") 'indent-rigidly-left)
(global-set-key (read-kbd-macro "C-x <right>") 'indent-rigidly-right)

;; No need digits
(global-set-key (read-kbd-macro "C-2")      'split-window-vertically)

;; Redefine {for/back}ward paragraphs to just 4 lines
(global-set-key '[(control down)] (lambda ()
                                    (interactive)
                                    (ignore-errors (next-logical-line 5))))

(global-set-key '[(control up)] (lambda ()
                                    (interactive)
                                    (ignore-errors (previous-logical-line 5))))

;; C-up/down onn console
(when (not window-system)
  (define-key function-key-map "\eO1;5A"    [C-up])
  (define-key function-key-map "\eO1;5B"  [C-down])
  (define-key function-key-map "\eO1;5C" [C-right])
  (define-key function-key-map "\eO1;5D"  [C-left])
  )

;; Mouse
(global-set-key (read-kbd-macro "<mouse-3>") 'mouse-popup-menubar-stuff)

;; Windmove
(windmove-default-keybindings)

;; Unset
(global-unset-key "\C-x\C-z")

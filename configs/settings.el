;FSET
(fset 'yes-or-no-p 'y-or-n-p)
(fset 'man 'woman)

;Custome customize (lol)
(setq custom-file (concat my-init-directory "/configs/customed.el"))
(load custom-file)

;KeyBinding
(global-set-key '[(control meta l)]         (lambda () (interactive) (switch-to-buffer (other-buffer))))
(global-set-key '[(control next)]           'end-of-buffer)
(global-set-key '[(control prior)]          'beginning-of-buffer)
(global-set-key '[(control tab)]            'other-window)
(global-set-key '[(control meta tab)]           'other-frame)
(global-set-key '[(control x)(control =)]   'ediff-buffers)
(global-set-key '[(control x)(-)] 'next-error)
(global-set-key (read-kbd-macro "C-M-b")    'bookmark-jump)
(global-set-key (read-kbd-macro "C-M-g") 'grep)
(global-set-key (read-kbd-macro "C-x C-k") (lambda () (interactive) (kill-buffer nil)))
(global-set-key (read-kbd-macro "C-x f") 'find-file-at-point)
(global-set-key (read-kbd-macro "C-M-/") 'dabbrev-expand)
(global-set-key (read-kbd-macro "M-/") 'hippie-expand)
(global-set-key (read-kbd-macro "M-q") 'fill-region)
(global-set-key (read-kbd-macro "C-;") 'comment-dwim)

;;Prefer BS style cycling (not used)
(global-set-key '[(control x)(left)]        'previous-buffer)
(global-set-key '[(control x)(right)]       'next-buffer)

;;No need digits
(global-set-key (read-kbd-macro "C-1")      'delete-other-windows)
(global-set-key (read-kbd-macro "C-2")      'split-window-vertically)


;;Redefine {for/back}ward paragraphs to just 4 lines
(global-set-key '[(control down)](lambda () (interactive) (forward-line '5)))
(global-set-key '[(control up)](lambda () (interactive) (previous-line '5)))

;C-up/down onn console
(when (not window-system)
  (define-key function-key-map "\eO1;5A"    [C-up])
  (define-key function-key-map "\eO1;5B"  [C-down])
  (define-key function-key-map "\eO1;5C" [C-right])
  (define-key function-key-map "\eO1;5D"  [C-left])
  )

;Mouse
(global-set-key (read-kbd-macro "<mouse-3>") 'mouse-popup-menubar-stuff)
(Win
 (global-set-key (read-kbd-macro "<mouse-4>") 'bs-cycle-previous)
 (global-set-key (read-kbd-macro "<mouse-5>") 'bs-cycle-next))

;Windmove
(windmove-default-keybindings)

;Unset
(global-unset-key "\C-x\C-z")

;Env for svn and stuff
(Win (setenv "SVN_SSH" "c:/soft/putty/plink.exe -batch"))

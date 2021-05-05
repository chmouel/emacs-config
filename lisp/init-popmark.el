;; Probably should be a package from https://stackoverflow.com/questions/3393834/how-to-move-forward-and-backward-in-emacs-mark-ring

(use-package emacs
  :bind
  ("M-<left>" . backward-global-mark)
  ("M-<right>" . forward-global-mark)
  ("<mouse-9>" . forward-global-mark)
  ("<mouse-8>" . backward-global-mark)
  :init
  (defun marker-is-point-p (marker)
    "test if marker is current point"
    (and (eq (marker-buffer marker) (current-buffer))
         (= (marker-position marker) (point))))

  (defun push-mark-maybe ()
    "push mark onto `global-mark-ring' if mark head or tail is not current location"
    (if (not global-mark-ring) (error "global-mark-ring empty")
      (unless (or (marker-is-point-p (car global-mark-ring))
                  (marker-is-point-p (car (reverse global-mark-ring))))
        (push-mark))))


  (defun backward-global-mark ()
    "use `pop-global-mark', pushing current point if not on ring."
    (interactive)
    (push-mark-maybe)
    (when (marker-is-point-p (car global-mark-ring))
      (call-interactively 'pop-global-mark))
    (call-interactively 'pop-global-mark))

  (defun forward-global-mark ()
    "hack `pop-global-mark' to go in reverse, pushing current point if not on ring."
    (interactive)
    (push-mark-maybe)
    (setq global-mark-ring (nreverse global-mark-ring))
    (when (marker-is-point-p (car global-mark-ring))
      (call-interactively 'pop-global-mark))
    (call-interactively 'pop-global-mark)
    (setq global-mark-ring (nreverse global-mark-ring))))

(provide 'init-popmark)

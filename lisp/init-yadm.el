;; from https://www.reddit.com/r/emacs/comments/gjukb3/yadm_magit/
(defun yadm--files ()
  (let ((default-directory "~/"))
    (cl-delete-if-not
     #'file-exists-p
     (process-lines "yadm" "ls-tree" "--full-tree" "-r" "--name-only" "HEAD"))))

(defun yadm-find-file ()
  (interactive)
  (let ((default-directory  "~/"))
    (find-file
     (completing-read "Yadm file: " (yadm--files)))))

(defun yadm-dired ()
  (interactive)
  (let ((default-directory "~/"))
    (with-current-buffer (dired `("*yadm*" ,@(yadm--files)))
      (setq-local revert-buffer-function
                  (lambda (&rest args)
                    (setq dired-directory
                          (cons (car dired-directory)
                                (yadm--files)))
                    (apply #'dired-revert args))))))

(define-minor-mode yadm-minor-mode
  "A minor mode for magit yadm buffers."
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-x d") 'yadm-dired)
            (define-key map (kbd "C-x C-f") 'yadm-find-file)
            (define-key map "s" 'yadm-stage)
            map))

(defun yadm-status ()
  (interactive)
  (require 'tramp)
  (with-current-buffer (magit-status "/yadm::")
    (yadm-minor-mode 1)))

(with-eval-after-load 'tramp
  (add-to-list 'tramp-methods
               '("yadm"
                 (tramp-login-program "yadm")
                 (tramp-login-args (("enter")))
                 (tramp-remote-shell "/bin/bash")
                 (tramp-remote-shell-args ("-c"))))
  (defun yadm-stage ()
    (interactive)
    (let ((file
           (let ((default-directory "~/"))
             (read-file-name "Stage file: "))))
      (if (equal (expand-file-name file)
                 (expand-file-name "~/.local/share/yadm/"))
          (user-error "Can't stage yadm dir itself.")
        (magit-with-toplevel
          (magit-stage-1 nil (list file)))))))

(provide 'yadm-status)

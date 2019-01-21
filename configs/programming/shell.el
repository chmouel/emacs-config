(defvar shfmt-command "shfmt")
(reformatter-define shell-formatter
  :program shfmt-command
  :lighter 'SHFmt)

(defun my-sh-mode-hook()
  (shell-formatter-on-save-mode)
  (set (make-local-variable 'my-compile-command) (concat "bash -n \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat "bash \"" buffer-file-name "\""))
  (my-programming-common-hook))
(add-hook 'sh-mode-hook 'my-sh-mode-hook)

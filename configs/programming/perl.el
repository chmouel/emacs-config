(defun my-cperl-mode-hook()
  (which-func-mode 't)
  (flymake-mode 't)
  )
(add-hook 'cperl-mode-hook 'my-cperl-mode-hook)
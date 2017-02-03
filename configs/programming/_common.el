(Package 'highlight-numbers)

(defun my-programming-common-hook()
  (highlight-numbers-mode 1)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-set-key (kbd "C-C C-l") 'github-browse-file)
  (local-set-key '[(meta return)] 'compile)
  (local-set-key '[(control meta return)] (lambda () (interactive) (compile my-compile-command)))
  (local-set-key '[(control return)] (lambda () (interactive) (compile my-compile-run-command))))

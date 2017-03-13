(Package 'highlight-numbers)

(autoload 'toggle-quotes "toggle-quotes")

(defun my-programming-common-hook()
  (highlight-numbers-mode 1)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-set-key (kbd "C-C C-l") 'github-browse-file)
  (local-set-key (kbd "C-'") 'toggle-quotes)
  (local-set-key '[(meta return)] 'compile)

  (if (fboundp 'my-compile-command)
      (local-set-key '[(control meta return)] (lambda () (interactive) (compile my-compile-command))))
  (if (fboundp 'my-compile-run-command)
      (local-set-key '[(control return)] (lambda () (interactive) (compile my-compile-run-command)))))

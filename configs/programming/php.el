(use-package php-mode :ensure t)

(setq auto-mode-alist (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.inc\\'" . php-mode) auto-mode-alist))

(defun my-php-mode-hook ()
  (set (make-local-variable 'my-compile-command) (concat "php -l \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat "php \"" buffer-file-name "\""))

  (c-set-style "awk")
  (c-toggle-auto-newline 1)

  (my-programming-common-hook)

  (local-set-key '[(tab)] 'indent-for-tab-command)
  (local-set-key '[(control c)(control v)] 'browse-url-of-buffer)
  (local-set-key '[(control shift n)] (lambda () (interactive) (progn (insert "\\n"))))
  (local-set-key '[(control shift p)] (lambda () (interactive) (progn (insert "<?=  ?>")(backward-char 3))))
  (local-set-key '[(f12)] 'html-inlined-narrow))

(add-hook 'php-mode-hook 'my-php-mode-hook)

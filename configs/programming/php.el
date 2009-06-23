(autoload 'php-mode "php-mode" nil t)
(setq auto-mode-alist (cons '("\\.php\\'" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.inc\\'" . php-mode) auto-mode-alist))

(defun my-php-mode-hook ()
  (set (make-local-variable 'my-compile-command) (concat "php -l \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat "php \"" buffer-file-name "\""))
  
  (c-set-style "awk")
  (c-toggle-auto-newline 1)

  (my-programming-common-hook)

  (local-set-key '[(control c)(control v)] 'browse-url-of-buffer)
  (local-set-key '[(control =)] 'html-mode)  
  (local-set-key '[(control n)] (lambda () (interactive) (progn (insert "\\n"))))
  (local-set-key '[(control p)] (lambda () (interactive) (progn (insert "<?=  ?>")(backward-char 3))))
  (local-set-key '[(f12)] 'html-inlined-narrow))


(define-abbrev-table 'php-mode-abbrev-table ())
(snippet-with-abbrev-table 'php-mode-abbrev-table
			   ("fun" . "$>$.function $${function} ()\n$>{ \n$>$.\n}\>")
			   ("pf" . "$>$.public function $${function} () { \n$>$.\n}")
			   ("pvf" . "$>$.private function $${function} () { \n$>$.\n}")
               )


(add-hook 'php-mode-hook 'my-php-mode-hook)

;Editing HTML
(setq auto-mode-alist (cons '( "\\.tmpl\\'" . html-mode ) auto-mode-alist ))

(defun my-html-mode-hook()
  (require 'html-inlined)
  (html-inlined-add-key-to-modes)
  (local-set-key '[(control c)(control v)] 'browse-url-of-buffer)
  (local-set-key '[(control c)(control w)] 'sgml-validate)
  (local-set-key '[(control =)] 'php-mode)  
  )
(add-hook 'html-mode-hook 'my-html-mode-hook)

;CSS
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))

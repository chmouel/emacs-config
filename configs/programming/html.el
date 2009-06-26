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

;Javascript
(defun my-ecmascript-mode-hook()
  (local-set-key [tab] 'c-indent-command)
; (local-set-key ")" 'self-insert-command)
;  (local-set-key "(" 'self-insert-command)
;  (local-set-key ")" 'self-insert-command)
)
(autoload 'ecmascript-mode "js2")
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;CSS
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))

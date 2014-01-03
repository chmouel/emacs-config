;Editing HTML
(setq auto-mode-alist (cons '( "\\.tmpl\\'" . html-mode ) auto-mode-alist ))

(defun my-html-mode-hook()
  (require 'html-inlined)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (html-inlined-add-key-to-modes)
  (local-set-key '[(control c)(control v)] 'browse-url-of-buffer)
  (local-set-key '[(control c)(control w)] 'sgml-validate)
  )
(add-hook 'sgml-mode-hook 'my-html-mode-hook)

;CSS
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background
                     (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(autoload 'css-mode "css-mode")
(push '("\\.css\\'" . css-mode) auto-mode-alist)
(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)

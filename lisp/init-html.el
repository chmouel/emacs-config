(use-package web-mode
  :mode ("\\.tmp\\'" "\\.tmpl\\'" "\\.html\\'" "\\.htm\\'")
  :config
  (defun my-html-mode-hook()
    (flycheck-mode -1)
    (local-set-key (kbd "RET") 'newline-and-indent)
    (local-set-key '[(control c)(control v)] 'browse-url-of-buffer)
    (local-set-key '[(control c)(control w)] 'sgml-validate)
    )
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (auto-complete-mode)
    (yas-activate-extra-mode 'html-mode)
    (my-html-mode-hook)
    (local-set-key '[(control x) (.)] 'web-mode-element-content-select)
    (local-set-key '[(control x) (/)] 'web-mode-element-close)
    (local-set-key '[(meta /)] 'hippie-expand)
    (local-set-key '[(control =)] 'web-mode-tag-match)
    (local-set-key '[(control +)] 'web-mode-surround)
    (setq web-mode-attr-indent-offset 2
          web-mode-css-indent-offset 2
          web-mode-markup-indent-offset 2))
  (add-hook 'sgml-mode-hook 'my-html-mode-hook)  
  (add-hook 'web-mode-hook  'my-web-mode-hook)
  :mode ("\\.tpl\\.php\\'" "\\.[agj]sp\\'"
         "\\.as[cp]x\\'" "\\.erb\\'"
         "\\.mustache\\'" "\\.djhtml\\'"
         "\\.tmpl\\'" "\\.phtml\\'"))

;;CSS
(use-package css-mode
  :config
  (defvar hexcolour-keywords
    '(("#[abcdef[:digit:]]\\{6\\}"
       (0 (put-text-property
           (match-beginning 0)
           (match-end 0)
           'face (list :background
                       (match-string-no-properties 0)))))))
  (defun hexcolour-add-to-font-lock () (font-lock-add-keywords nil hexcolour-keywords))  
  :commands (css-mode)
  :mode "\\.css\\'"
  :config
  (add-hook 'css-mode-hook 'hexcolour-add-to-font-lock))

(provide 'init-html)

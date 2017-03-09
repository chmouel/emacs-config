;Editing HTML
(setq auto-mode-alist (cons '( "\\.tmpl\\'" . web-mode ) auto-mode-alist ))
(setq auto-mode-alist (cons '( "\\.html\\'" . web-mode ) auto-mode-alist ))
(setq auto-mode-alist (cons '( "\\.htm\\'" . web-mode ) auto-mode-alist ))

(defun my-html-mode-hook()
  (flycheck-mode -1)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-set-key '[(control c)(control v)] 'browse-url-of-buffer)
  (local-set-key '[(control c)(control w)] 'sgml-validate)
  )
(add-hook 'sgml-mode-hook 'my-html-mode-hook)

(Package 'web-mode
  (eval-after-load "web-mode"
    '(progn
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
       (add-hook 'web-mode-hook  'my-web-mode-hook)
       (add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))
       (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
       (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
       (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
       (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
       (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
       (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
       (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode)))))


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

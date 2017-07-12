(Package 'jsx-mode
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
  (autoload 'jsx-mode "jsx-mode" "JSX mode" t))

(Package 'js2-mode
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(setq js2-basic-offset 2)

(defun my-js-mode-hook()
  (my-programming-common-hook)
  )
(add-hook 'js-mode-hook 'my-js-mode-hook)
(add-hook 'js2-mode-hook 'my-js-mode-hook)

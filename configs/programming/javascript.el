(Package 'jsfmt)


(Package 'js2-mode
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(defun my-js-mode-hook()
  (setq-default js2-basic-offset 2)
  (auto-complete-mode)
  (my-programming-common-hook)
  )
(add-hook 'js-mode-hook 'my-js-mode-hook)
(add-hook 'js2-mode-hook 'my-js-mode-hook)

;DJANGO Mode

;MODELS
(define-derived-mode django-models-mode python-mode  "django-models"
  "Major mode for editing django models files")
(add-to-list 'auto-mode-alist '("models\\.py\\'" . django-models-mode))

;HTML Template
(autoload 'django-html-mode "django-html-mode")
(add-to-list 'auto-mode-alist '("\\.dhtml\\'" . django-html-mode))

(defun my-django-html-mode-hook()
  (local-set-key '[(control p)] (lambda () (interactive) (snippet-insert "{{ $${variable}$. }}")))
  (local-set-key '[(control meta p)] (lambda () (interactive) (snippet-insert "{% $${fun} %}\n$>$.\n{% end$${fun} %}")))
  )
(add-hook 'django-html-mode-hook 'my-django-html-mode-hook)

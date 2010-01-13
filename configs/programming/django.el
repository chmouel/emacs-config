;DJANGO Mode

;MODELS
(define-derived-mode django-models-mode python-mode  "django-models"
  "Major mode for editing django models files")
(push '("models\\.py\\'" . django-models-mode) auto-mode-alist)

;HTML Template
(autoload 'django-html-mode "django-html-mode")
(push '("\\.dhtml\\'" . django-html-mode) auto-mode-alist)

(defun my-django-html-mode-hook()
  (local-set-key '[(control p)] (lambda () (interactive) (snippet-insert "{{ $${variable}$. }}")))
  (local-set-key '[(control meta p)] (lambda () (interactive) (snippet-insert "{% $${fun} %}\n$>$.\n{% end$${fun} %}")))
  )
(add-hook 'django-html-mode-hook 'my-django-html-mode-hook)

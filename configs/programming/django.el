;DJANGO Mode

;MODELS
(define-derived-mode django-models-mode python-mode  "django-models"
  "Major mode for editing django models files")
(defvar django-models-mode-abbrev-table nil)
(eval-after-load  "django-models-mode"
  (snippet-with-abbrev-table 'django-models-mode-abbrev-table
    ("addmodel" . "class $${class}(models.Model):\n$>$.\n\n$>class Admin:\n$>pass\n\n$>def __str__(self): return\n")
    ("mcf" . "models.CharField( $. )")
    ("mfk" . "models.ForeignKey( $. )")
    )
  )
(add-to-list 'auto-mode-alist '("models\\.py\\'" . django-models-mode))


;HTML Template
(autoload 'django-html-mode "django-html-mode")
(add-to-list 'auto-mode-alist '("\\.dhtml\\'" . django-html-mode))

(defvar django-html-mode-abbrev-table nil)
(define-abbrev-table 'django-html-mode-abbrev-table ())
(eval-after-load  "django-html-mode"
  (snippet-with-abbrev-table 'django-html-mode-abbrev-table
    ("%if" . "{%if $${condition} %}\n$>$.\n{% endif %}")
    ("%bl" . "{%block $${block} %}$.\n{% endblock %}")
    ("%for" . "{% for $${entry} in $${list} %}\n$. {{$${entry} }}\n$>{% endfor %}\n$>")
    )
  )
(defun my-django-html-mode-hook()
  (local-set-key '[(control p)] (lambda () (interactive) (snippet-insert "{{ $${variable}$. }}")))
  (local-set-key '[(control meta p)] (lambda () (interactive) (snippet-insert "{% $${fun} %}\n$>$.\n{% end$${fun} %}")))
  )
(add-hook 'django-html-mode-hook 'my-django-html-mode-hook)














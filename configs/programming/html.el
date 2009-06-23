;Editing HTML
(setq auto-mode-alist (cons '( "\\.tmpl\\'" . html-mode ) auto-mode-alist ))

(defvar html-mode-abbrev-table nil)
(define-abbrev-table 'html-mode-abbrev-table ())
(eval-after-load  "sgml-mode"
  (snippet-with-abbrev-table 'html-mode-abbrev-table
    ("body" . "<body>\n$>$.\n</body>")
    ("dchttr" . "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"\n$>\"http://www.w3.org/TR/html4/loose.dtd\">\n")
    ("dcxml1" . "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\"\n$>\"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n")
    ("dcxmlf" . "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\"\n$>\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\">\n")
    ("dcxmls" . "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n$>\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n")
    ("dcxmlt" . "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n$>\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n")
    ("div" . "<div>\n$>$${paste}\n</div>")
    ("dtht" . "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n$>\"http://www.w3.org/TR/html4/strict.dtd\">\n")
    ("form" . "<form action=\"$${action}\" method=\"$${post}\" accept-charset=\"utf-8\">\n$>$.\n\n$><p><input type=\"submit\" value=\";\"/></p>\n</form>")
    ("h" . "<h1 id=\"$${alpha}\">$${paste}</h1>")
    ("head" . "<head>\n$><meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\"/>\n$><title>$${title}</title>\n$>$.\n</head>")
    ("input" . "<input type=\"$${button}\" name=\"$${some_name}\" value=\"$${3}\">")
    ("mailto" . "<a href=\"mailto:$${example}?subject=$${feedback}\">$${email}</a>")
    ("meta" . "<meta name=\"$${name}\" content=\"$${content}\"/>")
    ("script" . "<script type=\"text/javascript\">\n$>$.\n</script>")
    ("scriptsrc" . "<script src=\"$${1}\" type=\"text/javascript\" charset=\"$${utf}\"></script>")
    ("style" . "<style type=\"text/css\" media=\"screen\">\n$>$.\n</style>")
    ("table" . "<table border=\"$${0}\" $${cellpadding}>\n$><tr>\n$><th>\n$>$${Header}</th>\n$></tr>\n$><tr>\n$><td>\n$>$${Data}\n$></td>\n$></tr>\n$></table>")
    ("textarea" . "<textarea name=\"$${Name}\" rows=\"$${8}\" cols=\"$${40}\">$.</textarea>")
    ("title" . "<title>$${title}</title>")
    )
)

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

;Snippet
(defvar ecmascript-mode-abbrev-table nil)
(define-abbrev-table 'ecmascript-mode-abbrev-table ())
(snippet-with-abbrev-table 'ecmascript-mode-abbrev-table
			   ("function" . "function $${function} ($${args}) { \n$>$.\n}"))

;CSS
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))

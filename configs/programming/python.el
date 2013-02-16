(require 'nosetests)
(require 'flymake-easy)

(setq python-command (executable-find "python"))

(defconst flymake-python-pyflakes-err-line-patterns
  '(("^\\(.*?\\.py\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
    ;; flake8
    ("^\\(.*?\\.py\\):\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)$" 1 2 3 4)))

(defvar flymake-python-pyflakes-executable "/usr/local/share/python/flake8.fake"
  "Pyflakes executable to use for syntax checking.")

(defun flymake-python-pyflakes-command (filename)
  "Construct a command that flymake can use to syntax-check FILENAME."
  (list flymake-python-pyflakes-executable filename))

;;;###autoload
(defun flymake-python-pyflakes-load ()
  "Configure flymake mode to check the current buffer's python syntax using pyflakes."
  (interactive)
  (flymake-easy-load 'flymake-python-pyflakes-command
                     flymake-python-pyflakes-err-line-patterns
                     'inplace
                     "py"
                     "^W"))

(defun my-python-mode-hook()
  (when "highlight-80+" (highlight-80+-mode))
  (markit-mode)
  (auto-complete-mode)
  (flymake-python-pyflakes-load)
  (local-set-key '[(control c)(\[)] 'flymake-goto-prev-error)
  (local-set-key '[(control c)(\])] 'flymake-goto-next-error)
  (local-set-key '[(control c)(control k)] 'mark-defun)
  (local-set-key (kbd "C-S-y") 'nosetests-compile-module)
  (local-set-key (kbd "C-S-t") 'nosetests-copy-shell-comand)
  (local-set-key (kbd "C-S-r") 'nosetests-compile)
  (which-func-mode 't)
  (local-set-key '[(meta q)] 'python-fill-paragraph)
  (set (make-local-variable 'my-compile-command) (concat python-check-command " \"" buffer-file-name "\""))
  (set (make-local-variable 'my-compile-run-command) (concat python-shell-interpreter " -E \"" buffer-file-name "\""))
  (my-programming-common-hook)
  (local-set-key '[(control meta p)] (lambda () (interactive) (progn (insert "self."))))
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)

(require 'nosetests)
(require 'flymake-easy)
(require 'outline-magic)

(setq python-command (executable-find "python"))
(setq python-shell-interpreter (executable-find "ipython"))
(setq flymake-python-pyflakes-executable "flake8")

(defconst flymake-python-pyflakes-err-line-patterns
  '(("^\\(.*?\\.py\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
    ("^\\(.*?\\.py\\):\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)$" 1 2 3 4)))

(defun flymake-python-pyflakes-command (filename)
  (list flymake-python-pyflakes-executable filename))

(defun flymake-python-pyflakes-load ()
  (interactive)
  (flymake-easy-load 'flymake-python-pyflakes-command
                     flymake-python-pyflakes-err-line-patterns
                     'inplace
                     "py"
                     "^W"))

(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "    ")
      (current-column))))

(defun my-python-mode-hook()
  (outline-minor-mode t)
  (setq outline-regexp "[ \t]*# \\|[ \t]+\\(class\\|def\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|with\\) ")
  (setq outline-level 'py-outline-level)
  (define-key outline-minor-mode-map [M-down] 'outline-move-subtree-down)
  (define-key outline-minor-mode-map [M-up] 'outline-move-subtree-up)

  (when "highlight-80+" (highlight-80+-mode))
  (markit-mode)
  (auto-complete-mode)
  (flymake-python-pyflakes-load)
  (local-set-key '[(control c)(\[)] 'flymake-goto-prev-error)
  (local-set-key '[(control c)(\])] 'flymake-goto-next-error)
  (local-set-key '[(control c)(control k)] 'outline-mark-subtree)
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

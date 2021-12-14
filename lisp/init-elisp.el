;;
(use-package aggressive-indent
  :defer t)

(use-package eldoc
  :defer t)

(use-package emacs-lisp
  :ensure nil
  :defer t
  :interpreter ("emacs" . emacs-lisp-mode)
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  (emacs-lisp-mode . company-mode)
  (emacs-lisp-mode . turn-on-eldoc-mode)
  :bind (:map emacs-lisp-mode-map
              ("C-x C-e" . eval-buffer)))


(use-package slime-company
  :hook (slime-mode . company-mode))

(use-package lisp
  :ensure nil
  :defer t
  :interpreter ("emacs" . emacs-lisp-mode)
  :config
  :hook
  (lisp-mode . aggressive-indent-mode)
  (lisp-mode . company-mode)
  (lisp-mode . turn-on-eldoc-mode)
  (lisp-interaction-mode . turn-on-eldoc-mode)
  (ielm-mode . turn-on-eldoc-mode)
  :bind (:map emacs-lisp-mode-map
              ("C-x C-e" . eval-buffer)))


(use-package scheme
  :hook
  (scheme-mode . aggressive-indent-mode))

(provide 'init-elisp)

;;
(use-package aggressive-indent :ensure t :diminish aggressive-indent-mode)

(use-package eldoc
  :defer t
  :diminish)

(use-package emacs-lisp
  :ensure nil
  :defer t
  :interpreter ("emacs" . emacs-lisp-mode)
  :init
  (defun my-emacs-lisp-mode-hook ()
    (aggressive-indent-mode t)
    (company-mode)
    (turn-on-eldoc-mode)
    (my-programming-common-hook))
  (add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  :bind (:map emacs-lisp-mode-map
              ("C-x C-e" . eval-buffer)))

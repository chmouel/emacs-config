;Eldoc-Mode
(use-package smartparens :diminish smartparens-mode)
(use-package aggressive-indent
  :diminish aggressive-indent-mode)

(defun my-emacs-lisp-mode-hook ()
  (smartparens-mode)
  (aggressive-indent-mode t)
  (company-mode)
  (local-set-key (read-kbd-macro "C-x C-e") 'eval-buffer)
  (turn-on-eldoc-mode)
  (my-programming-common-hook))

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

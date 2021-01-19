;Eldoc-Mode
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :bind
  ("C-M-a" . sp-backward-sexp)
  ("C-M-e" . sp-forward-sexp)
  :config
  (bind-key
   "C-c s"
   (defhydra smartparens-hydra ()
     "Smartparens"
     ("d" sp-down-sexp "Down")
     ("e" sp-up-sexp "Up")
     ("l" sp-next-sexp "Next")
     ("h" sp-previous-sexp "Prev")
     ("u" sp-backward-up-sexp "Up")
     ("a" sp-backward-down-sexp "Down")
     ("f" sp-forward-sexp "Forward")
     ("b" sp-backward-sexp "Backward")
     ("k" sp-kill-sexp "Kill")
     ("q" nil "Quit" :color blue))
   smartparens-mode-map))
(use-package aggressive-indent :ensure t :diminish aggressive-indent-mode)

(use-package emacs-lisp
  :ensure nil
  :defer t
  :interpreter ("emacs" . emacs-lisp-mode)
  :init
  (defun my-emacs-lisp-mode-hook ()
    (smartparens-mode)
    (aggressive-indent-mode t)
    (company-mode)
    (turn-on-eldoc-mode)
    (my-programming-common-hook))
  (add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
  :bind (:map emacs-lisp-mode-map
              ("C-x C-e" . eval-buffer)))

(use-package icomplete
  :custom
  (icomplete-delay-completions-threshold 0)
  (icomplete-max-delay-chars 2)
  (icomplete-compute-delay 0)
  (icomplete-show-matches-on-no-input t)
  (icomplete-hide-common-prefix nil)
  (icomplete-prospects-height 10)
  (icomplete-in-buffer nil)
  (icomplete-with-completion-tables t)
  :bind
  (:map
   icomplete-minibuffer-map
   ("C-m" . minibuffer-complete-and-exit)
   ("C-j" . exit-minibuffer)
   ("C-s" . icomplete-forward-completions)
   ("C-n" . icomplete-forward-completions)
   ("C-p" . icomplete-backward-completions)
   ("<tab>" . minibuffer-complete)
   ("<return>" . icomplete-force-complete-and-exit)))


(provide 'init-icomplete)

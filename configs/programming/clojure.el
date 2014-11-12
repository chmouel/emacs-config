(Package 'cider)

(defun my-clojure-mode-hook ()
  (my-programming-common-hook)
  (local-set-key '[(control return)]
                 (lambda ()
                   (interactive)
                   (clojure-load-file
                    (buffer-file-name)))))
(add-hook 'clojure-mode-hook 'my-clojure-mode-hook)

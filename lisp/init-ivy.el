(use-package counsel)

(use-package ivy
  :ensure t
  :demand
  (:map ivy-minibuffer-map
        ("C-s" . ivy-next-line)
        ("C-M-j" . ivy-partial)
        ("C-j" . ivy-immediate-done)
        ("C-\\" . ivy-next-line))
  :custom
  (ivy-use-virtual-buffers t))

(use-package ivy-prescient
  :commands ivy-prescient-re-builder
  (ivy-prescient-mode 1))

(use-package ivy-rich
  :after counsel
  :hook ((ivy-rich-mode . (lambda ()
                            (setq ivy-virtual-abbreviate
                                  (or (and ivy-rich-mode 'abbreviate) 'name)))))
  :init
  ;; For better performance
  (ivy-rich-mode t)
  (setq ivy-rich-parse-remote-buffer nil))

(provide 'init-ivy)

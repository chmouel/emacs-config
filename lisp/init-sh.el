(use-package sh-script
  :hook ((sh-mode . lsp))
  ;; :config
  ;; (add-to-list 'multi-compile-alist
  ;;              '(sh-mode . (("bash-debug" . "bash -n \"%path\"")
  ;;                           ("bash-run" . "bash \"%path\""))))
  )

(provide 'init-sh)

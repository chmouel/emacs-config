(use-package selectrum-prescient
  :ensure t
  :after selectrum
  :init
  (selectrum-prescient-mode +1))

(use-package selectrum
  :hook (after-init . selectrum-mode)
  :preface (declare-function chmou-selectrum-insert-or-submit-current-candidate nil)
  :init
  (defun chmou-selectrum-classic-find-file-completion ()
    "This tries to mimic the classic find file completion

If multiple matches, go to next candidates, and rotate if we are at the bottom.
If only one match, select it.
If current selection is a directory insert it in the current completion.
See https://streamable.com/4785sz for demo."
    (interactive)
    (progn
      (let* ((index
              (if (and selectrum--current-candidate-index
                       (not (< selectrum--current-candidate-index 0)))
                  selectrum--current-candidate-index 0))
             (matchesn (length (selectrum-get-current-candidates)))
             (selection (selectrum--get-candidate index)))
        (cond
         ((string-suffix-p "/" selection)
          (selectrum-insert-current-candidate))
         ((> (length (selectrum-get-current-candidates)) 1)
          (if (= (+ 1 index) matchesn) ;; Rotate if we are at the end
              (selectrum-next-candidate (-(- matchesn 1)))
            (selectrum-next-candidate)))
         ((= (length (selectrum-get-current-candidates)) 1)
          (selectrum-select-current-candidate))))))
  :ensure t
  :custom-face
  (selectrum-current-candidate ((t
                                 (:inherit highlight
                                           :underline nil))))
  :bind
  (:map selectrum-minibuffer-map
        ("C-s" . selectrum-next-candidate)
        ("TAB" . chmou-selectrum-classic-find-file-completion)        
        ("C-l" . selectrum-insert-current-candidate)
        ("C-RET" . selectrum-submit-exact-input)
        ("C-\\" . selectrum-next-candidate))
  :custom
  (selectrum-count-style 'nil)
  (selectrum-max-window-height 15)
  (selectrum-extend-current-candidate-highlight t))

(provide 'init-selectrum)


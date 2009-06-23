(defun my-snippet-indent-or-complete ()
  "Complete if point is at end of left a leave word, otherwise indent line."
  (interactive)
  (cond
   ;; snippet
   ((and (boundp 'snippet) snippet)
    (snippet-next-field))

   ;; completion-ui
   ((and (fboundp 'completion-overlay-at-point)
         (completion-overlay-at-point))
    (let* ((ov (completion-overlay-at-point))
           (end (overlay-end ov))
           ;; setup <SPACE> as last command
           (last-input-event 32)
           (last-command-event 32))
      ;; skip message output
      (flet ((message (format-string &rest args) nil))
        (completion-self-insert))))

   ((looking-at "\\_>")
    ;; skip message output
    (flet ((message (format-string &rest args) nil))
      (expand-abbrev)))


;; hippie-expand
;;    ((looking-at "\\_>")
;;     ;; skip message output
;;     (flet ((message (format-string &rest args) nil))
;;       (hippie-expand nil)))
   ;; run default indent command
   (t (indent-for-tab-command))))

(defun my-programming-common-hook() 
  (local-set-key (kbd "TAB") 'my-snippet-indent-or-complete)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (local-set-key '[(meta return)] 'compile)
  (local-set-key '[(control meta return)] (lambda () (interactive) (compile my-compile-command)))
  (local-set-key '[(control return)] (lambda () (interactive) (compile my-compile-run-command)))
)

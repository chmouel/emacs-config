(setq
 bbdb-north-american-phone-numbers-p nil
 bbdb-offer-save (quote savenoprompt)
 bbdb-silent-running t
 bbdb-use-pop-up nil
 bbdb-file "~/Gnus/config/bbdb"
 )

;BBDB ADDRBOOK
(add-to-list 'load-path (expand-file-name "/usr/share/emacs/site-lisp/bbdb/lisp"))
(require 'message-x nil t)
(require 'bbdb nil t)
(require 'bbdb-gnus nil t)

(if (featurep 'bbdb)
    (progn
      (bbdb-initialize 'gnus 'message)
      (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus) ))

;The line below enables BBDB in resending a message:
(define-key message-minibuffer-local-map [(tab)] 'bbdb-complete-name)

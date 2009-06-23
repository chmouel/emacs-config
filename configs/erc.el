(eval-after-load 'erc "erc-nicklist")
(defun my-irc-ryder ()
  (interactive)
  (erc-tls :server "ryder.racklabs.com" :port "6670"
           :nick "Chmou"
           :full-name "Chmouel Boudjnah"))

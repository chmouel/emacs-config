(eval-after-load 'erc "erc-nicklist")
(defun my-irc-ryder ()
  (interactive)
  (erc-tls :server "ryder.racklabs.com" :port "6670"
           :nick "Chmou"
           :full-name "Chmouel Boudjnah"))

(setq
 erc-away-nickname "Chmouaway"
 erc-email-userid "chmouel.boudjnah@rackspace.co.uk"
 erc-hide-list (quote ("PART" "QUIT"))
 erc-input-line-position -2
 erc-log-channels-directory "~/.irclogs"
 erc-log-insert-log-on-open t
 erc-modules (quote (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring scrolltobottom stamp spelling track))
 erc-nick "Chmou"
 erc-nicklist-use-icons t
 erc-pals (quote ("ej"))
 erc-port 6670
 erc-prompt "-> "
 erc-prompt-for-password nil
 erc-server "ryder.racklabs.com"
 erc-system-name "frenchy.rackspace.co.uk"
 erc-track-enable-keybindings t
 erc-user-full-name "Chmouel Boudjnah"
)

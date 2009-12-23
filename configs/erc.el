(eval-after-load 'erc "erc-nicklist")
(defun my-irc-ryder ()
  (interactive)
  (erc-tls :server "ryder.racklabs.com" :port "6670"
           :nick "Chmou"
           :full-name "Chmouel Boudjnah"))

(setq
 erc-away-nickname "chmouel_away"
 erc-email-userid "chmouel@chmouel.com"
 erc-hide-list (quote ("PART" "QUIT"))
 erc-input-line-position -2
 erc-log-channels-directory "~/.irclogs"
 erc-log-insert-log-on-open t
 erc-modules (quote (autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring scrolltobottom stamp spelling track))
 erc-nick "chmouelb"
 erc-nicklist-use-icons t
 erc-pals (quote ("exlt"))
 erc-port 6667
 erc-prompt "-> "
 erc-prompt-for-password nil
 erc-server "irc.freenode.org"
 erc-system-name "frenchy.rackspace.co.uk"
 erc-track-enable-keybindings t
 erc-user-full-name "Chmouel Boudjnah"
)

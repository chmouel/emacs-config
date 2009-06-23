;;; -*- indent-tabs-mode:nil -*-
;;;; Copyright (c) 2007 Jeremy English <jhe@jeremyenglish.org>
;;;; 
;;;; Permission to use, copy, modify, distribute, and sell this
;;;; software and its documentation for any purpose is hereby granted
;;;; without fee, provided that the above copyright notice appear in
;;;; all copies and that both that copyright notice and this
;;;; permission notice appear in supporting documentation.  No
;;;; representations are made about the suitability of this software
;;;; for any purpose.  It is provided "as is" without express or
;;;; implied warranty.
;;;; 
;;;; Created: 08-February-2007 
;;;; 
;;;; 
;;;; Pulls definitions from google and displays them in a buffer. 
;;;; 
;;;; google-define is the command to call to get a new definition.
;;;;
;;;; 2007-07-05 You can now search for definitions of terms such as
;;;; pig latin

(require 'font-lock)

(defconst *google-define-html-entry-table*
  (list
   '("&#34;" "&quot;" "\"")   '("&#38;" "&amp;" "&")     '("&#39;" "&yow;" "'") 
   '("&#62;" "&gt;" ">")      '("&#160;" "&nbsp;" " ")   '("&#161;" "&iexcl;" "¡")
   '("&#162;" "&cent;" "¢")   '("&#163;" "&pound;" "£")  '("&#164;" "&curren;" "¤")
   '("&#165;" "&yen;" "¥")    '("&#166;" "&brvbar;" "¦") '("&#167;" "&sect;" "§")
   '("&#168;" "&uml;" "¨")    '("&#169;" "&copy;" "©")   '("&#170;" "&ordf;" "ª")
   '("&#171;" "&laquo;" "«")  '("&#172;" "&not;" "¬")    '("&#173;" "&shy;" "­")
   '("&#174;" "&reg;" "®")    '("&#175;" "&macr;" "¯")   '("&#176;" "&deg;" "°")
   '("&#177;" "&plusmn;" "±") '("&#178;" "&sup2;" "²")   '("&#179;" "&sup3;" "³")
   '("&#180;" "&acute;" "´")  '("&#181;" "&micro;" "µ")  '("&#182;" "&para;" "¶")
   '("&#183;" "&middot;" "·") '("&#184;" "&cedil;" "¸")  '("&#185;" "&sup1;" "¹")
   '("&#186;" "&ordm;" "º")   '("&#187;" "&raquo;" "»")  '("&#188;" "&frac14;" "¼")
   '("&#189;" "&frac12;" "½") '("&#190;" "&frac34;" "¾") '("&#191;" "&iquest;" "¿")
   '("&#192;" "&Agrave;" "À") '("&#193;" "&Aacute;" "Á") '("&#194;" "&Acirc;" "Â")
   '("&#195;" "&Atilde;" "Ã") '("&#196;" "&Auml;" "Ä")   '("&#197;" "&Aring;" "Å")
   '("&#198;" "&AElig;" "Æ")  '("&#199;" "&Ccedil;" "Ç") '("&#200;" "&Egrave;" "È")
   '("&#201;" "&Eacute;" "É") '("&#202;" "&Ecirc;" "Ê")  '("&#203;" "&Euml;" "Ë")
   '("&#204;" "&Igrave;" "Ì") '("&#205;" "&Iacute;" "Í") '("&#206;" "&Icirc;" "Î")
   '("&#207;" "&Iuml;" "Ï")   '("&#208;" "&ETH;" "Ð")    '("&#209;" "&Ntilde;" "Ñ")
   '("&#210;" "&Ograve;" "Ò") '("&#211;" "&Oacute;" "Ó") '("&#212;" "&Ocirc;" "Ô")
   '("&#213;" "&Otilde;" "Õ") '("&#214;" "&Ouml;" "Ö")   '("&#215;" "&times;" "×")
   '("&#216;" "&Oslash;" "Ø") '("&#217;" "&Ugrave;" "Ù") '("&#218;" "&Uacute;" "Ú")
   '("&#219;" "&Ucirc;" "Û")  '("&#220;" "&Uuml;" "Ü")   '("&#221;" "&Yacute;" "Ý")
   '("&#222;" "&THORN;" "Þ")  '("&#223;" "&szlig;" "ß")  '("&#224;" "&agrave;" "à")
   '("&#225;" "&aacute;" "á") '("&#226;" "&acirc;" "â")  '("&#227;" "&atilde;" "ã")
   '("&#228;" "&auml;" "ä")   '("&#229;" "&aring;" "å")  '("&#230;" "&aelig;" "æ")
   '("&#231;" "&ccedil;" "ç") '("&#232;" "&egrave;" "è") '("&#233;" "&eacute;" "é")
   '("&#234;" "&ecirc;" "ê")  '("&#235;" "&euml;" "ë")   '("&#236;" "&igrave;" "ì")
   '("&#237;" "&iacute;" "í") '("&#238;" "&icirc;" "î")  '("&#239;" "&iuml;" "ï")
   '("&#240;" "&eth;" "ð")    '("&#241;" "&ntilde;" "ñ") '("&#242;" "&ograve;" "ò")
   '("&#243;" "&oacute;" "ó") '("&#244;" "&ocirc;" "ô")  '("&#245;" "&otilde;" "õ")
   '("&#246;" "&ouml;" "ö")   '("&#247;" "&divide;" "÷") '("&#248;" "&oslash;" "ø")
   '("&#249;" "&ugrave;" "ù") '("&#250;" "&uacute;" "ú") '("&#251;" "&ucirc;" "û")
   '("&#252;" "&uuml;" "ü")   '("&#253;" "&yacute;" "ý") '("&#254;" "&thorn;" "þ")
   '("&#255;" "&yuml;" "ÿ")   '("&#60;" "&lt;" "<")))

(defun google-define-number-entry (entry)
  (first entry))

(defun google-define-name-entry (entry)
  (second entry))

(defun google-define-ascii-entry (entry)
  (third entry))

(defun google-define-replace-string (from-string to-string)
  (goto-char (point-min))
  (while (search-forward from-string nil t)
    (replace-match to-string nil t)))

(defun google-define-replace-html ()
  (dolist (x *google-define-html-entry-table*)
    (let ((ascii (google-define-ascii-entry x)))
      (google-define-replace-string 
       (google-define-number-entry x) ascii)
      (google-define-replace-string
       (google-define-name-entry x) ascii))))

(defun google-define-get-command (host path)
  (let* ((timeout 180)
	 (port 80) ;http
	 (post-cmd
	  (concat "GET " path " HTTP/1.0\r\n"
		  "Host: " host "\r\n"
		  "User-Agent: Emacs\r\n"
;		  "User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1\r\n"
		  "Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5\r\n"
		  "Accept-Language: en-us,en;q=0.5\r\n"
		  "Accept-Encoding: gzip,deflate\r\n"
		  "Accept-Charset: ISO-8859-1;q=0.7,*;q=0.7\r\n"
		  "\r\n"))
	 proc buf)
    
    (unwind-protect
	(progn 
	  (setq proc (open-network-stream "url-get-command"
					  "*url-get-buffer*"
					  host
					  port)
		buf (process-buffer proc))
	  (process-send-string proc post-cmd)
	  (message "Getting information from %s: waiting for response..." host)
	  
	  (while (equal (process-status proc) 'open)
	    (unless (accept-process-output proc timeout)
	      (delete-process proc)
	      (error "Server error: timed out while waiting!")))
	  
	  (message "Response received: processing...")))
	  
    ;; unwind-protect
    buf))

(defun google-define-parse-buffer (search-word buf)
  "Pull all of the definitions out of the data returned from google."
  (let ((definition-buffer (get-buffer-create "Definitions"))
	(count 0)
	(header (concat "Definitions for " search-word))
        (original-buffer (current-buffer)))
    (set-buffer definition-buffer)
    (erase-buffer)
    (google-define-mode)
    (save-excursion
      (setf fill-prefix "     ")
      (insert (concat header "\n\n"))
      (set-buffer buf)
      (goto-char (point-min))
      (while (search-forward "<li>" nil t)
	(incf count)
	(let ((start-point (point)))
	  (search-forward "<")
	  (let* ((end-point (1- (point)))
		 (definition 
		   (buffer-substring
		    start-point end-point)))
	    (set-buffer definition-buffer)
	    (let ((insert-start-point (point-max)))
	      (goto-char insert-start-point)
	      (insert (format "%3d. %s\n\n" count definition))
	      (goto-char insert-start-point)
	      (fill-paragraph nil))
	    (set-buffer buf))))
      (set-buffer definition-buffer)
      (google-define-replace-html)
      (unless (equal original-buffer definition-buffer)
        (switch-to-buffer-other-window definition-buffer))
      (message header))))

(defun google-define-plus-space (s)
  "Replace any spaces in the string with +"
  (let ((ns (make-string (length s) ?+)))
    (dotimes (x (length ns))
      (unless (equal (aref s x) ? )
        (setf (aref ns x) (aref s x))))
    ns))
      

(defun google-define ()
  "Ask google for the definition of a word.

If we have a current region use it's value as the default."
  (interactive)
  (let* ((search-word 
	  (read-from-minibuffer "Define: " 
				(thing-at-point 'word)))
	(data-buffer
	 (google-define-get-command "www.google.com" 
			  (concat 
			   "/search?num=100&hl=en&q=define%3A%22" 
			   (google-define-plus-space search-word) 
                 "%22&btnG=Search"))))
    (google-define-parse-buffer search-word data-buffer)
    (kill-buffer data-buffer)))

(defconst google-define-font-lock-keywords
  (list
   (list "^Definitions.for.+$" '(0 font-lock-function-name-face))
   (list "^\\s-+.+$" '(0 font-lock-string-face))))

;;; Major Mode

(defvar google-define-mode-hook nil )

(defun google-define-mode ()
  "Mode used by the output buffer"
  (kill-all-local-variables)
  (setq major-mode 'google-define-mode
	mode-name "google-define")
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        '(google-define-font-lock-keywords t))
  (run-hooks 'google-definition-mode-hook))

(provide 'google-define)

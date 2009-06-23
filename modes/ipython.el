;;; ipython.el --- Adds support for IPython to python-mode.el

;; Copyright (C) 2002, 2003, 2004, 2005 Alexander Schmolck
;; Author:        Alexander Schmolck
;; Keywords:      ipython python languages oop
;; URL:           http://ipython.scipy.org
;; Compatibility: Emacs21, XEmacs21
;; FIXME: #$@! INPUT RING
(defconst ipython-version "$Revision: 1.2 $"
  "VC version number.")

;;; Commentary 
;; This library makes all the functionality python-mode has when running with
;; the normal python-interpreter available for ipython, too. It also enables a
;; persistent py-shell command history accross sessions (if you exit python
;; with C-d in py-shell) and defines the command `ipython-to-doctest', which
;; can be used to convert bits of a ipython session into something that can be
;; used for doctests. To install, put this file somewhere in your emacs
;; `load-path' [1] and add the following line to your ~/.emacs file (the first
;; line only needed if the default (``"ipython"``) is wrong)::
;;
;;   (setq ipython-command "/SOME-PATH/ipython")
;;   (require 'ipython)
;;
;; Ipython will be set as the default python shell, but only if the ipython
;; executable is in the path. For ipython sessions autocompletion with <tab>
;; is also enabled (experimental feature!). Please also note that all the
;; terminal functions in py-shell are handled by emacs's comint, **not** by
;; (i)python, so importing readline etc. will have 0 effect.
;;
;; NOTE: This mode is currently somewhat alpha and although I hope that it
;; will work fine for most cases, doing certain things (like the
;; autocompletion and a decent scheme to switch between python interpreters)
;; properly will also require changes to ipython that will likely have to wait
;; for a larger rewrite scheduled some time in the future.
;; 
;; Also note that you currently NEED THE CVS VERSION OF PYTHON.EL.
;;
;; Further note that I don't know whether this runs under windows or not and
;; that if it doesn't I can't really help much, not being a fellow sufferer.
;;
;; Please send comments and feedback to the ipython-list
;; (<ipython-user@scipy.net>) where I (a.s.) or someone else will try to
;; answer them (it helps if you specify your emacs version, OS etc; 
;; familiarity with <http://www.catb.org/~esr/faqs/smart-questions.html> might
;; speed up things further).
;;
;; Footnotes:
;;
;;     [1] If you don't know what `load-path' is, C-h v load-path will tell
;;     you; if required you can also add a new directory. So assuming that
;;     ipython.el resides in ~/el/, put this in your emacs:
;;
;;
;;           (add-to-list 'load-path "~/el")
;;           (setq ipython-command "/some-path/ipython")
;;           (require 'ipython)
;;
;;
;;
;;
;; TODO:
;;      - do autocompletion properly
;;      - implement a proper switching between python interpreters
;;
;; BUGS:
;;      - neither::
;;
;;         (py-shell "-c print 'FOOBAR'")
;;       
;;        nor::
;;       
;;         (let ((py-python-command-args (append py-python-command-args 
;;                                              '("-c" "print 'FOOBAR'"))))
;;           (py-shell))
;;
;;        seem to print anything as they should

;;; Code
(require 'cl)
(require 'shell)
(require 'executable)
(require 'ansi-color)

(defcustom ipython-command "ipython"
  "*Shell command used to start ipython."
  :type 'string 
  :group 'python)

;; Users can set this to nil
(defvar py-shell-initial-switch-buffers t
  "If nil, don't switch to the *Python* buffer on the first call to
  `py-shell'.")

(defvar ipython-backup-of-py-python-command nil
  "HACK")

  
(defvar ipython-de-input-prompt-regexp "\\(?:
In \\[[0-9]+\\]: .*
----+> \\(.*
\\)[\n]?\\)\\|\\(?:
In \\[[0-9]+\\]: \\(.*
\\)\\)\\|^[ ]\\{3\\}[.]\\{3,\\}: \\(.*
\\)"
  "A regular expression to match the IPython input prompt and the python
command after it. The first match group is for a command that is rewritten,
the second for a 'normal' command, and the third for a multiline command.")
(defvar ipython-de-output-prompt-regexp "^Out\\[[0-9]+\\]: "
  "A regular expression to match the output prompt of IPython.")

(defvar ipython-de-input-prompt-regexp "\\(?:
sage: .*
----+> \\(.*
\\)[\n]?\\)\\|\\(?:
sage: \\(.*
\\)\\)\\|^[ ]\\{3\\}[.]\\{3,\\}: \\(.*
\\)"
  "A regular expression to match the IPython input prompt and the python
command after it. The first match group is for a command that is rewritten,
the second for a 'normal' command, and the third for a multiline command.")
(defvar ipython-de-output-prompt-regexp " "
  "A regular expression to match the output prompt of IPython.")

(if (not (executable-find ipython-command))
    (message (format "Can't find executable %s - ipython.el *NOT* activated!!!"
                     ipython-command))
    ;; XXX load python-mode, so that we can screw around with its variables
    ;; this has the disadvantage that python-mode is loaded even if no
    ;; python-file is ever edited etc. but it means that `py-shell' works
    ;; without loading a python-file first. Obviously screwing around with
    ;; python-mode's variables like this is a mess, but well.
    (require 'python-mode)
    ;; turn on ansi colors for ipython and activate completion
    (defun ipython-shell-hook ()
      ;; the following is to synchronize dir-changes
      (make-local-variable 'shell-dirstack)
      (setq shell-dirstack nil)
      (make-local-variable 'shell-last-dir)
      (setq shell-last-dir nil)
      (make-local-variable 'shell-dirtrackp)
      (setq shell-dirtrackp t)
      (add-hook 'comint-input-filter-functions 'shell-directory-tracker nil t)

      (ansi-color-for-comint-mode-on)
      (define-key py-shell-map [tab] 'ipython-complete)
      ;;XXX this is really just a cheap hack, it only completes symbols in the
      ;;interactive session -- useful nonetheless.
      (define-key py-mode-map [(meta tab)] 'ipython-complete))
    (add-hook 'py-shell-hook 'ipython-shell-hook)
    ;; Regular expression that describes tracebacks for IPython in context and
    ;; verbose mode. 
  
    ;;Adapt python-mode settings for ipython.
    ;; (this works for @xmode 'verbose' or 'context')

    ;; XXX putative regexps for syntax errors; unfortunately the 
    ;;     current python-mode traceback-line-re scheme is too primitive,
    ;;     so it's either matching syntax errors, *or* everything else
    ;;     (XXX: should ask Fernando for a change)
    ;;"^   File \"\\(.*?\\)\", line \\([0-9]+\\).*\n.*\n.*\nSyntaxError:"
    ;;^   File \"\\(.*?\\)\", line \\([0-9]+\\)"
    (setq py-traceback-line-re
          "\\(^[^\t ].+?\\.py\\).*\n   +[0-9]+[^\00]*?\n-+> \\([0-9]+\\) +")

    (setq py-shell-input-prompt-1-regexp "^In \\[[0-9]+\\]: "
          py-shell-input-prompt-2-regexp "^   [.][.][.]+: " )
    ;; select a suitable color-scheme
    (unless (member "-colors" py-python-command-args)
      (setq py-python-command-args 
            (nconc py-python-command-args 
                   (list 
					"-nobanner"
					"-colors"
                         (cond  
                           ((eq frame-background-mode 'dark)
                            "Linux")
                           ((eq frame-background-mode 'light)
                            "LightBG")
                           (t ; default (backg-mode isn't always set by XEmacs)
                            "Linux"))))))
    (setq ipython-backup-of-py-python-command py-python-command)
    (setq py-python-command "ipython"))


;; MODIFY py-shell so that it loads the editing history
(defadvice py-shell (around py-shell-with-history)
  "Add persistent command-history support (in
$PYTHONHISTORY (or \"~/.ipython/history\", if we use IPython)). Also, if
`py-shell-initial-switch-buffers' is nil, it only switches to *Python* if that
buffer already exists."
  (if (comint-check-proc "*Python*")
      ad-do-it
    (setq comint-input-ring-file-name
          (if (string-equal py-python-command "ipython")
              (concat (or (getenv "IPYTHONDIR") "~/.ipython") "/history")
            (or (getenv "PYTHONHISTORY") "~/.python-history.py")))
    (comint-read-input-ring t)
    (let ((buf (current-buffer)))
      ad-do-it
      (unless py-shell-initial-switch-buffers
        (switch-to-buffer-other-window buf)))))
(ad-activate 'py-shell)
;; (defadvice py-execute-region (before py-execute-buffer-ensure-process)
;;   "HACK: test that ipython is already running before executing something.
;;   Doing this properly seems not worth the bother (unless people actually
;;   request it)."
;; (unless (comint-check-proc "*Python*")
;;     (error "Sorry you have to first do M-x py-shell to send something to ipython.")))
;; (ad-activate 'py-execute-region)

(defadvice py-execute-region (around py-execute-buffer-ensure-process)
  "HACK: if `py-shell' is not active or ASYNC is explicitly desired, fall back
  to python instead of ipython." 
  (let ((py-python-command (if (or (comint-check-proc "*Python*") async)
                               py-python-command
                               ipython-backup-of-py-python-command)))
    ad-do-it))
(ad-activate 'py-execute-region)

(defun ipython-to-doctest (start end)
  "Transform a cut-and-pasted bit from an IPython session into something that
looks like it came from a normal interactive python session, so that it can
be used in doctests. Example:


    In [1]: import sys
    
    In [2]: sys.stdout.write 'Hi!\n'
    ------> sys.stdout.write ('Hi!\n')
    Hi!
    
    In [3]: 3 + 4
    Out[3]: 7
    
gets converted to:

    >>> import sys
    >>> sys.stdout.write ('Hi!\n')
    Hi!
    >>> 3 + 4
    7

"
  (interactive "*r\n")
  ;(message (format "###DEBUG s:%de:%d" start end))
  (save-excursion
    (save-match-data
      ;; replace ``In [3]: bla`` with ``>>> bla`` and 
      ;;         ``... :   bla`` with ``...    bla``
      (goto-char start)
      (while (re-search-forward ipython-de-input-prompt-regexp end t)
        ;(message "finding 1")
        (cond ((match-string 3)         ;continued
               (replace-match "... \\3" t nil))
              (t
               (replace-match ">>> \\1\\2" t nil))))
      ;; replace ``
      (goto-char start)
      (while (re-search-forward ipython-de-output-prompt-regexp end t)
        (replace-match "" t nil)))))

(defvar ipython-completion-command-string 
  "print ';'.join(__IP.Completer.all_completions('%s')) #PYTHON-MODE SILENT\n"
  "The string send to ipython to query for all possible completions")


;; xemacs doesn't have `comint-preoutput-filter-functions' so we'll try the
;; following wonderful hack to work around this case
(if (featurep 'xemacs)
    ;;xemacs
    (defun ipython-complete ()
      "Try to complete the python symbol before point. Only knows about the stuff
in the current *Python* session."
      (interactive)
      (let* ((ugly-return nil)
             (sep ";")
             ;; XXX currently we go backwards to find the beginning of an
             ;; expression part; a more powerful approach in the future might be
             ;; to let ipython have the complete line, so that context can be used
             ;; to do things like filename completion etc.
             (beg (save-excursion (skip-chars-backward "a-z0-9A-Z_." (point-at-bol))
                                  (point)))
             (end (point))
             (pattern (buffer-substring-no-properties beg end))
             (completions nil)
             (completion-table nil)
             completion
             (comint-output-filter-functions
              (append comint-output-filter-functions 
                      '(ansi-color-filter-apply
                        (lambda (string) 
                                        ;(message (format "DEBUG filtering: %s" string))
                          (setq ugly-return (concat ugly-return string))
                          (delete-region comint-last-output-start 
                                         (process-mark (get-buffer-process (current-buffer)))))))))
                                        ;(message (format "#DEBUG pattern: '%s'" pattern))
        (process-send-string  (or (get-buffer-process (current-buffer))
                                  (get-process py-which-bufname)) ;XXX hack for .py buffers
                              (format ipython-completion-command-string pattern))
        (accept-process-output (get-buffer-process (current-buffer)))
                                        ;(message (format "DEBUG return: %s" ugly-return))
        (setq completions 
              (split-string (substring ugly-return 0 (position ?\n ugly-return)) sep))
        (setq completion-table (loop for str in completions
                                     collect (list str nil)))
        (setq completion (try-completion pattern completion-table))
        (cond ((eq completion t))
              ((null completion)
               (message "Can't find completion for \"%s\"" pattern)
               (ding))
              ((not (string= pattern completion))
               (delete-region beg end)
               (insert completion))
              (t
               (message "Making completion list...")
               (with-output-to-temp-buffer "*Python Completions*"
                 (display-completion-list (all-completions pattern completion-table)))
               (message "Making completion list...%s" "done")))))
  ;; emacs
  (defun ipython-complete ()
    "Try to complete the python symbol before point. Only knows about the stuff
in the current *Python* session."
    (interactive)
    (let* ((ugly-return nil)
           (sep ";")
           ;; XXX currently we go backwards to find the beginning of an
           ;; expression part; a more powerful approach in the future might be
           ;; to let ipython have the complete line, so that context can be used
           ;; to do things like filename completion etc.
           (beg (save-excursion (skip-chars-backward "a-z0-9A-Z_." (point-at-bol))
                                (point))) 
           (end (point))
           (pattern (buffer-substring-no-properties beg end))
           (completions nil)
           (completion-table nil)
           completion
         (comint-preoutput-filter-functions
          (append comint-preoutput-filter-functions 
                  '(ansi-color-filter-apply
                    (lambda (string) 
                      (setq ugly-return (concat ugly-return string))
                      "")))))
      (process-send-string  (or (get-buffer-process (current-buffer))
                                (get-process py-which-bufname)) ;XXX hack for .py buffers
                            (format ipython-completion-command-string pattern))
      (accept-process-output (get-buffer-process (current-buffer)))
      (setq completions 
            (split-string (substring ugly-return 0 (position ?\n ugly-return)) sep))
                                        ;(message (format "DEBUG completions: %S" completions))
      (setq completion-table (loop for str in completions
                                   collect (list str nil)))
      (setq completion (try-completion pattern completion-table))
      (cond ((eq completion t))
            ((null completion)
             (message "Can't find completion for \"%s\"" pattern)
             (ding))
            ((not (string= pattern completion))
             (delete-region beg end)
             (insert completion))
            (t
             (message "Making completion list...")
             (with-output-to-temp-buffer "*IPython Completions*"
               (display-completion-list (all-completions pattern completion-table)))
             (message "Making completion list...%s" "done")))))
)

(provide 'ipython)

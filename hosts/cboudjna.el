;Env
(setenv "MOSSO_API_USER" "chmouelb")
(setenv "MOSSO_API_KEY" "c3599eb5093d7f598a644640cfe5f3ae")
(setenv "GIT_SSH" "c:/PROGRA~1/PuTTY/plink.exe")

;Coding make sure it's unix
(setq buffer-file-coding-system 'undecided-unix)

;Appearance
(add-to-list 'default-frame-alist '(font . "-outline-Lucida Console-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1"))
(setq w32-use-full-screen-buffer nil)

;Default-Modes
(defun w32-browser (doc)
  "Browse to a particular file/URL using default web browser"
  (w32-shell-execute 1 doc))
(eval-after-load "dired"
  '(define-key dired-mode-map [f3] (lambda () 
                                     (interactive)
                                     (w32-browser
                                      (dired-replace-in-string 
                                       "/" "\\" 
                                       (dired-get-filename)))))
  )


;Grep
(setq 
 find-program "c:/unix/bin/find.exe"
 find-dired-find-program (concat find-program)
 grep-find-template (concat find-program " . <X> -type f <F> -exec grep <C> -nH -e <R> {} NUL \";\"")
)


;Bat mode
(autoload 'bat-generic-mode "generic-x" nil t)
(add-to-list 'auto-mode-alist '("\\.bat\\'" . bat-generic-mode))

;PSVN (Autoloaded on DEBIANS)
(autoload 'svn-status "psvn" nil t))

;Autohotkey Mode
(autoload 'ahk-mode "ahk-mode"  "AHK Mode."  nil t)

;;; Compiled snippets and support files for `go-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'go-mode
		     '(("spd" "fmt.Fprintf(os.Stderr, \\`\n============================================\n%s\n_____________________________________________\n\n\\`, spew.Sdump($0))\n" "spd" nil nil nil "/Users/chmouel/.emacs.d/snippets/go-mode/spd.yasnippet" "C-c M-p" nil)
		       ("pd" "fmt.Printf(\"%+v$0\\n\",$1)\n" "pd" nil nil nil "/Users/chmouel/.emacs.d/snippets/go-mode/pd.yasnippet" nil nil)
		       ("main" "package main\n\nimport (\n   \"fmt\"\n)\n\nfunc main() {\n   $0\n}\n" "main" nil nil nil "/Users/chmouel/.emacs.d/snippets/go-mode/main" nil nil)
		       ("gtr" "fmt.Printf(\"$0: %s\\n\", time.Now())" "debug trace" nil nil nil "/Users/chmouel/.emacs.d/snippets/go-mode/gtr.yasnippet" nil nil)
		       ("fmp" "fmt.Println($0)" "fmp" nil nil nil "/Users/chmouel/.emacs.d/snippets/go-mode/fmp.yasnippet" "M-p" nil)
		       ("fmf" "fmt.Printf(\"${1:$$(yas-choose-value '(\"%+v\" \"%d\" \"%s\"))}\\n\", $0)" "fmf" nil nil nil "/Users/chmouel/.emacs.d/snippets/go-mode/fmf" "M-P" nil)
		       ("errr" "if err != nil {\n    return\n}$0" "errr" nil nil nil "/Users/chmouel/.emacs.d/snippets/go-mode/errret.yasnippet" nil nil)
		       ("errnil" "if err != nil {\n    log.Fatal(err)\n}$0" "errnil" nil nil nil "/Users/chmouel/.emacs.d/snippets/go-mode/errit.yasnippet" nil nil)))


;;; Do not edit! File generated at Wed Feb 24 15:49:22 2021

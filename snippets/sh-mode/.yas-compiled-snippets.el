;;; Compiled snippets and support files for `sh-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'sh-mode
		     '(("zshargparse" "while getopts ':i' arg\ndo\ncase $arg in\n(i) onlyinstall=yes  ;;\n(\\?) print invalid option: $OPTARG;exit 1;;\nesac\ndone\n(( OPTIND > 1 )) && shift $(( OPTIND - 1 ))" "ZSH Argparse" nil nil nil "/Users/chmouel/.emacs.d/snippets/sh-mode/zshargparse" nil nil)
		       ("tmpc" "TMP=$(mktemp /tmp/.mm.XXXXXX)\nclean() { rm -f \\${TMP}; }\ntrap clean EXIT\n$0" "Temporary File" nil nil nil "/Users/chmouel/.emacs.d/snippets/sh-mode/tmpc" nil nil)
		       ("td" "# TODO(chmouel):" "TODO" nil nil nil "/Users/chmouel/.emacs.d/snippets/sh-mode/td" nil nil)
		       ("#!!" "#!/usr/bin/env bash\n# Chmouel Boudjnah <chmouel@chmouel.com>" "shbang" nil nil nil "/Users/chmouel/.emacs.d/snippets/sh-mode/shbang" nil nil)
		       ("err" " || { echo \"$1\"; exit 1 ;}" "Exit if error" nil nil nil "/Users/chmouel/.emacs.d/snippets/sh-mode/err" nil nil)
		       ("cdscriptdir" "cd $(dirname $(readlink -f $0))" "CD to script dir" nil nil nil "/Users/chmouel/.emacs.d/snippets/sh-mode/cdscriptdir" nil nil)
		       ("bashgetopt" "while getopts \"$0s:\" o; do\ncase \"\\${o}\" in\ns)\ns=\\${OPTARG}\n;;\n*)\necho \"Invalid option\"; exit 1;\n;;\nesac\ndone\nshift \\$((OPTIND-1))\n" "BASH Getopt" nil nil nil "/Users/chmouel/.emacs.d/snippets/sh-mode/bashgetopt" nil nil)
		       ("--z" "if [[ -z $${{$0}} ]];then\n   $1\nfi\n" "Check undefined variable -z" nil nil nil "/Users/chmouel/.emacs.d/snippets/sh-mode/--z.yasnippet" nil nil)))


;;; Do not edit! File generated at Wed Feb 24 15:49:22 2021

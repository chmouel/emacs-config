;;; Compiled snippets and support files for `python-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'python-mode
		     '(("td" "# TODO(chmou):" "TODO" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/td" nil nil)
		       ("skelton-cli.yasnippet" "# -*- mode: snippet -*-\n# name: Simple Key\n# key: skelton-cli\nimport argparse\nimport sys\n\n\ndef parse_args(args):\n    parser = argparse.ArgumentParser()\n    parser.parse_args(args)\n\n\ndef main(args):\n    parser = parse_args(args)\n\n\nif __name__ == '__main__':\n    main(sys.argv[1:])\n" "skelton-cli.yasnippet" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/skelton-cli.yasnippet" nil nil)
		       ("!!" "#!/usr/bin/env python3" "Python shbang" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/shbang" nil nil)
		       ("se" "sys.exit(${0:1})" "System exit" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/se" nil nil)
		       ("p" "print($0)" "print" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/print" "M-p" nil)
		       ("pp" "from pprint import pprint as p\np($0)\n" "Pretty Print" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/pp" nil nil)
		       ("pd" "from pprint import pprint as p\np(dir($0))" "PPRINT with dir" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/pd" nil nil)
		       ("ifmain" "if __name__ == '__main__':\n    $0\n" "ifmain" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/ifmain" nil nil)
		       ("header" "# -*- coding: utf-8 -*-\n# Author: Chmouel Boudjnah <`(yas--magit-email-or-default)`>\n#\n# Licensed under the Apache License, Version 2.0 (the \"License\"); you may\n# not use this file except in compliance with the License. You may obtain\n# a copy of the License at\n#\n#      http://www.apache.org/licenses/LICENSE-2.0\n#\n# Unless required by applicable law or agreed to in writing, software\n# distributed under the License is distributed on an \"AS IS\" BASIS, WITHOUT\n# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the\n# License for the specific language governing permissions and limitations\n# under the License.\n" "header" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/header" nil nil)
		       ("exc" "class $0(Exception):\n    pass\n" "Exceptions" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/exc" nil nil)
		       ("defs" "def ${1:name}(self):\n    $0\n" "Function in self" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/defs" nil nil)
		       ("defa" "def ${1:name}(${2:arg}):\n    ${0}" "Function with argument" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/defa" nil nil)
		       ("dbgos" "import IPython;IPython.embed()\n" "Debug ipython" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/dbgos" nil nil)
		       ("dbg" "import pdb; pdb.set_trace()\n" "Debug PDB" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/dbg" nil nil)
		       ("cl" "class ${1:ClassName}(object):\n    def __init__(self):\n        $0\n" "Class" nil nil nil "/Users/chmouel/.emacs.d/snippets/python-mode/cl" nil nil)))


;;; Do not edit! File generated at Wed Feb 24 15:49:22 2021

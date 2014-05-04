source_highlight = ['abap', 'actionscript', 'ada', 'apache', 'applescript', 'asm', 'asp', 'autoit', 'bash', 'basic4gl', 'bf', 'blitzbasic', 'bnf', 'c', 'c_mac', 'caddcl', 'cadlisp', 'cfdg', 'cfm', 'cil', 'cobol', 'cpp-qt', 'cpp', 'csharp', 'css', 'd', 'delphi', 'diff', 'div', 'dos', 'dot', 'eiffel', 'fortran', 'freebasic', 'genero', 'gettext', 'glsl', 'gml', 'gnuplot', 'groovy', 'haskell', 'hq9plus', 'html4strict', 'html5', 'idl', 'ini', 'inno', 'intercal', 'io', 'java', 'java5', 'javascript', 'kixtart', 'klonec', 'klonecpp', 'latex', 'lisp', 'lolcode', 'lotusscript', 'lua', 'Code', 'm68k', 'make', 'matlab', 'mirc', 'mxml', 'mpasm', 'mysql', 'nsis', 'objc', 'ocaml-brief', 'ocaml', 'oobas', 'oracle8', 'oracle11', 'pascal', 'per', 'perl', 'php-brief', 'php', 'pixelbender', 'plsql', 'povray', 'powershell', 'progress', 'prolog', 'providex', 'python', 'qbasic', 'rails', 'reg', 'robots', 'ruby', 'sas', 'scala', 'scheme', 'scilab', 'sdlbasic', 'smalltalk', 'smarty', 'sql', 'tcl', 'teraterm', 'text', 'thinbasic', 'tsql', 'typoscript', 'vb', 'vbnet', 'verilog', 'vhdl', 'vim', 'visualfoxpro', 'visualprolog', 'whitespace', 'winbatch', 'xml', 'xorg_conf', 'xpp', 'z80']

def complete (t, opts):
  if t:
    opts = [m[len(t):] for m in opts if m.startswith(t)]
  if len(opts) == 1:
    return opts[0]
  return "(" + "|".join(opts) + ")"

def replace (t, lookup):
  for k in lookup.keys():
    if k.startswith(t):
      return lookup[k]
  else:
      return ""

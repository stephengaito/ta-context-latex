-- Copyright 2017 Stephen Gaito. See License.md

local function initLaTeX(lexerName)
  if lexerName == 'latex' then
    -- Initialization for the LaTeX module

    -- add in latex specific key codes
    keys['latex'] = keys.latex or {}
    keys.latex.cg = require('latex/ctags').goto_symbol    -- Ctrl-g
    --keys.latex[not OSX and (GUI and 'cR' or 'cmr') or 'mR'] = require('common/clearMBuffer').clearMessageBufferRunCompile
    keys.latex['cR'] = require('common/clearMBuffer').clearMessageBufferRunCompile

    -- remove the default mapping from *.tex to pdflatex
    textadept.run.compile_commands.tex = nil

    -- add the mapping from the latex lexer to pdflatex
    textadept.run.compile_commands['latex'] = 'pdflatex %f'

    -- add some latex snippets
    snippets['latex'] = snippets['latex'] or {}
    snippets.latex['begin']   = 'begin{%1}\n%0\n\\end{%1}'
    snippets.latex['itemize'] = 'begin{itemize}\n\t\\item %0\n\\end{itemize}'
    snippets.latex['enum']    = 'begin{enumerate}\n\t\\item %0\n\\end{enumerate}'
    snippets.latex['emph']    = 'emph{%1}'
    snippets.latex['bold']    = 'textbf{%1}'
    snippets.latex['doc']     = 'documentclass[%1(a4,12pt)]{%2(amsart)}\n\n\\begin{document}\n\n%0\n\n\\end{document}'
    snippets.latex['chap']    = 'chapter{%1}\n'
    snippets.latex['sec']     = 'section{%1}\n'
    snippets.latex['ssec']    = 'subsection{%1}\n'
    snippets.latex['toc']     = 'tableofcontents\n'
  end
end



events.connect(events.LEXER_LOADED, initLaTeX)

return {}

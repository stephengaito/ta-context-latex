-- Copyright 2017 Stephen Gaito. See License.md

local M = { }

local function initLuaTeX(lexerName)
  if lexerName == 'luatex' then
    -- Initialization for the LuaTeX module

    -- add in luatex specific key codes
    keys['luatex'] = keys.context or {}
    -- keys.luatex.cg = require('context/ctags').goto_symbol    -- Ctrl-g
    --keys.luatex[not OSX and (GUI and 'cR' or 'cmr') or 'mR'] = require('common/clearMBuffer').clearMessageBufferRunCompile
    keys.luatex['cR'] = require('common/clearMBuffer').clearMessageBufferRunCompile
    
    -- remove the default mapping from *.tex to pdflatex
    textadept.run.compile_commands.tex = nil

    -- add the mapping from the context lexer to context
    textadept.run.compile_commands['luatex'] = 'luatex %f'


    
    -- add some luatex snippets
    snippets['luatex'] = snippets['luatex'] or {}
    snippets.luatex['start']   = 'start%1\n%0\n\\stop%1'
    snippets.luatex['itemize'] = 'startitemize\n\t%0\n\\stopitemize'
    snippets.luatex['enum']    = 'startenumerate\n\t%0\n\\stopenumerate'
    snippets.luatex['emph']    = 'emph{%0}'
    snippets.luatex['bold']    = 'textbf{%0}'
    snippets.luatex['doc']     = '????'
    snippets.luatex['chap']    = 'startchapter[title={%1}]\n%0\n\\stopchapter'
    snippets.luatex['sec']     = 'startsection[title={%1}]\n%0\n\\stopsection'
    snippets.luatex['ssec']    = 'startsubsection[title={%1}]\n%0\n\\stopsubsection'
    snippets.luatex['toc']     = 'tableofcontents'

    -- add comment string for context
    textadept.editing.comment_string['luatex'] = '%'
  end
end

events.connect(events.LEXER_LOADED, initLuaTeX)

return M

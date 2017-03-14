-- Copyright 2017 Stephen Gaito. See License.md

local M = { }

local function initContextMkIV(lexerName)
  if lexerName == 'contextMkIV' then
    -- Initialization for the contextMkIV module

    -- add in ContextMkIV specific key codes
    keys['contextMkIV'] = keys.context or {}
    -- keys.context.cg = require('context/ctags').goto_symbol    -- Ctrl-g
    --keys.context[not OSX and (GUI and 'cR' or 'cmr') or 'mR'] = require('common/messageBuffer').clearRunCompile
    keys.contextMkIV['cR'] = require('common/messageBuffer').clearRunCompile
    
    -- add the mapping from the contextMkIV lexer to context
    textadept.run.compile_commands['contextMkIV'] = 'mtxrun --script modules --process %f'
    textadept.run.run_commands['contextMkIV']     = WIN32 and 'start "" "%e-mkiv.pdf"' or OSX and 'open "%e-mkiv.pdf"' or 'xdg-open "%e-mkiv.pdf"'
    
    -- add some latex snippets
    snippets['contextMkIV']         = snippets['contextMkIV'] or {}
    snippets.contextMkIV['start']   = 'start%1\n%0\n\\stop%1'
    snippets.contextMkIV['itemize'] = 'startitemize\n\t%0\n\\stopitemize'
    snippets.contextMkIV['enum']    = 'startenumerate\n\t%0\n\\stopenumerate'
    snippets.contextMkIV['emph']    = 'emph{%0}'
    snippets.contextMkIV['bold']    = 'textbf{%0}'
    snippets.contextMkIV['doc']     = '????'
    snippets.contextMkIV['chap']    = 'startchapter[title={%1}]\n%0\n\\stopchapter'
    snippets.contextMkIV['sec']     = 'startsection[title={%1}]\n%0\n\\stopsection'
    snippets.contextMkIV['ssec']    = 'startsubsection[title={%1}]\n%0\n\\stopsubsection'
    snippets.contextMkIV['toc']     = 'tableofcontents'

    -- add comment string for context
    textadept.editing.comment_string['contextMkIV'] = '%'
  end
end

events.connect(events.LEXER_LOADED, initContextMkIV)

return M

-- Copyright 2017 Stephen Gaito. See License.md

local M = { }

local function buildConTeXt()
  io.save_file()
  local origBuffer = buffer
  local firstLine = buffer:get_line(0)
  ui.print(firstLine)
  local masterFile = firstLine:lower():match('%[%s*master%s+document%s*%:%s*(%S+)%s*%]')
  if masterFile then
    ui.print('running ConTeXt on: ['..masterFile..']\n')
    textadept.run.compile(masterFile)
  else
    ui.print("NO MASTER FILE FOUND\n")
    if origBuffer.filename then
      ui.print(origBuffer.filename)
    else
      ui.print("NO BUFFER FILENAME FOUND\n")
    end
  end
end

local function initConTeXt(lexerName)
  if lexerName == 'context' then
    -- Initialization for the ConTeXt module

    -- add in latex specific key codes
    keys['context'] = keys.context or {}
    -- keys.context.cg = require('context/ctags').goto_symbol    -- Ctrl-g
    --keys.context[not OSX and (GUI and 'cR' or 'cmr') or 'mR'] = require('common/clearMBuffer').clearMessageBufferRunCompile
    keys.context['cR'] = require('common/clearMBuffer').clearMessageBufferRunCompile
    keys.context['cB'] = buildConTeXt
    
    -- add the mapping from the context lexer to context
    textadept.run.compile_commands['context'] = 'context %f'

    -- add some latex snippets
    snippets['context'] = snippets['context'] or {}
    snippets.context['start']   = 'start%1\n%0\n\\stop%1'
    snippets.context['itemize'] = 'startitemize\n\t%0\n\\stopitemize'
    snippets.context['enum']    = 'startenumerate\n\t%0\n\\stopenumerate'
    snippets.context['emph']    = 'emph{%0}'
    snippets.context['bold']    = 'textbf{%0}'
    snippets.context['doc']     = '????'
    snippets.context['chap']    = 'startchapter[title={%1}]\n%0\n\\stopchapter'
    snippets.context['sec']     = 'startsection[title={%1}]\n%0\n\\stopsection'
    snippets.context['ssec']    = 'startsubsection[title={%1}]\n%0\n\\stopsubsection'
    snippets.context['toc']     = 'tableofcontents'

    -- add comment string for context
    textadept.editing.comment_string['context'] = '%'
  end
end

events.connect(events.LEXER_LOADED, initConTeXt)

return M

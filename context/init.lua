-- Copyright 2017 Stephen Gaito. See License.md

local M = { }

local function buildConTeXt()
  --
  -- save buffer 
  --
  io.save_file()
  local origBuffer = buffer
  local origFileName = buffer.filename
  local masterFileName = origFileName
  --
  -- open the master file (if any)
  --
  local firstLine = origBuffer:get_line(0)
  local masterFile = firstLine:match('%[%s*[Mm][Aa][Ss][Tt][Ee][Rr]%s+[Dd][Oo][Cc][Uu][Mm][Ee][Nn][Tt]%s*%:%s*(%S+)%s*%]')
  if masterFile then
    local absDir = lfs.currentdir()
    if origFileName then
      absDir = origFileName:gsub('%/[^%/]+$', '')
    end
    masterFileName = lfs.abspath(masterFile, absDir)
    ui.goto_file(masterFileName)
  end
  --
  -- compile it
  --
  require('common/messageBuffer').clearRunCompile()
end

local function initConTeXt(lexerName)
  if lexerName == 'context' then
    -- Initialization for the ConTeXt module

    -- add in latex specific key codes
    keys['context'] = keys.context or {}
    -- keys.context.cg = require('context/ctags').goto_symbol    -- Ctrl-g
    --keys.context[not OSX and (GUI and 'cR' or 'cmr') or 'mR'] = require('common/messageBuffer').clearRunCompile
    keys.context['cR'] = require('common/messageBuffer').clearRunCompile
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

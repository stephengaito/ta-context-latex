-- Copyright 2011-2012 Nils Nordman <nino at nordman.org>
-- Copyright 2012-2013 Robert Gieseke <robert.gieseke@gmail.com>
-- Copyright 2012-2014 Robert Gieseke <rob.g@web.de>
-- Copyright 2017 Stephen Gaito <stephen@perceptisys.co.uk>
--
-- License: MIT
--
-- Permission is hereby granted, free of charge, to any person obtaining a 
-- copy of this software and associated documentation files (the 
-- "Software"), to deal in the Software without restriction, including 
-- without limitation the rights to use, copy, modify, merge, publish, 
-- distribute, sublicense, and/or sell copies of the Software, and to 
-- permit persons to whom the Software is furnished to do so, subject to 
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be included 
-- in all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--
-- Taken from the ctags.lua file (commit c2410af) in the 
-- [Textredux](http://rgieseke.github.io/textredux/) distribution on 
-- 2017/02/06.
--

--[[--
Displays a filtered list of symbols (functions, variables, …) in the current
document using [Exuberant Ctags](http://ctags.sourceforge.net/).

Usage
-----

In your init.lua:

    local textredux = require 'textredux'
    keys.cg = textredux.ctags.goto_symbol -- Ctrl+G

Requirements
------------

Exuberant Ctags needs to be installed and is available in the
usual package managers.

Debian/Ubuntu:

    sudo apt-get install exuberant-ctags

Homebrew on OS X:

    brew install ctags

Note that it is possible to add support for additional filetypes in your
`~/.ctags`, for example LaTeX:

    --langdef=latex
    --langmap=latex:.tex
    --regex-latex=/\\label\{([^}]*)\}/\1/l,label/
    --regex-latex=/\\section\{([^}]*)\}/\1/s,section/
    --regex-latex=/\\subsection\{([^}]*)\}/\1/t,subsection/
    --regex-latex=/\\subsubsection\{([^}]*)\}/\1/u,subsubsection/
    --regex-latex=/\\section\*\{([^}]*)\}/\1/s,section/
    --regex-latex=/\\subsection\*\{([^}]*)\}/\1/t,subsection/
    --regex-latex=/\\subsubsection\*\{([^}]*)\}/\1/u,subsubsection/

This module is based on Mitchell's ctags code posted on the
[Textadept wiki](http://foicica.com/wiki/ctags).

@module textredux.ctags
]]

local M = {}

local reduxstyle = require 'textredux.core.style'
local reduxlist = require 'textredux.core.list'

---
-- Path and options for the ctags call can be defined in the `CTAGS`
-- field.
M.CTAGS = 'ctags --options=' .. _USERHOME ..'/modules/latex/latex.ctags --language-force=latex --sort=yes --fields=+K-f'

---
-- Mappings from Ctags kind to Textredux styles.
M.styles = {
  class = reduxstyle.class,
  enum = reduxstyle['type'],
  enumerator = reduxstyle['type'],
  ['function'] = reduxstyle['function'],
  procedure = reduxstyle['function'],
  method = reduxstyle['function'],
  field = reduxstyle.variable,
  member = reduxstyle.variable,
  macro = reduxstyle.operator,
  namespace = reduxstyle.preproc,
  typedef = reduxstyle.keyword,
  variable = reduxstyle.variable
}

-- Close the Textredux list and jump to the selected line in the origin buffer.
local function on_selection(list, item)
  local line = item[3]
  if line then
    ui.statusbar_text = line
    list:close()
    buffer:goto_line(tonumber(line) - 1)
    buffer:vertical_centre_caret()
  end
end

-- Return color for Ctags kind.
local function get_item_style(item, column_index)
  -- Use a capture to find fields like `function namespace:…`.
  local kind = item[2]:match('(%a+)%s?')
  return M.styles[kind] or reduxstyle.default
end

---
-- Goes to the selected symbol in a filtered list dialog.
-- Requires [ctags]((http://ctags.sourceforge.net/)) to be installed.
function M.goto_symbol()
  if not buffer.filename then return end
  if package.loaded['textredux'] == nil then return end
  
  local symbols = {}
  local p = spawn(M.CTAGS..' --sort=no --excmd=number -f - "'..buffer.filename..'"')
  for line in p:read('*all'):gmatch('[^\r\n]+') do
    local name, line, ext = line:match('^(%S+)\t[^\t]+\t([^;]+);"\t(.+)$')
    if name and line and ext then
      symbols[#symbols + 1] = {name, ext, line}
    end
  end
  if #symbols > 0 then
    local list = reduxlist.new('Go to symbol')
    list.items = symbols
    list.on_selection = on_selection
    list.column_styles = { reduxstyle.default, get_item_style }
    list:show()
  end
end

return M

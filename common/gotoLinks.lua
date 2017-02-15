-- Copyright 2017 Stephen Gaito. See License.md
-- This code has been modeled on ctags.lua from the
-- [Textredux](http://rgieseke.github.io/textredux/)

M = {}

local reduxstyle = require 'textredux.core.style'
local reduxlist  = require 'textredux.core.list'

M.links     = {} -- array of all links
M.linkUrls  = {} -- table of linkName->linkUrl

local function on_selection(list, item)
  local linkName = item[1]
  list:close()
  -- The following two lines were taken from textadept.menu.open_page
  local cmd = (WIN32 and 'start ""') or (OSX and 'open') or 'xdg-open'
  spawn(string.format('%s "%s"', cmd, M.linkUrls[linkName]))
end

local function trimStr(aString)
  return aString:match("^[ \t]*(.+)[ \t]*$")
  end

function M.goto_link()
  local lexerName = buffer:get_lexer(false)
  M.links     = {}
  M.linkUrls  = {}
  local linkState = 1
  local linkName  = nil
  local linkUrl   = nil
  local linkDesc  = {}
  local linkFileName = _USERHOME .. '/modules/' .. lexerName .. '/links.txt'
  
  -- check to see if the file can be opened 
  local linkFile = io.open(linkFileName)
  if linkFile == nil then return end

  -- if Textredux is not loaded...
  -- simply open the links file in read only mode
  if package.loaded['textredux'] == nil then
    io.close(linkFile)
    io.open_file(linkFileName)
    buffer.read_only = true
    return
  end
  
  for line in linkFile:lines() do
    if not line:match("^[ t]*#") then
      if line:match("^[ \t]*$") then -- we have finished a link
        if linkName then
          M.links[#M.links+1] = {linkName, table.concat(linkDesc, " ")}
          M.linkUrls[linkName] = linkUrl
          linkState = 1 -- restart
          linkName  = nil
          linkUrl   = nil
          linkDesc  = {}
        end
      else -- we are in the middle of a link...
        if linkState == 1 then
          linkName = trimStr(line)
          linkState = 2
        elseif linkState == 2 then
          linkUrl = trimStr(line)
          linkState = 3
        else
          aDesc = trimStr(line)
          if aDesc then
            linkDesc[#linkDesc+1] = aDesc
          end
        end
      end
    end
  end
  
  -- add last link
  if linkName then
    M.links[#M.links+1] = {linkName, table.concat(linkDesc, " ")}
    M.linkUrls[linkName] = linkUrl
  end
  
  -- now show in a reduxlist
  if #M.links > 0 then
    local list = reduxlist.new('Go to link')
    list.items = M.links
    list.on_selection = on_selection
    list.column_styles = { reduxstyle.default}
    list:show()
  end
end

return M

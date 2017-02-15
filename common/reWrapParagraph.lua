-- Copyright 2017 Stephen Gaito. See License.md

local M = {}

-- The default text width
M.textWidth = 78

-- Append a value (string) to a table for later concating
--
function M.append(aTable, aValue)
  aTable[#aTable+1] = aValue
end

-- Split a text into component "words" by splitting on white space
-- inspired by http://lua-users.org/wiki/SplitJoin
-- Example: M.splitOnWhiteSpace("this is\ta\ntest ")
--
function M.splitOnWhiteSpace(aString)
  local fields = {}
  local sep = "%s"
  local pattern = string.format("([^%s]+)", sep)
  aString:gsub(pattern, function(c) M.append(fields, c) end)
  return fields
end

-- ReWrap the text provided
-- Example:
-- M.reWrapText("this is a very long sentence which is made longer by adding some additional words.", 20)
--
function M.reWrapText(origText, textWidth)
  local words = M.splitOnWhiteSpace(origText)
  local newText = {}
  local lineLength = 0
  for i, aWord in ipairs(words) do
    if textWidth < (lineLength + aWord:len() + 1) then
      M.append(newText, "\n")
      M.append(newText, aWord)
      M.append(newText, " ")
      lineLength = aWord:len() + 1
    else
      M.append(newText, aWord)
      M.append(newText, " ")
      lineLength = lineLength + aWord:len() + 1
    end
  end
  --M.append(newText, "\n")
  return table.concat(newText)
end

--
-- The actual re wrap selection which can be called from a key code
--
function M.reWrapSelection()
  local origText = buffer:get_sel_text()
  local newText = M.reWrapText(buffer:get_sel_text(), M.textWidth)
  buffer:replace_sel(newText)
  buffer:new_line()
  buffer:new_line()
end
--
-- ReWrap the paragraph which contains the current position
-- This function can be called from a key code
--
function M.reWrapParagraph()
  textadept.editing.select_paragraph()
  M.reWrapSelection()
end

return M

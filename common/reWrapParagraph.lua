-- Copyright 2017 Stephen Gaito. See License.md

local M = {}

-- The default text width
M.textWidth = 75

-- Append a value (string) to a table for later concatenating
--
local function appendValue(aTable, aValue)
  aTable[#aTable+1] = aValue
end

-- Split a collection of strings into component "words"
-- by splitting on white space
-- inspired by http://lua-users.org/wiki/SplitJoin
-- Example: splitOnWhiteSpace("this is\ta\ntest ")
--
local function splitIntoWords(someStrings)
  local someWords = {}
  for i, aString in ipairs(someStrings) do
    aString:gsub("([^%s]+)", function(c) appendValue(someWords, c) end)
  end
  return someWords
end


-- Split a string into component "lines" 
-- by splitting on control characters
--
local function splitIntoLines(aString)
  local someLines = {}
  aString:gsub("([^%c]+)", function(c) appendValue(someLines, c) end)
  return someLines
end

-- ReWrap the text provided as a collection of words
-- returns a table of the re-wrapped lines of text
--
local function reWrapWords(someWords, textWidth, commentIndicator)
  --
  -- add a space to the commentIndicator
  --
  if type(commentIndicator) ~= 'string' then commentIndicator = '' end
  if 0 < commentIndicator:len() then commentIndicator = commentIndicator..' ' end
  local commentIndicatorLen = commentIndicator:len()
  --
  -- now re-wrap the text
  --
  local newText = {}
  appendValue(newText, commentIndicator)
  local lineLength = commentIndicatorLen
  for i, aWord in ipairs(someWords) do
    if textWidth < (lineLength + aWord:len() + 1) then
      appendValue(newText, "\n")
      appendValue(newText, commentIndicator)
      appendValue(newText, aWord)
      appendValue(newText, " ")
      lineLength = commentIndicatorLen + aWord:len() + 1
    else
      appendValue(newText, aWord)
      appendValue(newText, " ")
      lineLength = lineLength + aWord:len() + 1
    end
  end
  return table.concat(newText)
end

local function removeCommentIndicators(someLines)
  local uncommentedText = {}
  local commentIndicators = {}
  local bufferLexer = buffer.get_lexer(buffer, false)
  local commentChar = textadept.editing.comment_string[bufferLexer] or ''
  if not commentChar:find('|') then
    local commentCharPattern = commentChar:gsub('%%', '%%%%')
    local commentPattern = string.format("^(%s[^%s]*)", commentCharPattern, "%s")
    for i, aLine in ipairs(someLines) do
      local newLine = aLine:gsub(commentPattern, function(c)
        commentIndicators[#commentIndicators+1] = c
        return ''
      end)
      appendValue(uncommentedText, newLine)
    end
  else
    uncommentedText = origText
  end
  local commentIndicator = commentIndicators[1] or ''
  return commentIndicator, uncommentedText
end
--
-- The actual re wrap selection which can be called from a key code
--
function M.reWrapSelection()
  --
  -- get the original text and split it into lines
  --
  local origText = splitIntoLines(buffer:get_sel_text())
  --
  -- determine and remove the comment indicators
  --
  local commentIndicator, uncommentedText = removeCommentIndicators(origText)
  --
  -- re-wrap the text
  --
  local someWords = splitIntoWords(uncommentedText)
  local newText = reWrapWords(someWords, M.textWidth, commentIndicator)
  --
  -- put the re-wrapped text back into the buffer
  --
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

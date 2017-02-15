-- Copyright 2017 Stephen Gaito. See License.md

local M = {}

local function clearMessageBuffer()
  local buffer_type = _L['[Message Buffer]']
  local print_buffer
  for i = 1, #_BUFFERS do
    if _BUFFERS[i]._type == buffer_type then
      print_buffer = _BUFFERS[i]
      break
    end
  end
  if print_buffer then
    print_buffer:set_text("")
  end
end

function M.clearMessageBufferRunCompile()
  clearMessageBuffer()
  textadept.run.compile()
end

return M
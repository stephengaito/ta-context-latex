-- Copyright 2017 Stephen Gaito. See License.md

local M = {}

function M.findMessageBuffer()
  local buffer_type = _L['[Message Buffer]']
  local message_buffer
  for i = 1, #_BUFFERS do
    if _BUFFERS[i]._type == buffer_type then
      message_buffer = _BUFFERS[i]
      break
    end
  end
  return message_buffer
end

function M.clearMessageBuffer()
  local message_buffer = M.findMessageBuffer()
  if message_buffer then message_buffer:set_text("") end
end

function M.printMessageBuffer(message)
  local message_buffer = M.findMessageBuffer()
  if message_buffer then message_buffer:append_text(message) end
end

function M.clearMessageBufferRunCompile()
  M.clearMessageBuffer()
  textadept.run.compile()
end

return M
-- Copyright 2017 Stephen Gaito. See License.md

local M = {}

function M.find()
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

function M.clear()
  local message_buffer = M.find()
  if message_buffer then message_buffer:set_text("") end
end

function M.print(message)
  local message_buffer = M.find()
  if message_buffer then
    message_buffer:append_text(message)
    message_buffer.modify(false)
  end
end

function M.clearRunCompile()
  M.clear()
  textadept.run.compile()
end

return M
-- check-port.nse
local nmap   = require "nmap"
local stdnse = require "stdnse"
local shortport = require "shortport"

local arg_port = tonumber(stdnse.get_script_args("checkport.port")) or 80

portrule = function(host, port)
  return port.number == arg_port
end

action = function(host, port)
  if port.state ~= "open" then
    return ("port %d closed on %s"):format(port.number, host.ip or host.targetname)
  end

  local s, err = nmap.new_socket()
  if not s then
    return ("socket error: %s"):format(err or "unknown")
  end

  s:set_timeout(3000)
  local ok, cerr = s:connect(host.ip, port.number)
  if not ok then
    s:close()
    return ("connect failed: %s"):format(cerr or "unknown")
  end

  local status, data = pcall(function() return s:receive(512) end)
  s:close()

  if status and data and #data > 0 then
    data = data:gsub("%s+", " ")
    return ("port %d open — banner: %q"):format(port.number, data)
  end

  return ("port %d open — no banner"):format(port.number)
end


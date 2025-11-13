local M = {}
function M.file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function M.basename(s)
  if not s or s == '' then return 'unknown' end
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

-- Get shortened working directory
-- Given "/Users/foo/projects/myapp/src" returns "~/projects/myapp/src"
-- Given "/home/foo/bar/baz/qux" returns "~/bar/baz/qux"
function M.smart_cwd(cwd, home_dir)
  if not cwd or cwd == '' then return '~' end

  -- Replace home directory with ~
  if home_dir and cwd:sub(1, #home_dir) == home_dir then
    cwd = '~' .. cwd:sub(#home_dir + 1)
  end

  -- Shorten to last 3 path components
  local parts = {}
  for part in string.gmatch(cwd, '[^/\\]+') do
    table.insert(parts, part)
  end

  if #parts > 3 then
    local shortened = {}
    for i = #parts - 2, #parts do
      table.insert(shortened, parts[i])
    end
    return '.../' .. table.concat(shortened, '/')
  end

  return cwd
end

return M

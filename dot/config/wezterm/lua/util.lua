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
-- Given "/Users/foo/projects/myapp/src" returns "~/.../myapp/src"
-- Given "/home/foo/bar/baz/qux" returns "~/.../baz/qux"
-- Given "/home/foo/a/b/c/d/e" returns "~/.../d/e"
function M.smart_cwd(cwd, home_dir)
  if not cwd or cwd == '' then return '~' end

  local prefix = ''
  -- Replace home directory with ~
  if home_dir and cwd:sub(1, #home_dir) == home_dir then
    prefix = '~'
    cwd = cwd:sub(#home_dir + 1)
  end

  -- Shorten to last 2 path components
  local parts = {}
  for part in string.gmatch(cwd, '[^/\\]+') do
    if part ~= '' then  -- skip empty parts
      table.insert(parts, part)
    end
  end

  if #parts > 2 then
    local shortened = {}
    for i = #parts - 1, #parts do
      table.insert(shortened, parts[i])
    end
    return prefix .. '/.../' .. table.concat(shortened, '/')
  end

  if #parts > 0 then
    return prefix .. '/' .. table.concat(parts, '/')
  end

  return prefix ~= '' and prefix or '/'
end

return M

-- Patch for nvim-treesitter/nvim-treesitter#8636
--
-- In nvim 0.12, Query:iter_matches() removed the `all` option and now
-- always returns matches as lists of nodes ({node}) instead of single
-- nodes. nvim-treesitter's query_predicates.lua still treats match[id]
-- as a single TSNode, causing "attempt to call method 'range' (a nil
-- value)" crashes on every markdown file with fenced code blocks.
--
-- The upstream repo was archived on 2026-04-03 and will never be fixed.
-- This patch is re-applied automatically via the nvim-treesitter build hook.

local target = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/lua/nvim-treesitter/query_predicates.lua"

local f = io.open(target, "r")
if not f then
  vim.notify("nvim-treesitter patch: could not open " .. target, vim.log.levels.WARN)
  return
end
local src = f:read("*a")
f:close()

-- Bail out if the patch was already applied (check for function definition)
if src:find("local function get_match_node", 1, true) then
  return
end

-- 1. Remove the `all = false` option that no longer exists in nvim 0.12
src = src:gsub(
  "{ force = true, all = false }",
  "{ force = true }"
)

-- 2. Inject the helper function after the `return true` that ends valid_args,
--    using a unique anchor line that exists only once in the file.
local helper = "\n-- nvim 0.12 compat: iter_matches() now returns lists of nodes, not single nodes.\n"
  .. "local function get_match_node(match, id)\n"
  .. "  local val = match[id]\n"
  .. "  if type(val) == \"table\" then return val[1] end\n"
  .. "  return val\n"
  .. "end\n"
src = src:gsub(
  "(  return true\nend\n)",
  "%1" .. helper,
  1 -- only replace the first occurrence (end of valid_args)
)

-- 3. Replace match[...] lookups with get_match_node(match, ...)
--    Match `match[<expr>]` where <expr> may itself contain brackets (e.g. pred[2]).
--    Use a line-by-line approach to avoid greedy/nested bracket issues.
local lines = {}
for line in (src .. "\n"):gmatch("([^\n]*)\n") do
  -- Replace `local node = match[X]` where X is the full expression up to the last ]
  local replaced = line:gsub("local node = match%[(.-)%]%s*$", function(expr)
    return "local node = get_match_node(match, " .. expr .. ")"
  end)
  -- Also handle trailing comment: `local node = match[X] ---@type TSNode`
  replaced = replaced:gsub("local node = match%[(.-)%]%s*(%-%-%-@)", function(expr, comment)
    return "local node = get_match_node(match, " .. expr .. ") " .. comment
  end)
  table.insert(lines, replaced)
end
src = table.concat(lines, "\n")

local out = io.open(target, "w")
if not out then
  vim.notify("nvim-treesitter patch: could not write " .. target, vim.log.levels.WARN)
  return
end
out:write(src)
out:close()

-- Incremental selection by syntax node, the treesitter equivalent of what
-- vim-expand-region did in the vim config. Bound to <C-k> / <C-j>.

local M = {}

-- Per-buffer stack of previously selected ranges, so shrinking can retrace the
-- exact path expansion took.
local stacks = {}

local function line_length(row)
  return #(vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or "")
end

-- Ranges are {start_row, start_col, end_row, end_col}, zero-indexed with an
-- exclusive end column, matching treesitter.
local function range_of(node)
  local sr, sc, er, ec = node:range()
  return { sr, sc, er, ec }
end

local function grows(outer, inner)
  local starts_at_or_before = outer[1] < inner[1] or (outer[1] == inner[1] and outer[2] <= inner[2])
  local ends_at_or_after = outer[3] > inner[3] or (outer[3] == inner[3] and outer[4] >= inner[4])
  local identical = outer[1] == inner[1]
    and outer[2] == inner[2]
    and outer[3] == inner[3]
    and outer[4] == inner[4]
  return starts_at_or_before and ends_at_or_after and not identical
end

local function current_range()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    return { row - 1, col, row - 1, col + 1 }
  end

  local anchor, cursor = vim.fn.getpos("v"), vim.fn.getpos(".")
  local sr, sc = anchor[2] - 1, anchor[3] - 1
  local er, ec = cursor[2] - 1, cursor[3] - 1
  if sr > er or (sr == er and sc > ec) then
    sr, sc, er, ec = er, ec, sr, sc
  end
  if mode == "V" then
    sc, ec = 0, math.max(line_length(er) - 1, 0)
  end
  return { sr, sc, er, ec + 1 }
end

local function select_range(range)
  local er, ec = range[3], range[4]
  if ec == 0 and er > range[1] then
    er = er - 1
    ec = line_length(er)
  end
  ec = math.max(ec - 1, 0)

  local mode = vim.fn.mode()
  if mode == "V" or mode == "\22" then
    -- Drop to charwise without leaving visual mode.
    vim.cmd("normal! v")
    mode = "v"
  end

  if mode == "v" then
    vim.cmd("normal! o")
    vim.api.nvim_win_set_cursor(0, { range[1] + 1, range[2] })
    vim.cmd("normal! o")
  else
    vim.api.nvim_win_set_cursor(0, { range[1] + 1, range[2] })
    vim.cmd("normal! v")
  end
  vim.api.nvim_win_set_cursor(0, { er + 1, ec })
end

local function smallest_node_covering(range)
  local ok, parser = pcall(vim.treesitter.get_parser, 0)
  if not ok or not parser then
    return nil
  end
  local trees = parser:parse(true)
  if not trees or not trees[1] then
    return nil
  end
  return trees[1]:root():named_descendant_for_range(range[1], range[2], range[3], range[4])
end

function M.expand()
  local buf = vim.api.nvim_get_current_buf()
  local in_visual = vim.fn.mode():match("[vV\22]") ~= nil
  if not in_visual then
    stacks[buf] = nil
  end

  local current = current_range()
  local node = smallest_node_covering(current)
  while node and not grows(range_of(node), current) do
    node = node:parent()
  end
  if not node then
    return
  end

  local stack = stacks[buf] or { current }
  table.insert(stack, range_of(node))
  stacks[buf] = stack
  select_range(stack[#stack])
end

function M.shrink()
  local buf = vim.api.nvim_get_current_buf()
  local stack = stacks[buf]
  if not stack or #stack < 2 then
    return
  end
  table.remove(stack)
  select_range(stack[#stack])
  if #stack == 1 then
    stacks[buf] = nil
  end
end

vim.api.nvim_create_autocmd("ModeChanged", {
  group = vim.api.nvim_create_augroup("dotfiles_selection", { clear = true }),
  pattern = { "v:*", "V:*", "\22:*" },
  callback = function(args)
    stacks[args.buf] = nil
  end,
})

return M

-- Table to track persistent state across toggles
local state = {
  win = -1,
  buf = -1,
}

local function toggle_floating_term(opts)
  opts = opts or {}

  -- 1. If the window is currently open, hide it
  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    return
  end

  -- 2. Calculate dimensions for 80% screen size centered
  local width_pct = opts.width or 0.8
  local height_pct = opts.height or 0.8

  local editor_width = vim.o.columns
  local editor_height = vim.o.lines

  local win_width = math.floor(editor_width * width_pct)
  local win_height = math.floor(editor_height * height_pct)

  local col = math.floor((editor_width - win_width) / 2)
  local row = math.floor((editor_height - win_height) / 2)

  -- 3. Reuse existing buffer, or create a new scratch buffer if it doesn't exist
  if not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
  end

  -- 4. Window configuration
  local win_opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  -- 5. Open window with our buffer
  state.win = vim.api.nvim_open_win(state.buf, true, win_opts)

  -- 6. Launch shell inside buffer if it isn't already running
  if vim.bo[state.buf].buftype ~= "terminal" then
    vim.cmd("terminal")
  end

  -- 7. Jump into insert mode automatically
  vim.cmd("startinsert")
end

-- ==========================================
-- Toggle Keymaps (Normal & Terminal Modes)
-- ==========================================

-- Map to both normal ("n") and terminal ("t") modes so <leader>t toggles it from anywhere
vim.keymap.set({ "n", "t" }, "<leader>t", function()
  toggle_floating_term()
end, { desc = "Toggle floating terminal" })

-- Esc keymap to drop out of insert mode in terminal
vim.keymap.set("t", "<esc>", "<c-\\><c-n>")

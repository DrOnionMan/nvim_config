vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Explore)


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
 --vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })






vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "j", "jzz")
vim.keymap.set("n", "k", "kzz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

vim.keymap.set("i", "<TAB>", "  ")




-- vim.keymap.set("n", "<leader>lt", function()
--   vim.cmd [[ PlenaryBustedFile % ]]
-- end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])


-- yanks to the sys clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>P", [["+p"]])


vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>b", "$A {\n}<Esc>O")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

local function get_visual_selection()
  local s = vim.fn.getpos("'<")
  local e = vim.fn.getpos("'>")
  local start_line = s[2]
  local start_col  = s[3]
  local end_line   = e[2]
  local end_col    = e[3]
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then
    return ""
  end
  if #lines == 1 then
    return string.sub(lines[1], start_col, end_col)
  end
  lines[1] = string.sub(lines[1], start_col)
  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  return table.concat(lines, " ")
end

local BROWSER = "msedge.exe"

local function lookup(opts, docsite)
  local word = get_visual_selection()
  if word == "" then
    vim.notify("No selection", vim.log.levels.WARN)
    return
  end
  local url = "https://www.google.com/search?q=" .. docsite .. " ".. word
  print("Search: ", url)
  -- wsl bs
  vim.fn.jobstart({ "cmd.exe", "/c", "start", "", BROWSER, url }, { detach = true })
end

local function decide_lookup(opts) 
  local ft = vim.bo.filetype
  if ft == "cpp" or ft == "hpp" or ft == "c" or ft == "h" then
    lookup(opts, "cppreference")  
    return
  elseif ft == "lua" then 
    lookup(opts, "lua")
    return
  elseif ft == "py" then
    lookup(opts, "python")
    return
  elseif ft == "sh" then
    lookup(opts, "bash")
    return
  else
    lookup(opts, "docs")
    return
  end
end


vim.api.nvim_create_user_command("LookUp", decide_lookup, { range = true })
vim.keymap.set("v", "<leader>lu", "<Esc>:LookUp<CR>", { silent = true })

















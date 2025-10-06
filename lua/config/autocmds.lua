-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local augroup = vim.api.nvim_create_augroup("TemplateTemplates", { clear = true })

local function create_template_autocmd(pattern, skeleton_path)
  vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    group = augroup,
    pattern = pattern,
    callback = function(opts)
      -- Check if the buffer is empty
      if vim.api.nvim_buf_line_count(opts.buf) == 1 and vim.api.nvim_buf_get_lines(opts.buf, 0, 1, false)[1] == "" then
        -- 1. Insert the template content
        vim.cmd('0read ' .. skeleton_path)

        -- 2. Logic specific to TSX to replace the component name placeholder
        if pattern:match('%.tsx$') then
          -- Get the full filename (e.g., 'MyComponent.tsx')
          local filename = vim.fn.expand('%:t')
          -- Remove the extension (e.g., 'MyComponent')
          local component_name = filename:gsub('%.tsx$', '')

          -- Perform the substitution: replace %ComponentName% with the actual name
          vim.cmd(string.format('%%s/%%ComponentName%%/%s/g', component_name))
        end

        -- 3. Final cleanup and cursor placement
        vim.opt_local.modified = false
        vim.cmd('normal! 5G') -- Move cursor to line 5
      end
    end,
  })
end

-- Add the new autocommand for TSX files:
create_template_autocmd("*.tsx", "~/.config/nvim/skeletons/react_component.tsx")

-- Keep your old ones
create_template_autocmd("*.sh", "~/.config/nvim/skeletons/bash.sh")
create_template_autocmd("*.cpp", "~/.config/nvim/skeletons/cpp.cpp")
-- ...

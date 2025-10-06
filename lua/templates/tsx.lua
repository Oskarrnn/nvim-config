-- ~/.config/nvim/lua/templates/typescript.lua

local utils = require("new-file-template.utils")

-- A function that generates your template content
-- It receives the file's path and filename as arguments
local function component_template(path, filename)
  -- You can use Neovim/Lua functions here to manipulate the filename
  local component_name = vim.split(filename, "%.")[1]   -- Remove the extension

  -- The triple-bracket syntax `[[ ... ]]` allows for multi-line strings
  -- The text `|cursor|` is a special placeholder that sets the cursor position
  return [[
import React from 'react';

interface ]] .. component_name .. [[Props {
  // Define your props here
}

export const ]] .. component_name .. [[ = (props: ]] .. component_name .. [[Props) => {
  return <div>|cursor|</div>;
};
]]
end

-- A function for a standard TypeScript file
local function base_template(path, filename)
  return [[
// ]] .. filename .. [[
|cursor|
]]
end

-- This is the function that the plugin calls
return function(opts)
  local template = {
    -- Pattern 1: For files named like 'MyComponent.tsx' inside a 'components' folder (case-insensitive)
    { pattern = "components/.*%.tsx", content = component_template },

    -- Pattern 2: The fallback for any other .ts or .tsx file
    { pattern = ".*",                 content = base_template },
  }

  -- utils.find_entry checks the patterns against the file path
  return utils.find_entry(template, opts)
end

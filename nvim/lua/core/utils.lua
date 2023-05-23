local M = {}

--- Set a keymap
--- Keymaps will be silent by default unless specified otherwise
---@param mode string|table<string> Mode(s) to apply this keymap
---@param keymap string Keymapping
---@param cmd string|function Operation to run for the keymap
---@param opts? table Options for this keymap
function M.map(mode, keymap, cmd, opts)
  local keys = require('lazy.core.handler').handlers.keys
  ---@cast keys LazyKeysHandler
  -- don't create the keymap if a lazy keys handler already exists
  if not keys.active[keys.parse({ keymap, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, keymap, cmd, opts)
  end
end

--- Check if a plugin is installed
---@param plugin_name string The name of the plugin to check
---@returns boolean
function M.has(plugin_name)
  return require('lazy.core.config').plugins[plugin_name] ~= nil
end

--- Get an icon if it is available
---@param icon string The icon to retrieve
---@param padding? integer Padding to add after an icon
---@return string icon
function M.get_icon(icon, padding)
  -- early return if icons are disabled
  if not vim.g.icons_enabled then
    return ''
  end
  -- load icons
  if not M.icons then
    M.icons = require('core.icons')
  end
  -- fetch icon
  local found_icon = M.icons[icon]
  -- add padding to icon if found
  return found_icon and found_icon .. string.rep(' ', padding or 0) or ''
end

--- Register queued which-key mappings
function M.which_key_register()
  if M.which_key_queue then
    local wk_avail, wk = pcall(require, "which-key")
    if wk_avail then
      for mode, registration in pairs(M.which_key_queue) do
        wk.register(registration, { mode = mode })
      end
      M.which_key_queue = nil
    end
  end
end

--- Table based API for setting keybindings
---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? table A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
  base = base or {}
  -- iterate over the first keys for each mode
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base
        if type(options) == 'table' then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend('force', keymap_opts, options)
          keymap_opts[1] = nil
        end
        if not cmd or keymap_opts.name then
          -- if which-key mapping, queue it
          if not M.which_key_queue then
            M.which_key_queue = {}
          end
          if not M.which_key_queue[mode] then
            M.which_key_queue[mode] = {}
          end
          M.which_key_queue[mode][keymap] = keymap_opts
        else
          -- if not which-key mapping, set it
          M.map(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
  -- if which-key is loaded already, register
  if package.loaded['which-key'] then
    M.which_key_register()
  end
end

return M

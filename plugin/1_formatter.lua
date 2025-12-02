local ready, formatter = pcall(require, "formatter")
if not ready then
  return
end

local util = require("formatter.util")
local mason_registry_ready, mason_registry = pcall(require, "mason-registry")
local warned_missing_pses = false

local function powershell_formatter()
  if not mason_registry_ready then
    if not warned_missing_pses then
      vim.notify("formatter: mason-registry not available; skip PowerShell formatting", vim.log.levels.WARN)
      warned_missing_pses = true
    end
    return nil
  end

  local ok, ps_pkg = pcall(mason_registry.get_package, "powershell-editor-services")
  if not ok then
    if not warned_missing_pses then
      vim.notify("formatter: powershell-editor-services is not installed via Mason", vim.log.levels.WARN)
      warned_missing_pses = true
    end
    return nil
  end

  local shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
  local module_path = ps_pkg:get_install_path() .. "/PowerShellEditorServices/PowerShellEditorServices.psd1"
  local command = string.format(
    "Import-Module '%s'; Invoke-Formatter -ScriptDefinition ([Console]::In.ReadToEnd())",
    module_path
  )

  return {
    exe = shell,
    args = {
      "-NoLogo",
      "-NoProfile",
      "-Command",
      command,
    },
    stdin = true,
  }
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end,
    },
    sh = {
      require("formatter.filetypes.sh").shfmt,
    },
    yaml = {
      require("formatter.filetypes.yaml").prettier,
    },
    ps1 = {
      powershell_formatter,
    },
    powershell = {
      powershell_formatter,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})

-- File: ~/.config/nvim/lua/plugins/winbar.lua

return {
  "nvim-tree/nvim-web-devicons",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local web_devicons = require("nvim-web-devicons")

    -- Global variable to store the active window ID
    _G.active_winid = vim.api.nvim_get_current_win()

    local function get_file_icon(bufnr)
      local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
      local extension = vim.fn.fnamemodify(file_name, ":e")
      local icon, icon_color = web_devicons.get_icon_color(file_name, extension)
      if icon then
        local hl_group = "FileIcon" .. bufnr
        vim.api.nvim_set_hl(0, hl_group, { fg = icon_color, bg = "NONE", default = true })
        return string.format("%%#%s#%s%%*", hl_group, icon)
      end
      return ""
    end

    local function get_filename(bufnr)
      local file_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
      return file_name ~= "" and file_name or "[No Name]"
    end

    local function get_file_path(bufnr)
      local file_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":~:.:h")
      return file_path ~= "." and file_path or ""
    end

    -- Create highlight groups
    local function set_highlights()
      vim.api.nvim_set_hl(0, "WinBarPath", { fg = "#8a8a8a", bg = "NONE", bold = false })
      vim.api.nvim_set_hl(0, "WinBarModified", { fg = "#e0af68", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "WinBarFileNameActive", { fg = "#ffffff", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "WinBarInactive", { fg = "#666666", bg = "NONE", bold = false })
      vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
    end

    -- Set highlights initially and on colorscheme change
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_highlights,
    })

    -- Make the function globally accessible
    _G.generate_winbar = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local winid = vim.api.nvim_get_current_win()
      local is_active = winid == _G.active_winid

      local icon = get_file_icon(bufnr)
      local file_name = get_filename(bufnr)
      local file_path = get_file_path(bufnr)
      local modified = vim.bo[bufnr].modified and "%#WinBarModified# [+]" or ""

      local path_component = file_path ~= "" and "%#WinBarPath#" .. file_path .. "/" or ""

      if is_active then
        return string.format(
          "%%#WinBar#%%=%s %%#WinBarPath#%s%%#WinBarFileNameActive#%s%s%%*",
          icon,
          path_component,
          file_name,
          modified
        )
      else
        return string.format("%%#WinBar#%%=%%#WinBarInactive#%s %s%s%s%%*", icon, path_component, file_name, modified)
      end
    end

    local function update_winbars()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buftype = vim.bo[buf].buftype
        if buftype == "" then -- Only set winbar for normal buffers
          vim.wo[win].winbar = "%{%v:lua.generate_winbar()%}"
        else
          vim.wo[win].winbar = nil
        end
      end
    end

    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
      group = vim.api.nvim_create_augroup("CustomWinbar", { clear = true }),
      callback = function()
        _G.active_winid = vim.api.nvim_get_current_win()
        update_winbars()
      end,
    })

    -- Initial setup
    update_winbars()
  end,
}

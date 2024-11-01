# simple-winbar.nvim

A minimalist winbar plugin for Neovim that enhances your editing experience by displaying file information and clearly distinguishing between active and inactive windows.

## Features

- Displays file icon, path, and name in the winbar
- Clearly distinguishes between active and inactive windows
- Right-aligned content for better visibility
- Transparent background to match your color scheme
- Muted appearance for inactive windows
- Customizable colors and styles

## Preview

[Insert a screenshot or GIF of simple-winbar.nvim in action here]

## Requirements

- Neovim 0.5+
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

## Installation

### Using LazyVim

1. Add the following to your LazyVim configuration (usually in `~/.config/nvim/lua/plugins/simple-winbar.lua` or a similar file):

```lua
return {
  {
    "madhermit/simple-winbar.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
}
```

2. Run `:Lazy install` in Neovim to install the plugin.

## Configuration

simple-winbar.nvim comes pre-configured with sensible defaults. However, you can customize various aspects of its appearance by modifying the highlight groups:

```lua
require('simple-winbar').setup({
  highlight_groups = {
    WinBarPath = { fg = "#8a8a8a", bg = "NONE", bold = false },
    WinBarModified = { fg = "#e0af68", bg = "NONE", bold = true },
    WinBarFileNameActive = { fg = "#ffffff", bg = "NONE", bold = true },
    WinBarInactive = { fg = "#666666", bg = "NONE", bold = false },
    FileIconInactive = { fg = "#666666", bg = "NONE", bold = false },
    WinBar = { bg = "NONE" },
    WinBarNC = { bg = "NONE" },
  }
})
```

You can change the colors by modifying the hex color codes or adjust other properties like `bold`, `italic`, etc.

## Usage

Once installed and configured, simple-winbar.nvim will automatically display the winbar in your Neovim windows. No additional commands or mappings are required.

## Troubleshooting

If you encounter any issues:

1. Make sure you have the required plugins installed (`nvim-web-devicons` and `plenary.nvim`).
2. Check that your Neovim version is 0.5 or higher.
3. Ensure the plugin is correctly installed and loaded by your plugin manager.

If problems persist, please open an issue on the GitHub repository.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# ctags.nvim

ctags integration for neovim


## Installation

```lua
require("plug").add({
	{
		"wsdjeg/ctags.nvim",
		config = function()
			require("ctags").setup({})
		end,
	},
})
```

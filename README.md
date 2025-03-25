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

run ctags update when project changed:

```lua
require("plug").add({
	{
		"wsdjeg/ctags.nvim",
		config = function()
			require("rooter").reg_callback(require("ctags").update)
		end,
		depends = {
			{
				"wsdjeg/rooter.nvim",
			},
		},
	},
})
```

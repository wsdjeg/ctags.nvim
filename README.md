# ctags.nvim

ctags integration for neovim

## Installation

```lua
require('plug').add({
  {
    'wsdjeg/ctags.nvim',
    config = function()
      require('ctags').setup({})
    end,
    depends = {
      {
        'wsdjeg/job.nvim',
      },
    },
  },
})
```

## Usage

generate tag files when project changed:

```lua
require('plug').add({
  {
    'wsdjeg/ctags.nvim',
    config = function()
      require('rooter').reg_callback(require('ctags').update)
    end,
    depends = {
      {
        'wsdjeg/job.nvim',
      },
      {
        'wsdjeg/rooter.nvim',
      },
    },
  },
})
```

update `vim.o.tags` options when project change:

```lua
require('plug').add({
  {
    'wsdjeg/ctags.nvim',
    config = function()
      require('ctags').setup()

      local function update_ctags_option()
        local project_root = vim.fn.getcwd()
        local dir = require('ctags.util').unify_path(require('ctags.config').cache_dir)
          .. require('ctags.util').path_to_fname(project_root)
        local tags = vim.tbl_filter(function(t)
          return not vim.startswith(
            t,
            require('ctags.util').unify_path(require('ctags.config').cache_dir)
          )
        end, vim.split(vim.o.tags, ','))
        table.insert(tags, dir .. '/tags')
        vim.o.tags = table.concat(tags, ',')
      end
    end,
    depends = {
      {
        'wsdjeg/job.nvim',
      },
    },
  },
})
```

## Debug

debug ctags.nvim with logger.nvim

```lua
require('plug').add({
  {
    'wsdjeg/ctags.nvim',
    config = function()
      require('rooter').reg_callback(require('ctags').update)
    end,
    depends = {
      {
        'wsdjeg/job.nvim',
      },
      {
        'wsdjeg/rooter.nvim',
      },
      {
        'wsdjeg/logger.nvim',
      },
    },
  },
})
```

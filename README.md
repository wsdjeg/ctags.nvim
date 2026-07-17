# ctags.nvim

A lightweight Neovim plugin that integrates ctags with Neovim.
It provides automatic tag generation, updates your tags option, and offers a simple async workflow powered by job.nvim.

[![Run Tests](https://github.com/wsdjeg/ctags.nvim/actions/workflows/test.yml/badge.svg)](https://github.com/wsdjeg/ctags.nvim/actions/workflows/test.yml)
[![GitHub License](https://img.shields.io/github/license/wsdjeg/ctags.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/ctags.nvim)](https://github.com/wsdjeg/ctags.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/ctags.nvim)](https://github.com/wsdjeg/ctags.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/ctags.nvim)](https://github.com/wsdjeg/ctags.nvim/releases)
[![luarocks](https://img.shields.io/luarocks/v/wsdjeg/ctags.nvim)](https://luarocks.org/modules/wsdjeg/ctags.nvim)

<!-- vim-markdown-toc GFM -->

- [✨ Features](#-features)
- [📦 Installation](#-installation)
- [⚙️ Basic Usage](#-basic-usage)
- [🔧 Configuration](#-configuration)
- [📄 License](#-license)

<!-- vim-markdown-toc -->

## ✨ Features

- Automatically generate or update tags files for the current project.
- Asynchronously run ctags (via job.nvim) without blocking the editor.
- Dynamically update vim.o.tags so Neovim can locate the correct tags file.
- Works seamlessly with project-root managers such as rooter.nvim.
- Supports all languages supported by Universal Ctags.
- Optional debug logging with logger.nvim.

## 📦 Installation

Using [nvim-plug](https://github.com/wsdjeg/nvim-plug)

```lua
require('plug').add({
  {
    'wsdjeg/ctags.nvim',
    depends = {
      {
        'wsdjeg/job.nvim',
      },
    },
  },
})
```

## ⚙️ Basic Usage

Auto-update tags when project root changes:

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
      require('rooter').reg_callback(update_ctags_option)
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

Enable debugging:

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

## 🔧 Configuration

All configuration is done through:

```lua
require('ctags').setup({
  cache_dir = vim.fn.stdpath('data') .. '/ctags.nvim/',
})
```

Available Options (examples):

| Option           | Type    | Description                                      |
| ---------------- | ------- | ------------------------------------------------ |
| cache_dir        | string  | Directory where generated tag files are stored.  |

<!-- ## 🧠 Tips -->

## 📄 License

Licensed under GPL-3.0.


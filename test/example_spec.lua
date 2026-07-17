-- test/example_spec.lua
-- Example test file demonstrating the test structure for ctags.nvim

local lu = require('luaunit')

TestExample = {}

function TestExample:setUp()
  -- Each test gets a fresh temp directory
  self.test_dir = vim.fn.tempname() .. '_ctags_test'
  vim.fn.mkdir(self.test_dir, 'p')
end

function TestExample:tearDown()
  if self.test_dir and vim.fn.isdirectory(self.test_dir) == 1 then
    vim.fn.delete(self.test_dir, 'rf')
  end
end

function TestExample:test_basic_arithmetic()
  lu.assertEquals(1 + 1, 2)
end

function TestExample:test_config_module_loads()
  local config = require('ctags.config')
  lu.assertNotNil(config)
  lu.assertNotNil(config.cache_dir)
  lu.assertTrue(type(config.cache_dir) == 'string')
end

function TestExample:test_util_unify_path()
  local util = require('ctags.util')
  local result = util.unify_path('/tmp/test/path')
  lu.assertNotNil(result)
  lu.assertTrue(type(result) == 'string')
end

function TestExample:test_util_path_to_fname()
  local util = require('ctags.util')
  local result = util.path_to_fname('/tmp/test/path')
  lu.assertNotNil(result)
  lu.assertTrue(type(result) == 'string')
  -- path_to_fname should replace special characters with underscores
  lu.assertFalse(string.find(result, '/'))
end

function TestExample:test_logger_module_loads()
  local logger = require('ctags.logger')
  lu.assertNotNil(logger)
  lu.assertEquals(type(logger.info), 'function')
  lu.assertEquals(type(logger.warn), 'function')
  lu.assertEquals(type(logger.debug), 'function')
end

function TestExample:test_setup_creates_augroup()
  local ctags = require('ctags')
  -- setup should not error
  local ok, err = pcall(function()
    ctags.setup({
      cache_dir = self.test_dir .. '/cache/',
    })
  end)
  lu.assertTrue(ok, 'setup() should not error: ' .. tostring(err))
end

return TestExample


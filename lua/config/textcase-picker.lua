return function()
  local plugin = require("textcase.plugin.plugin")
  local presets = require("textcase.plugin.presets")
  local constants = require("textcase.shared.constants")
  local api = require("textcase").api
  local function get_conversion_methods()
    local methods = {}

    for _, method in pairs({
      api.to_upper_case,
      api.to_lower_case,
      api.to_snake_case,
      api.to_dash_case,
      api.to_title_dash_case,
      api.to_constant_case,
      api.to_dot_case,
      api.to_comma_case,
      api.to_phrase_case,
      api.to_camel_case,
      api.to_pascal_case,
      api.to_title_case,
      api.to_path_case,
    }) do
      if presets.options.enabled_methods_set[method.method_name] then
        table.insert(methods, {
          label = method.desc,
          method_name = method.method_name,
        })
      end
    end

    return methods
  end

  local function normal_mode_change()
    local quick_methods = get_conversion_methods()
    local lsp_methods = get_conversion_methods()

    local options = {}

    for _, method in ipairs(quick_methods) do
      table.insert(options, {
        label = "Convert to " .. method.label,
        method_name = method.method_name,
        type = constants.change_type.CURRENT_WORD,
      })
    end

    for _, method in ipairs(lsp_methods) do
      table.insert(options, {
        label = "LSP rename " .. method.label,
        method_name = method.method_name,
        type = constants.change_type.LSP_RENAME,
      })
    end

    vim.ui.select(options, {
      prompt = "Text Case:",
      format_item = function(item)
        return item.label
      end,
    }, function(choice)
      if not choice then
        return
      end

      if choice.type == constants.change_type.CURRENT_WORD then
        plugin.current_word(choice.method_name)
      elseif choice.type == constants.change_type.LSP_RENAME then
        plugin.lsp_rename(choice.method_name)
      end
    end)
  end
  local function visual_mode_change()
    local methods = get_conversion_methods()

    vim.ui.select(methods, {
      prompt = "Convert selection to:",
      format_item = function(item)
        return item.label
      end,
    }, function(choice)
      if not choice then
        return
      end
      plugin.visual(choice.method_name)
    end)
  end
  local mode = vim.api.nvim_get_mode().mode
  if mode == "v" or mode == "V" then
    visual_mode_change()
  elseif mode == "n" then
    normal_mode_change()
  end
end

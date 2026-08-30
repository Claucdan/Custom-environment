local bufferline = require('bufferline')
bufferline.setup {
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.default,
        themable = true,
        indicator = {
            icon = '▎',
            style = 'icon',
        },
        groups = {
          items = {
            {
              name = 'tornado',
              matcher = function(buf)
                return (buf.path or ""):lower():match("tornado")
              end,
            },
            {
              name = 'gornado',
              matcher = function(buf)
                return (buf.path or ""):lower():match("gornado")
              end,
            },
            {
              name = 'tests',
              matcher = function(buf)
                return (buf.name or ""):lower():match("*test*%.cpp$")
              end,
            },
            {
              name = 'code',
              matcher = function(buf)
                return (buf.name or ""):lower():match("%.h$")
                    or (buf.name or ""):lower():match("%.c$")
                    or (buf.name or ""):lower():match("%.cpp$")
              end,
            },
          },
          hidden = false,
        },
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true
            }
        },
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style =  "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        auto_toggle_bufferline = true,
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        pick = {
          alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
        },
    }
}

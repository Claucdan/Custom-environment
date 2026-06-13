-- return {
--   filters = { dotfiles = false, git_ignored = false, },
--   disable_netrw = true,
--   hijack_cursor = true,
--   sync_root_with_cwd = true,
--   update_focused_file = {
--     enable = true,
--     update_root = false,
--   },
--   bookmarks = {
--     persist = true,
--   },
--   view = {
--     width = 30,
--     preserve_window_proportions = true,
--   },
--   renderer = {
--     root_folder_label = false,
--     highlight_git = true,
--     indent_markers = { enable = true },
--     icons = {
--       glyphs = {
--         default = "󰈚",
--         folder = {
--           default = "",
--           empty = "",
--           empty_open = "",
--           open = "",
--           symlink = "",
--         },
--         git = { unmerged = "" },
--       },
--     },
--   },
-- }
return {
  filters = {
    dotfiles = false,
    git_ignored = false,
  },

  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,

  update_focused_file = {
    enable = true,
    update_root = false,
  },

  bookmarks = {
    persist = true,
  },

  git = {
    enable = true,
    ignore = false,
    timeout = 5000,
  },


  view = {
    width = 30,
    preserve_window_proportions = true,
  },

  renderer = {
    root_folder_label = false,
    highlight_git = "all",

    indent_markers = {
      enable = true,
    },

    icons = {
      show = {
        git = true,
        modified = false,
        file = true,
        folder = true,
        folder_arrow = true,
      },

      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

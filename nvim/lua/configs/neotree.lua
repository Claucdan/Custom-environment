return {
  close_if_last_window = true,
  popup_border_style = "rounded",

  enable_git_status = true,
  enable_diagnostics = true,

  filesystem = {
    hijack_netrw_behavior = "open_current",

    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },

    group_empty_dirs = true,

    filtered_items = {
      visible = false,
      hide_hidden = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        "docs",
        ".git",
        ".cache",
        "builddir-debug",
      },
    },

    bind_to_cwd = true,
    cwd_target = {
      sidebar = "global",
      current = "window",
    },

    use_libuv_file_watcher = true,

    window = {
      width = 30,
    },
  },

  default_component_configs = {
    indent = {
      with_markers = true,
    },

    modified = {
      symbol = "",
    },

    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "󰈚",
    },

    git_status = {
      symbols = {
        added     = "★",
        modified  = "✗",
        deleted   = "",
        renamed   = "➜",
        untracked = "★",
        ignored   = "◌",
        unstaged  = "✗",
        staged    = "✓",
        conflict  = "",
      },
    },

    name = {
      use_git_status_colors = true,
    },
  },
}

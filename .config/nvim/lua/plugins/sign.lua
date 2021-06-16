require("gitsigns").setup {
  signs = {
    add = {text = "", numhl = "GitGutterAdd"},
    change = {text = "", numhl = "GitGutterChange"},
    delete = {text = "", numhl = "GitGutterDelete"},
    topdelete = {text = "", numhl = "GitGutterDelete"},
    changedelete = {text = "", numhl = "GitGutterDelete"}
    --[[
    add = {hl = "GitGutterAdd", text = "│",numhl = "GitGutterAdd"},
    change = {hl = "GitGutterChange", text = "│",numhl = "GitGutterChange"},
    delete = {hl = "GitGutterDelete", text = "│",numhl = "GitGutterDelete"},
    topdelete = {hl = "GitGutterDelete", text = "│",numhl = "GitGutterDelete"},
    changedelete = {hl = "GitGutterDelete", text = "│",numhl = "GitGutterDelete"} ]]
  },
  numhl = true,
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  status_formatter = nil
  -- status_formatter = function(status)
  -- local added = status.added > 0 and "  " .. status.added or ""
  -- local changed = status.changed > 0 and "  " .. status.changed or ""
  -- local removed = status.removed > 0 and "  " .. status.removed or ""
  -- return status.head .. added .. changed .. removed .. " "
  -- end
}

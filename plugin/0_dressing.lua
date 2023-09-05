local dressing_ready, dressing = pcall(require, 'dressing')
if (not dressing_ready) then return end

dressing.setup({
  input = {
    enabled = true
  },
  select = {
    enabled = true,
    backend = {
      "telescope",
      "builtin"
    }
  }
})

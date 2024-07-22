local ready, ibl = pcall(require, 'ibl')
if (not ready) then return end

-- vim.g.indent_blankline_char = '|'

local colorbuddy = require('colorbuddy.init')
local Color = colorbuddy.Color
local colors = colorbuddy.colors
local Group = colorbuddy.Group
local styles = colorbuddy.styles

Color.new('nice', '#222222')
Group.new('MyIndentBlankline', colors.nice, colors.none, styles.NONE)

ibl.setup {
}

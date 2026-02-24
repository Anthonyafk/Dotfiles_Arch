-- Opciones básicas
vim.opt.number = true            -- Números absolutos
vim.opt.relativenumber = true    -- Números relativos
vim.opt.tabstop = 4              -- Tamaño del tab = 4 espacios
vim.opt.shiftwidth = 4           -- Auto indentado = 4 espacios
vim.opt.expandtab = true         -- Convierte tabs en espacios
vim.opt.smartindent = true       -- Indentado inteligente
vim.opt.wrap = false             -- No partir líneas
vim.opt.termguicolors = true     -- Colores bonitos
vim.opt.cursorline = true        -- Resaltar línea actual
vim.opt.clipboard = "unnamedplus" -- Copiar/pegar con portapapeles del sistema
vim.opt.scrolloff = 8            -- Margen al hacer scroll
vim.opt.signcolumn = "yes"       -- Columna para diagnósticos



-- RUTA donde tienes lazy.nvim
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Inicializar Lazy
require("lazy").setup({
    -- Temas
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },

    -- Explorador de archivos
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Barra de estado
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Git
    { "lewis6991/gitsigns.nvim" },

    -- Autocompletado + LSP
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "neovim/nvim-lspconfig" },

    -- Syntax highlighting mejorado
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})



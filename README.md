# my nvim config

## Jump

| key | does |
| --- | --- |
| `gd` | definition |
| `gD` | declaration |
| `gi` | implementation |
| `go` | type definition |
| `grr` | references |
| `gO` | document symbols |
| `<C-o>` | jump back |

## Read

| key | does |
| --- | --- |
| `K` | hover docs |
| `gs` | signature help |
| `<C-h>` | signature help, insert mode |

## Change

| key | does |
| --- | --- |
| `grn` / `<F2>` | rename symbol |
| `gra` / `<F4>` | code action |
| `<F3>` | format |
| `grx` | run code lens |

## Diagnose

| key | does |
| --- | --- |
| `gl` | diagnostic under cursor |
| `<C-w>d` | diagnostic under cursor |
| `]d` / `[d` | next / previous diagnostic |

## Leader

| key | does |
| --- | --- |
| `<leader>vrr` | references |
| `<leader>vrn` | rename |
| `<leader>vca` | code action |
| `<leader>vws` | workspace symbols |
| `<leader>vs` | document symbols |
| `<leader>vd` | diagnostic under cursor |
| `<leader>vD` | all diagnostics |
| `<leader>pv` | file tree |
| `<leader>pf` | find files |
| `<leader>ps` | grep |
| `<leader>pws` / `<leader>pWs` | grep word / WORD under cursor |
| `<leader>b` | buffers |
| `<leader>vh` | help tags |

## Completion (insert mode)

| key | does |
| --- | --- |
| `<C-Space>` | open menu |
| `<C-n>` / `<C-p>` | next / previous item |
| `<C-y>` | confirm |
| `<CR>` | confirm if item selected |
| `<C-e>` | dismiss |
| `<C-d>` / `<C-u>` | scroll docs down / up |
| `<C-f>` / `<C-b>` | next / previous snippet placeholder |

## Telescope

| key | does |
| --- | --- |
| `<C-p>` | git files |

## Files

| key | does |
| --- | --- |
| `<leader>pv` | file tree, current window |
| `:Lexplore` | file tree, sidebar |
| `Enter` | open / expand |
| `-` | up a level |
| `%` | new file |
| `d` | new directory |
| `R` | rename |
| `D` | delete |

## Commands

| command | does |
| --- | --- |
| `:LspInfo` | LSP status for this buffer |
| `:checkhealth lsp` | diagnose LSP setup |
| `:Mason` | manage language servers |
| `:LspStart` | attach LSP manually |
| `:lua =vim.lsp.get_clients()` | list attached clients |
| `:Lazy` | plugin status / update |

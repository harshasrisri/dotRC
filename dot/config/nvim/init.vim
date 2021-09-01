lua << EOF
require('impatient')
require('config')
require('plugins')
require('config/telescope')
require('config/lsp')
require('config/misc')
require('config/compe')
require('config/luasnip')
EOF

"" Lightline
    let g:lightline = {
        \ 'colorscheme': 'nightfox',
        \ 'active': { 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'modified' , 'fugitive', 'filename', 'method' ] ] },
        \ 'component': { 'lineinfo': ' %3l:%-2v' },
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' },
        \ 'component_function': {
        \     'readonly': 'LightlineReadonly',
        \     'fugitive': 'LightlineFugitive',
        \     'method'  : 'NearestMethodOrFunction',
        \   },
        \ 'tabline': { 'left': [['buffers']], 'right': [['close']] },
        \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
        \ 'component_type': { 'buffers': 'tabsel', },
        \ }

    function! LightlineReadonly()
        return &readonly ? '' : ''
    endfunction

    function! LightlineFugitive()
        let branch = FugitiveHead()
        return branch !=# '' ? ' '.branch : ''
    endfunction

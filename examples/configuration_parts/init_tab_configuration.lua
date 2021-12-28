vim.cmd([[
  augroup auto_read
      autocmd!
      autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
                  \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
      autocmd FileChangedShellPost * echohl WarningMsg
                  \ | echo "File changed on disk. Buffer reloaded!" | echohl None
  augroup END

  function TwoSpacesSoftTabs()
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab
  endfunction

  function EightSpacesHardTabs()
    set tabstop=8
    set shiftwidth=8
    set softtabstop=8
    set noexpandtab
  endfunction

  function EightSpacesSoftTabs()
    set tabstop=8
    set shiftwidth=4
    set softtabstop=8
    set expandtab
  endfunction

  function FourSpacesSoftTabs()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  endfunction

  function FourSpacesHardTabs()
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set noexpandtab
  endfunction

  function OpenSystemFile()
     call system(join('open', expand('%:p'), ' '))
  endfunction
  " =============================================================================
  " Set filetypes for some extensions
  " =============================================================================
  augroup FILETYPE_SETTINGS
      autocmd!
      autocmd BufRead *.plot set filetype=gnuplot
      autocmd BufRead *.md set filetype=markdown
      autocmd BufRead *.lds set filetype=ld
      autocmd BufRead *.rb set filetype=ruby
      autocmd BufRead *.tex set filetype=tex
      autocmd BufRead *.trm set filetype=c
      autocmd BufRead *.xlsx.axlsx set filetype=ruby
      autocmd BufRead *.h,*.c,*.cc,*.cpp,*.C,*.ino set filetype=c
      autocmd BufRead *.tex,*.sty set filetype=tex
      autocmd BufRead *.yml,*.yaml,Sakefile set filetype=yaml
      autocmd BufRead CHANGELOG setlocal filetype=text
      autocmd BufRead *.pl set filetype=prolog
      autocmd BufRead *.tex set filetype=tex
      autocmd BufWrite *.tex call CompileAndLoad()
      autocmd BufReadPost *.jpg call OpenSystemFile()
      autocmd BufReadPost *.png call OpenSystemFile()
      autocmd BufReadPost *.gif call OpenSystemFile()
      autocmd BufReadPost *.pdf call OpenSystemFile()
  augroup END

  augroup FILE_SPACINGS
      autocmd!
      autocmd FileType c call FourSpacesSoftTabs()
      autocmd FileType java call TwoSpacesSoftTabs()
      autocmd FileType python call FourSpacesSoftTabs()
      autocmd FileType tex call FourSpacesSoftTabs()
      autocmd FileType sh call FourSpacesHardTabs()
      autocmd FileType perl call EightSpacesHardTabs()
      autocmd FileType html call TwoSpacesSoftTabs()
      autocmd FileType haskell call TwoSpacesSoftTabs()
      autocmd FileType scheme call TwoSpacesSoftTabs()
      autocmd FileType yacc call FourSpacesHardTabs()
  augroup END

  augroup FILE_LEADERS
      autocmd!
      autocmd FileType tex let maplocalleader = "\<Space>"
  augroup END
]])

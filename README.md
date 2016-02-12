dotRC
=====

My Linux Environment and Vim environment.

To Install
-----
It backs up existing bashrc, vimrc and .vim to replace them with my files. It is a simple way to setup my environment.
~~~
git clone http://github.com/harshasrisri/dotRC.git
cd dotRC
./setup install
source //your shell's rc file//
~~~

To Uninstall
-----
It can restore the previous .RCs and .vim to leave the environment the way it was before with this command.
(haven't tested this well enough yet)
~~~
cd dotRC
./setup reset
source //your shell's rc file//
~~~

To Update
----
It can update itself as well as all the submodules that are a part of it with this command:
~~~
cd dotRC
./setup update
source //your shell's rc file//
~~~

Please Backup whatever is important ALWAYS!

Plugins
-------
The plugins that are a part of this repo right now are:
* [Solarized Color Scheme](https://github.com/altercation/vim-colors-solarized)
* [Vim Airline](https://github.com/bling/vim-airline)
* [Vim Commentery](https://github.com/tpope/vim-commentary)
* [SuperTab](https://github.com/ervandew/supertab)
* [Vim Peekaboo](https://github.com/junegunn/vim-peekaboo)
* [Vim Multiple Cursors](https://github.com/terryma/vim-multiple-cursors)
* [Taglist](https://github.com/vim-scripts/taglist.vim)
* [CtrlP](https://github.com/kien/ctrlp.vim)
* [NERDTree](https://github.com/scrooloose/nerdtree)
* [Fly.vim](https://github.com/vim-scripts/fly.vim) (hidden gem! best cscope navigation)
* [Vim Autotags](https://github.com/basilgor/vim-autotags) (In conjunction with fly.vim)
* [Matrix Vim Screensaver](https://github.com/vim-scripts/matrix.vim--Yang) (Bling!)

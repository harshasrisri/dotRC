dotRC
=====

My Linux Environment and Vim environment.

* Because I want my Bash and Vim environment to be seamless wherever I go.
* I simply use the dotRC script to backup existing env with my own. When I'm done, the same script will let me restore the originals.
* To show off at work that I have a ready-to-use Linux env. ;-)

To Install
-----
It backs up existing bashrc, vimrc and .vim to replace them with my files. It is a simple way to setup my environment.
~~~
git clone http://github.com/harshasrisri/dotRC.git
cd dotRC
./setup install
~~~


To Uninstall
-----
It can restore the previous .RCs and .vim to leave the environment the way it was before with this command.
(haven't tested this well enough yet)
~~~
cd dotRC
./setup reset
~~~

To Update
----
It can update itself as well as all the submodules that are a part of it with this command:
~~~
cd dotRC
./setup update
~~~

Please Backup whatever is important ALWAYS!

Plugins
-------
Pathogen: The next best thing in Vim after Vim itself. Very useful to manage plugins.

AckVim: Searching for expressions in a directory. Like Grep inside Vim.

Ctrlp: Search for files in PWD and below.

Fly: Little known plugin for using cscope dbs. Life Changing!!

Autotags: Manage the tags file and cscope dbs for all the projects in one central location.

Nerdtree: File explorer in a sidebar.

SuperTab: Awesome Auto-completion.

Taglist: Sidebar containing tags in the opened file, list all open buffers.

Commentary: Awesome plugin to comment/uncomment any amount of code, in many languages.

Matrix: Matrix screen saver for Vim. I even made an awesome wallpaper using it.

Statline : Customizable status bar that adapts to the colorscheme.

Peaksea : Colorscheme used to view diffs.

Lettuce : Default colorscheme.

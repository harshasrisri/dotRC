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
To add new plugins, just add the link of the git repo where the plugin can be found, to the plugin_list file and run
~~~
cd dotRC
./setup install
~~~

The plugins that are a part of this repo right now are:
* Ctrlp: Search for files in PWD and below.
* Fly: Little known plugin for using cscope dbs. Life Changing!!
* Autotags: Manage the tags file and cscope dbs for all the projects in one central location.
* Nerdtree: File explorer in a sidebar.
* SuperTab: for Auto-completion.
* Taglist: Sidebar containing tags in the opened file, list all open buffers.
* Commentary: Awesome plugin to comment/uncomment any amount of code, in many languages.
* Matrix: Matrix screen saver for Vim. I even made an awesome wallpaper using it.
* Solarized Colors: Default color scheme.
* Vim-Airlin: A great status line plugin.
* TagBar: Still experimenting with it. Let's see how it goes.

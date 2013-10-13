dotRC
-------
My Linux Environment. Can't live without it.

I use Linux and Vim extensively at work and home. I've created this repo:
->Because I want my Bash and Vim environment to be seamless wherever I go.
->I simply use the dotRC script to backup existing env with my own. When I'm done, the same script will let me restore the originals.
->To show off at work that I have a ready-to-use Linux env. ;-)

To Install :
-----
It backs up existing bashrc, vimrc and .vim to replace them with my files. It is a simple way to setup my environment.
~~~
git clone http://github.com/harshasrisri/dotRC.git
cd dotRC
./dotRC setup
~~~


To Uninstall
-----
It can restore the previous .RCs and .vim to leave the environment the way it was before with this command:
~~~
cd dotRC
./dotRC reset
~~~

To Update
----
It can update itself as well as all the submodules that are a part of it with this command:
~~~
cd dotRC
./dotRC update
~~~

Disclaimer : I've tested the dotRC setup file enough, but be careful. It might eat up a few of your .RCs.

Please Backup whatever is important ALWAYS!

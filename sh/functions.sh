# Function to share ssh keys to a remote server and store the connection as an alias
function sshnopass () {
	# Set keys file path
	keys_file=$(dirname $(readlink ~/.myshrc))/../sh/sshnopass.sh

	# Generate RSA key if it is not there already
	[ ! -f ~/.ssh/id_rsa.pub ] && ssh-keygen -t rsa;

	# Use the port if specified as 3rd argument
	if [ ! -z "$3" ]; then PORT="-p $3"; else PORT=""; fi

	# copy your public key to the authorized keys file on remote
	ssh $PORT $1@$2 'mkdir -p ~/.ssh';
	cat ~/.ssh/id_rsa.pub | ssh $PORT $1@$2 'cat >> ~/.ssh/authorized_keys';

	# create an alias for this connection
	echo "Enter a name for this connection";
	read name;
	[ -z $name ] && echo "No alias created for this connection" && exit
	echo "alias $name='ssh $PORT $1@$2 -o ForwardX11=yes'" >> $keys_file;
	source $keys_file;
}

functions rmbg () {
    tmp_dir=.rmdir_$RANDOM
    mv $@ $tmp_dir > /dev/null 2>&1
    rm -rf $tmp_dir > /dev/null 2>&1 &
}

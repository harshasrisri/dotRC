# Function to share ssh keys to a remote server and store the connection as an alias
function sshnopass () {
	keys_file=$BashDir/sshnopass.sh
	[ ! -f ~/.ssh/id_rsa.pub ] && ssh-keygen -t rsa;
	ssh $1@$2 'mkdir -p ~/.ssh';
	cat ~/.ssh/id_rsa.pub | ssh $1@$2 'cat >> ~/.ssh/authorized_keys';
	echo "Enter a name for this connection";
	read name;
	echo "alias $name='ssh $1@$2 -o ForwardX11=yes'" >> $keys_file;
	source $keys_file;
}

md() {
	mkdir -p $1
	cd $1
}

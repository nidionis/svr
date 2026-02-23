# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'


alias ccc="cc -Wall -Wextra -Werror $@"
alias val="valgrind --leak-check=full --show-leak-kinds=all"
alias mvj='rsync -aH --remove-source-files'
alias cpj='rsync -aH'
alias git_light="git filter-repo --strip-blobs-bigger-than 10M"
alias s="sudo -E"

function src() {
	d="$PWD"; while [ "$d" != "/" ]; do
		for a in "$d/bin/activate" "$d/.*/bin/activate"; do
			[ -f $a ] && source "$a" && break 2
		done
		d=$(dirname "$d")
	done
	source $HOME/.bashrc
}


##convert mp3 to wav
#to_wav () {
#	OUTDIR_NAME="wav_files"
#	#mkdir $OUTDIR_NAME
#	for file in "$@" ; do
#		WAV_NAME=${file%.*}.wav
#		echo $file
#		echo
#		ffmpeg -i $file -ar 16000 -ac 1 "$WAV_NAME"
#	done
#}
#
##convert wav to mp3
#to_mp3 () {
#	#OUTDIR_NAME="wav_files"
#	#mkdir $OUTDIR_NAME
#	for file in "$@" ; do
#		MP3_NAME=${file%.*}.mp3
#		echo $file
#		echo
#		ffmpeg -i $file -vn -b:a 192k "$MP3_NAME"
#	done
#}
#
#cexec () {
#	BASE=($@)
#	NAME="${BASE%.*}"
#	FLAGS=('-Wall' '-Wextra' '-Werror')
#	cc ${FLAGS[@]} $BASE -o "$NAME" && ./"$NAME" && rm $NAME
#}
#
#cdebug () {
#	BASE="$1"
#	NAME="${BASE%.*}"
#	FLAGS="-g3"
#	cc $BASE $FLAGS -o "$NAME" && gdb "$NAME" && rm $NAME
#}
#
#brc () {
#	SOURCE="$HOME/.bashrc"
#	F_NAME=".bashrc"
#	FILE="$(find -O3 $HOME -name $F_NAME 2>/dev/null | head -n 1)"
#	F_PATH="$(dirname $FILE)"
#	cd "$F_PATH"
#    commit_if_modified "$F_NAME"
#	cd -
#	source $SOURCE
#}
#
#vrc () {
#	SOURCE="$HOME/.vimrc"
#	F_NAME=".bash_aliases"
#	FILE="$(find -O3 $HOME -name $F_NAME 2>/dev/null | head -n 1)"
#	F_PATH="$(dirname $FILE)"
#	cd "$F_PATH"
#    commit_if_modified "$F_NAME"
#	cd -
#	source $SOURCE
#}
#basha () {
#	SOURCE="$HOME/.bashrc"
#	F_NAME=".bash_aliases"
#	FILE=$HOME/$F_NAME
#	cd "$HOME/machine"
#    commit_if_modified "$FILE"
#	cd -
#	source $SOURCE
#}
#
#machine_install () {
#	FILE=~/machine/install.sh
#	vim $FILE
#	cd $FILE
#	git add $FILE
#	git commit -m "$FILE install mofified"
#	git push
#	cd -
#}
#
#arch_install () {
#	FOLD=~/machine
#	FILE=$FOLD/arch_install.sh
#	vim $FILE
#	cd $FOLD
#	git add $FILE
#	git commit -m "$FILE install mofified"
#	git push
#	cd -
#}
#
#netstat_tunlp () {
#	netstat -tunlp
#}
#
#nmap_full () {
#	sudo nmap --scanflags URGACKPSHRSTSYNFIN $@
#}
#
#nmap_sA () {
##ACK scan: the target would respond to the ACK with RST regardless of the state of the port
##help to guess firewall rules if the packet is droped
#	nmap -sA --reason #or -v -vv -d -dd
#}
#
#nmap_version () {
#	#-O = OS detection
#	#-sV services versions
#	#version intensity max
#	#-sC use default script
#	nmap -sV --version-intensity 9 -O -sC $@
#}
#
#nmap_ssh_brute () {
#	nmap --script "ssh-brute" $1 #--script-args userdb=user_list.txt,passdb=passwd_list.txt
#}
#
#gitmain () {
#	if [ -z "$1" ]; then
#		git checkout main
#		git reset --hard "$1"
#		git push origin main --force
#	fi
#}
#
#gitadd () {
#	make fclean
#	git add .
#}
#
#gitaddcommit () {
#	gitadd
#	if [ -n "$1" ]; then
#		git commit -m "$1"
#	else
#		git commit
#	fi
#}
#
#gitotal () {
#	gitaddcommit $@
#	git pull
#	if [ -n "$?" ] ; then
#		git push origin HEAD
#	fi
#}
#
#gitlog () {
#	git log --oneline --decorate --graph --all
#}
#
#aur () {
#	git clone https://aur.archlinux.org/$1.git
#}
#
#history_full () {
#    HIST_FILE=~/.history
#	#  => cat ~/.history | head -4
#	#  git diff
#	#  #1741473628
#	#  make && lldb ./push_swap
#	#  #1741474988
#    while read LINE; do
#        if [ -n "$(echo "$LINE" | grep '^#')" ]; then
#            date -d "$(echo $LINE | sed 's/\#/@/g')"
#        else
#            echo "$LINE"
#        fi
#    done < $HIST_FILE
#}
#
#normi () {
#	norminette -R CheckForbiddenSourceHeader -R CheckDefine $1
#}
#
#
#ulog_sort () {
#	sudo grep -Eo "MAC.*DST=[^ ]*" /var/log/ulogd.syslogemu  | sort | uniq -c | sort -n
#
#}
#
#header_awk () {
#	grep -RE $CFUNCTION src | cut -d: -f2 | sed s/\$/';'/g
#}
#
#clone () {
#	if [ $# -eq "3" ] ; then 
#		PROFIL_NAME="$1"
#		PROJECT_NAME="$2"
#		git clone https://github.com/$PROFIL_NAME/$PROJECT_NAME.git
#	else
#		PROJECT_NAME="$1"
#		git clone git@github.com:nidionis/$PROJECT_NAME.git
#	fi
#}
#
#iptables_update () {
#	F_PATH="$(dirname $FILE)"
#	F_PERSISTENT="/etc/iptables.rules"
#	FILE="$(find /home -name 'iptables_script.sh' | head -1)"
#	F_TMP=/etc/iptables.rules.backup
#	sudo cp $F_PERSISTENT > $F_TMP
#	vim + $FILE
#	sudo ./$FILE -s -f ip_to_ban.txt -r
#	sudo iptables-save > $HOME/tmp
#	sudo mv $HOME/tmp $F_PERSISTENT
#}
#
#bashalias ()
#{
#	vim ~/.bash_aliases
#}
#
#bashrc ()
#{
#	vim ~/.bashrc
#}
#
#
#uniqq ()
#{
#	for F in $@ ; do
#		sort $F | uniq -c | sort -nr
#	done
#}
#
#testee ()
#{
#	if [ "$#" -gt 2 -o "$#" -eq 0 ]; then
#	    echo "Usage: $0 [path/to] <file>"
#		echo "default file path is journal/not_sorted/$(date +%F)_${USER}_${$HOST}_${$PWD}.txt"
#	    return 1
#	fi
#}
#
#journal-perso ()
#{
#	refresh_time
#	DIR_ORIGINAL=$PWD
#	DIR="$HOME/perso"
#	DATE_DIR="$YEAR/$MONTH/$DAY"
#	if [ "$#" -eq 0 ]; then
#	    echo "Usage: $0 [ subfolder ] < file >"
#		echo "default path is $DIR"
#		echo "default file name is $F_NAME"
#	    return 1
#	fi
#	if [ "$#" -eq 1 ]; then
#		LN_DIR="fouretout"
#		F_NAME=$1
#	fi
#	if [ "$#" -eq 2 ]; then
#		LN_DIR="$1"
#		F_NAME=$2
#	else
#		return 1
#	fi
#	F_NAME+=".md"
#	cd $DIR
#	PATH_="${DATE_DIR}/${LN_DIR}"
#	mkdir -p "$PATH_"
#	FILE="${PATH_}/${F_NAME}"
#	header_journal $FILE
#	if commit_if_modified $FILE ; then
#		mkdir -p "$DIR/$LN_DIR"
#		ln -P "$FILE" "$DIR/$LN_DIR/"
#	else
#		rm $FILE
#		rmdir -p "${PATH_}"
#	fi
#	cd $DIR_ORIGINAL
#}
#
#journal ()
#{
#	refresh_time
#	DIR_ORIGINAL=$PWD
#	DIR="$HOME/journal"
#	DATE_DIR="$YEAR/$MONTH/$DAY"
#	if [ "$#" -eq 0 ]; then
#	    echo "Usage: $0 [ subfolder ] < file >"
#		echo "default path is $DIR"
#		echo "default file name is $F_NAME"
#	    return 1
#	fi
#	if [ "$#" -eq 1 ]; then
#		LN_DIR="fouretout"
#		F_NAME=$1
#	fi
#	if [ "$#" -eq 2 ]; then
#		LN_DIR="$1"
#		F_NAME=$2
#	else
#		return 1
#	fi
#	F_NAME+=".md"
#	cd $DIR
#	PATH_="${DATE_DIR}/${LN_DIR}"
#	mkdir -p "$PATH_"
#	FILE="${PATH_}/${F_NAME}"
#	header_journal $FILE
#	if commit_if_modified $FILE ; then
#		mkdir -p "$DIR/$LN_DIR"
#		ln -P "$FILE" "$DIR/$LN_DIR/"
#	else
#		rm $FILE
#		rmdir -p "${PATH_}"
#	fi
#	cd $DIR_ORIGINAL
#}
#
#ps_parents ()
#{
#	if [ "$#" -ne 1 ]; then
#	    echo "Usage: $0 <pid>"
#	    return 1
#	fi
#	pid=$1
#	while [ "$pid" -ne 1 ]; do
#		ps -p $pid -o pid=,ppid=,cmd=;
#		pid=$(ps -p $pid -o ppid= --no-headers);
#	done
#}
#
#kill_all ()
#{
#	if [ -z "$1" ]; then
#		echo "Usage: $0 <keyword>"
#		exit 1
#	fi
#
#	KEYWORD="$1"
#	ps aux | grep "$KEYWORD" | grep -v "grep" | awk '{print $2}' | xargs -r kill -9
#}
#
#gcl ()
#{
#	git clone $1 $2
#}
#
#src ()
#{
#	source $HOME/.bashrc
#}
#
## from https://wiki.alpinelinux.org/wiki/Installing_Alpine_in_a_virtual_machine
#alpine_launch () 
#{
#	DIR="$HOME"/alpine
#	FILE=$(find $DIR -iregex ".*alpine.*86_64.iso")
#	#FILE="$DIR"/alpine-standard*iso 
#	qemu-system-x86_64 -m 512 -nic user,hostfwd=tcp::2222-:22 -boot d -cdrom $FILE -hda alpine.qcow2 -enable-kvm #-display gtk
#}
#
#compose ()
#{
#	docker compose up --watch
#}
#
#cert_local ()
#{
#	DIR=${1:-"certs"}
#
#	mkdir -p $DIR
#	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#	  -keyout $DIR/localhost.key \
#	  -out $DIR/localhost.crt \
#	  -subj "/CN=localhost"
#}
#
#virtual() {
#    if [ -z "$1" ]; then
#        echo "Usage: virtual <fichier.iso> [arguments supplémentaires pour QEMU]"
#        return 1
#    fi
#    ISO="$1"
#    shift
#    if [ ! -f "$ISO" ]; then
#        echo "Erreur : fichier '$ISO' introuvable."
#        return 1
#    fi
#
#    qemu-system-x86_64 $ISO \
#        -enable-kvm \
#        -m 2048 \
#        -cpu host \
#        -cdrom "$ISO" \
#        -boot d \
#        -vga virtio \
#        -nic user \
#        "$@"
#}
#
#refresh_time () {
#	export DATE=$(date +"%y%m%d")
#    export TIME=$(date +"%T")
#}
#
#header_journal () {
#	F_NAME=$1
#	echo "$DATE" >> $F_NAME
#	echo "$TIME" >> $F_NAME
#	echo "$USER" >> $F_NAME
#	echo "$HOST" >> $F_NAME
#	echo >> $F_NAME
#	echo "###############################################" >> $F_NAME
#	echo >> $F_NAME
#	echo "$F_NAME" >> $F_NAME
#	echo >> $F_NAME
#}
#
#journalctl_prettyfy () {
#	SIZE=${1:-"100"}
#	UNIQ_MIN=${2:-"1"}
#	BOOT=${3:-"0"}
#	local TMP="/tmp/journalctl_prettyf.tmp"
#	_FILE=${4:-"$TMP"}
#
#	CMD="sudo journalctl -b ${BOOT} | tail -n $SIZE"
#	CMD_SORTED="${CMD} | cut -d\: -f 4- | sort | uniq -c | sort -n"
#	rm -f "$TMP"
#	append_cmd "$CMD" "$TMP"
#	append_cmd "$CMD_SORTED" "$TMP"
#	grep -vE " +[0-${UNIQ_MIN}] " $TMP >> "$_FILE"
#	if ! $# ; then cat $_FILE ; fi
#	rm "$TMP"
#}
#
#append_cmd () {
#	local CMD=$1
#	local F_NAME=$2
#	echo >> $F_NAME
#    echo ${CMD}	>> $F_NAME
#	echo >> $F_NAME
#
#    eval ${CMD}	>> $F_NAME
#	echo >> $F_NAME
#	echo "###############################################" >> $F_NAME
#	echo >> $F_NAME
#}
#
#commit_if_modified () {
#	local F_NAME=$1
#	local DEL=$2
#	git pull
#	vim + $F_NAME
#	git add $F_NAME
#	if ! git commit ; then
#		echo -n "[no modifications]"
#		if [ -n "$DEL" ] ; then
#			rm $F_NAME
#			echo -n " -> deleted"
#			return 1
#		fi
#	fi	   
#	git push
#	return 0
#}
#
#report_crash ()
#{
#	refresh_time
#	NAME=$1
#	TAIL_SIZE="100"
#	DIR_ORIGINAL=$PWD
#	CRASH_DIR="$(echo ${DATE}_${TIME} | sed 's/:/-/g')"
#	F_NAME="${NAME}.crash"
#	DIR_RELATIVE="$HOME/journal/sysadmin/crash"
#	DIR_RELATIVE+="/${CRASH_DIR}"
#	if [ "$#" -ne 1 ]; then
#	    echo "Usage: $0 FILE_NAME"
#		echo "default path is $DIR_RELATIVE/FILE_NAME.crash"
#		echo "write log outputs"
#	    return 1
#	fi
#
#	mkdir -p $DIR_RELATIVE
#	cd $DIR_RELATIVE
#	if [ -f $F_NAME ] ; then
#		BCK="/tmp/$F_NAME.backup"
#		echo "File exists moved to $BCK"
#		mv $F_NAME $BCK
#	fi
#	header_journal $F_NAME
#	journalctl_prettyfy "100" "1" "0" "$F_NAME"
#    commit_if_modified "$F_NAME" "DELETE_IF_NOT_MODIFIED"
#	cd $DIR_ORIGINAL
#}
#
#report_last_boot ()
#{
#	refresh_time
#	NAME=$1
#	DIR_ORIGINAL=$PWD
#	CRASH_DIR="$(echo ${DATE}_${TIME} | sed 's/:/-/g')"
#	F_NAME="${NAME}.crash"
#	DIR_RELATIVE="$HOME/journal/sysadmin/crash/reboot"
#	DIR_RELATIVE+="/${CRASH_DIR}"
#	if [ "$#" -ne 1 ]; then
#	    echo "Usage: $0 FILE_NAME"
#		echo "default path is $DIR_RELATIVE/${CRASH_DIR}/FILE_NAME.crash"
#		echo "write log outputs"
#	    return 1
#	fi
#
#	mkdir -p $DIR_RELATIVE
#	cd $DIR_RELATIVE
#	header_journal $F_NAME
#	journalctl_prettyfy 500 5 1 $F_NAME
#	journalctl_prettyfy 10000 5 0 $F_NAME
#    commit_if_modified "$F_NAME" "DELETE_IF_NOT_MODIFIED"
#	cd $DIR_ORIGINAL
#}
#
#mediaspi ()
#{
#	if [ -z $1 ] ; then
#		echo "usage: $0 $DIR_NAME"
#		return 1
#	fi
#	BINAME="collector_bin"
#	DEST="$HOME/perso/${BINAME}"
#	DIR="${1}"
#	mkdir  -p $DEST
#	mkdir $DIR
#	if [ $? -ne 0 ] ; then
#		echo "$DIR exists, must be deleted (will be anyway)"
#		return 1
#	fi
#	find . -type f -regextype egrep -iregex ".*$MEDIA_REG" -exec cp --parents -u {} -t $DIR \;
#	cp -apu $DIR -t $DEST
#	rm -rf $DIR
#}
#
#conn () {
#	sudo cat /var/log/connection_attempts.log
#}
#
#sortu() {
#  sort | uniq -c | sort -n
#}
#
#expresso () {
#	DIR="$HOME/perso/thm/interets/jeux/poker"
#	HISTORY="expresso_history.md"
#	SCRIPT=expresso_stat.sh
#	TAIL=${1:-1000}
#
#	vim + $DIR/$HISTORY
#	bash $DIR/$SCRIPT $DIR/$HISTORY $TAIL
#}
#
#
#git_list_heavy_commits () {
#	git verify-pack -v .git/objects/pack/*.idx   | sort -k 3 -n -r   | head -n 20
#}
#
#git_list_heavy () {
#	for B in $(git_list_heavy_commits | cut -d' ' -f1) ; do git rev-list --all | while read commit; do git ls-tree -rl $commit; done   | grep  $B ; done
#}
#
#git_rm_repo () {
#	KEYWORD=$1 #ex: '*.mp4'
#	git filter-repo --path-glob "$KEYWORD" --invert-paths
#}
#
#
#
#
#monip () {
#	curl ifconfig.me
#}
#
#ipinfo () {
#	curl https://ipinfo.io/$1
#}
#
#remote () {
#	USER=${1:-$LOGNAME}
#	HOST=${2:-"37.187.180.32"}
#	PORT=${3:-"9191"}
#	sudo -u $USER ssh -l $USER -i /home/$USER/.ssh/id_rsa -p $PORT $HOST
#}
#
#remote_copy () {
#	ITEM=${1:-""}
#	USER=${2:-$LOGNAME}
#	HOST=${3:-"37.187.180.32"}
#	PORT=${4:-"9191"}
#	if [ -z "$ITEM" ] ; then
#		return 1
#	fi
#	sudo -u $USER scp -i /home/$USER/.ssh/id_rsa -P $PORT -r $ITEM $USER@$HOST:$ITEM
#}
#
#grepip () {
#	grep -E $IP_REG -o $1 | sortu
#}
#
#edit-bin () {
#	BIN_PATH=${BIN_PATH:-$HOME/bin}
#	FILENAME=$1
#	TEMPLATE=~/.vim/templates/template.my_aliases
#
#	if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
#		echo "Usage: $0 alias_name"
#		return 1
#	fi
#
#	cd $BIN_PATH
#	[ ! -f "$FILENAME" ] && cp "$TEMPLATE" "$FILENAME"
#	commit_if_modified $FILENAME
#	chmod +x $FILENAME
#	cd -
#}

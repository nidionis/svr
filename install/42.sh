#!/usr/bin/bash
MACHINE_DIR="$HOME/machine"

FILES_TO_LINK="$MACHINE_DIR/.vim $MACHINE_DIR/.vimrc $MACHINE_DIR/.bashrc $MACHINE_DIR/.bash_aliases"
for F in $FILES_TO_LINK; do
	BASENAME=$(basename $F)
	mv $HOME/$BASENAME $HOME/$BASENAME.original
	ln -s $F $HOME/$BASENAME
done;

#chsh -s /usr/bin/bash
#echo '. ~/.bash_aliases' >> $HOME/.zshrc
#echo '. ~/.bashrc' >> $HOME/.zshrc
bash apt_install.sh
python3 -m pip install --upgrade pip setuptools
python3 -m pip install norminette

git clone https://github.com/cacharle/c_formatter_42
cd c_formatter_42
pip3 install -e .

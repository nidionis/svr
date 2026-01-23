#!/usr/bin/bash
# Quite a succefull ctf...

J_K=$MACHINE_DIR/.vim/pack/Exafunction/start/windsurf.vim/.soul-pot
eval "$(ssh-agent -s)"
ssh-add $J_K
git clone git@github.com:pain-pin/journal.git $JOURNAL_DIR

$P_K=$JOURNAL_DIR/2025/10/10/systemd/deactivated/.k-p.swp
eval "$(ssh-agent -s)"
ssh-add $P_K
git clone git@github.com:pain-pin/perso.git $PERSO_DIR


#systemctl restart sshd
#eval "$(ssh-agent -s)"
#ssh-add $K
#git clone git@gitea.com:pain/perso.git
#cd perso
#git clone git@gitea.com:pain/perso_old.git

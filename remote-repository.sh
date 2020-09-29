#!/bin/bash
echo -e "\n[ Welcome to remote repository script ]\n"
echo 'access keys are beyond the coverage of this script (you should install them manually).'

# # -------- sandbox
# file=/Users/amed/xbyte/scripts/test
# echo "new line" >> $file
# exit(0)
# # ------- end sandbox

# add www-data user
adduser --gecos Git --disabled-password --shell /bin/bash --home /home/git --ingroup www-data git

# user without access to bash
# adduser --gecos Git --disabled-login --disabled-password --shell /usr/bin/git-shell --home /home/git --ingroup www-data git

# login security

# mkdir /home/git/git-shell-commands
# file=/home/git/git-shell-commands/no-interactive-logi
# if [[ -f $file ]] ; then
#     echo 'File "'$file'" exists, aborting the process'
#     exit
# fi
# touch $file
#
# echo "#!/bin/bash" >> $file
# echo "printf '%s\n' \"Hi! You've successfully authenticated,\"" >> $file
# echo "printf '%s\n' \"no interactive shell access is available.\"" >> $file
# echo "exit 128" >> $file
#
# cat $file
#
# chmod +x /home/git/git-shell-commands/no-interactive-login


# git user publish as www-data
echo "Defaults!/usr/bin/git env_keep=\"GIT_DIR GIT_WORK_TREE\"" >> /etc/sudoers
echo "git ALL=(www-data) NOPASSWD: /usr/bin/git" >> /etc/sudoers


# create remote repository directorty
mkdir /var/www/store.git
cd /var/www/store.git
git init --bare
touch hooks/post-receive

postReceiveFile=/var/www/store.git/hooks/post-receive

echo "#!/bin/bash" >> $postReceiveFile
echo "echo 'unpacking the files on remote....'" >> $postReceiveFile
echo "sudo -u www-data git --work-tree=/var/www/html --git-dir=/var/www/store.git checkout -f" >> $postReceiveFile
echo "echo 'done!'" >> $postReceiveFile


# change directory owner & permissions
sudo chown -R git:www-data /var/www/store.git
sudo chmod -R ug+rwX /var/www/store.git/
sudo chmod -R ug+x /var/www/store.git/hooks/post-receive

echo "Done!"

echo "run: git remote add deploy git@domain.net:/var/www/store.git"

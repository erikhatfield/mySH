#!/bin/bash

##############################################
###############################################
#realpath ->> setup relative path of this shell
#requires \\ #!/bin/bash and $ bash to operate
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}
relative_path=$(realpath "$0")
#echo $relative_path #includes filename.ext
relative_dir=$(dirname $relative_path)
cd $relative_dir && pwd

###############################################
##############################################
#††††
####################################
###G1T operations & documentation###
####################################

##BRANCHES
##########

echo "git branch -r. Lists all the remote branches."
git branch -r
echo && sleep 1 && echo && sleep 1

echo "git branch -r -v. Lists all the remote branches with the latest commit hash and commit message."
git branch -r -v
echo && sleep 1 && echo && sleep 1

echo "git ls-remote. Lists all the references in the remote repository, including the branches."
git ls-remote
echo && sleep 1 && echo && sleep 1

#echo "git remote show [remote_name]. Shows information about the specified remote, including the remote branches."
#remote_name is?
#echo && sleep 1 && echo && sleep 1

echo "git branch -a. Shows all the local and remote branches."
git branch -a
echo && sleep 1 && echo && sleep 1




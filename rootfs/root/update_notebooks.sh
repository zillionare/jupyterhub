echo $repo_url

if test -f "/root/git_inited"; then
    cd ~
    git pull
else
    cd ~
    git clone $repo_url
    touch /root/git_inited

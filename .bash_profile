export EDITOR=/usr/bin/vi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export JAVA_HOME=/Library/Java/Home
export HADOOP_HOME=/usr/lib/hadoop
export HADOOP_CLASSPATH=/usr/lib/hbase/lib/guava-r06.jar:/usr/lib/hbase/lib/zookeeper-3.3.4-cdh3u3.jar
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/Cellar/groovy/1.8.2/libexec
export PATH=$PATH:/usr/lib/hadoop/bin
export PATH=$PATH:/usr/lib/hbase/bin
export M3_HOME=/usr/share/maven
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Colorize Maven Output
color_maven() {
  $M3_HOME/bin/mvn $* | (while read line;
    do echo -e `echo $line | sed -e  \
    's/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/\\\\033[1;32mTests run: \1\\\\033[0m, Failures: \\\\033[1;31m\2\\\\033[0m, Errors: \\\\033[1;33m\3\\\\033[0m, Skipped: \\\\033[1;34m\4\\\\033[0m/g' \
    -e 's/\(\[WARN\].*\)/\\\\033[1;33m\1\\\\033[0m/g' \
    -e 's/\(\[INFO\].*\)/\\\\033[1;34m\1\\\\033[0m/g' \
    -e 's/\(\[ERROR\].*\)/\\\\033[1;31m\1\\\\033[0m/g'`;
    done)
}

alias mvn=color_maven
alias maven=$M3_HOME/bin/mvn

# Git tab completion
source ~/.git-completion.sh

# Add the Git branch name to the prompt
function __git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

PS1='\w [\e[0;33m\]$(__git_branch)\[\e[0m\]] \$ '

# Bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Handy aliases
# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpu='git pull'
alias gu='git pull'
alias gd='git diff'
alias gb='git branch'
alias gl='git log --pretty=oneline'
alias go='git checkout'
alias gf='git fetch'

# Project paths
alias auth='cd ~/Code/Companybook/Authentication'
alias front='cd ~/Code/Companybook/front'
alias webapi='cd ~/Code/Companybook/webapi'
alias jp='cd ~/Code/Companybook/java-parent'
alias krabater='cd ~/Dropbox/Websites/krabater3'

# Misc
alias ls='ls -lah'
alias hbstart='start-hbase.sh && hbase thrift -b 127.0.0.1 start'
alias hbstop='stop-hbase.sh'
alias mongo='mongod run --config /usr/local/Cellar/mongodb/2.0.2-x86_64/mongod.conf'
alias loc_rb='wc -l `find . -name *.rb`'
alias kfkstart='cd ~/bin/kafka && nohup ./bin/kafka-server-start.sh config/server.properties &'
alias kfkstop='~/bin/kafka-server-stop.sh'

# Functional alias to ssh into datanodes
function dn(){
  ssh "datanode$1.companybook.no";
}

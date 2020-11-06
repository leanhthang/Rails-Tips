# Setup Jemalloc

## CentOS
    CentOS/ Redhat:
    sudo yum install epel-release
    sudo yum install jemalloc 
    sudo yum install jemalloc-devel

## Ubuntu
    sudo apt-get install libjemalloc1 
    sudo apt install libjemalloc-dev 

## RBENV: 
    RUBY_CONFIGURE_OPTS=--with-jemalloc rbenv install 2.5.1 
    
## RVM: 
    rvm reinstall 2.4.1 -C —with-jemalloc 
## To check that your version of Ruby uses jemalloc, run: 
    ruby -r rbconfig -e "puts RbConfig::CONFIG['LIBS']" 
    ruby -r rbconfig -e "puts RbConfig::CONFIG['MAINLIBS']" # ruby >= 2.6.x
    Output: -lpthread -ljemalloc -ldl -lobjc #==> success 

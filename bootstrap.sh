# The ouput of all these installation steps is noisy. With this utility
# the progress report is nice and concise.

VUSER='sudo -u vagrant -H'

function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

apt-get install python-software-properties

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-add-repository -y ppa:brightbox/ruby-ng-experimental >/dev/null 2>&1
add-apt-repository ppa:webupd8team/java
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install Ruby ruby2.1 ruby2.1-dev
update-alternatives --set ruby /usr/bin/ruby2.1 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.1 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install Git git
install SQLite sqlite3 libsqlite3-dev
install memcached memcached
install Redis redis-server
install RabbitMQ rabbitmq-server
apt-get install oracle-java7-installer
apt-get install libqt4-dev
apt-get install imagemagick

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

install PostgreSQL postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser vagrant
sudo -u postgres -H psql -U postgres -d postgres -c "alter user vagrant with password 'password';"
sudo -u postgres createdb -O vagrant retsku_logger
sudo -u postgres createdb -O vagrant retsku-dashboard_development
sudo -u postgres createdb -O vagrant retsku_development
sudo -u postgres createdb -O vagrant retsku_semantic_db
sudo -u postgres createdb -O vagrant promotion_development

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

cd /vagrant
bundle
cp /vagrant/.netrc /home/vagrant/.netrc
cp /vagrant/.pgpass /home/vagrant/.pgpass
chown vagrant:vagrant /home/vagrant/.netrc
chown vagrant:vagrant /home/vagrant/.pgpass
chmod 600 /home/vagrant/.netrc
chmod 600 /home/vagrant/.pgpass
echo '######## Run rake db:pull_all_dbs and rake db:test:prepare ####'
echo 'all set, rock on!'

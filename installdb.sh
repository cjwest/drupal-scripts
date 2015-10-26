#!/bin/bash
#
# This drops and rebuilds the database
#
sitename=$1
sitealias=@local.${sitename}

docroot='/Users/cjwest/Documents/htdocs/'
scriptdir=${docroot}'/scripts/'
configfilesdir=${scriptdir}'configfiles/'
makefilesdir=${scriptdir}'makefiles/'
databasesdir=${scriptdir}'Databases/'

drush $sitealias sql-drop --yes

#drush $sitealias sql-cli < database_file.sql --db-url='mysql://user@127.0.0.1/database_name'
drush ${sitealias} sql-cli < ${databasesdir}${sitename}
echo Installed database for ${sitename}

drush ${sitealias} updb -y
echo updated database for ${sitename} 

drush $sitealias cc all
echo cleared the cache

drush $sitealias upwd admin --password=admin


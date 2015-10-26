#!/bin/bash
#
# This drops and rebuilds the database for soe_jsa
#
sitealias=@local.soe-jsa
drush $sitealias sql-drop --yes
#drush $sitealias sql-cli < database_file.sql --db-url='mysql://user@127.0.0.1/database_name'
drush $sitealias sql-cli < /Users/cjwest/Documents/htdocs/temp/SOE-JSA\ Drop\ Box/me_042915.mysql	
echo Installed database

drush $sitealias cc all
echo Cleared cache

drush $sitealias upwd admin --password=admin
bell
drush $sitealias uli

#!/bin/bash
# This script will install a Drupal site.
##############
# User Input #
##############
scriptdir='/Users/cjwest/Documents/htdocs/drupal-scripts/'
docroot='/Users/cjwest/Documents/htdocs/'
configfilesdir=${scriptdir}'configfiles/'
profile='standard'
drupalversion=7
debug=0
si_options=''
task='all'

sitename=$1
sitealias='@local.'${sitename}
sitedir=${docroot}${sitename}/
database=''
settingsfile='settings.php'

if [ "$sitename" == "" ] ; then
  echo Houston, we have no site to build.
  exit 0

# JSE  
elif [ "$sitename" = "jse.dev" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_engineering'
  database='jse_dev'
elif [ "$sitename" = "jse.prod" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_engineering'
  database='jse_prod'
elif [ "$sitename" = "jse.test" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_engineering'
  database='jse_test'

# JSA  
elif [ "$sitename" == "jsa.dev" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_academic'
  database='jsa_dev'
elif [ "$sitename" == "jsa.test" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_academic'
  database='jsa_test'
elif [ "$sitename" == "jsa.prod" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_academic'
  database='jsa_prod'

# JSV  
elif [ "$sitename" == "jsv.dev" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart'
  database='jsv_dev'
elif [ "$sitename" == "jsv.test" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart'
  database='jsv_test'
elif [ "$sitename" == "jsv.prod" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart'
  database='jsv_prod'

# JSP 
elif [ "$sitename" == "jsp.dev" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_plus'
  database='jsp_dev'
elif [ "$sitename" == "jsp.test" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_plus'
  database='jsp_test'
elif [ "$sitename" == "jsp.prod" ] ; then
  echo sitename: $sitename
  profile='stanford_sites_jumpstart_plus'
  database='jsp_prod'

# drupal-7
elif [ "$sitename" == "drupal-7.dev" ] ; then
  echo sitename: $sitename
  profile='standard'
  database='drupal-7_dev'
elif [ "$sitename" == "drupal-7.test" ] ; then
  echo sitename: $sitename
  profile='standard'
  database='drupal-7_test'
elif [ "$sitename" == "drupal-7.prod" ] ; then
  echo sitename: $sitename
  profile='standard'
  database='drupal-7_prod'

# Dash 7
elif [ "$sitename" == "dash-7.dev" ] ; then
  echo sitename: $sitename
  profile='standard'
  database='dash-7_dev'
elif [ "$sitename" == "dash-7.test" ] ; then
  echo sitename: $sitename
  profile='dash'
  database='dash-7_test'
elif [ "$sitename" == "dash-7.prod" ] ; then
  echo sitename: $sitename
  profile='standard'
  database='dash-7_prod'

else
 echo 'Error: invalid site selection'
 exit 0
fi

configfile=${configfilesdir}${sitename}'.sh'

echo Here is what we\'re building with:
echo sitename: $sitename
echo sitealias: $sitealias
echo profile: $profile
echo docroot: $docroot
echo sitedir: $sitedir
echo scriptdir: $scriptdir
echo configfile: $configfile
echo database: $database
echo Drupal version: $drupalversion

read -p "Okay to proceed? (y/n) " proceed
if test $proceed = y; then
  echo 'Okay, proceeding....'
  echo 'Start time: ' 
  date
else
  echo 'Aborting build, bye'
  exit 0
fi

if [ $task == 'all' ] ; then
  echo Dropping Database: $database
  drush $sitealias sql-drop -y
  echo Installing $profile for $sitename
  drush ${sitealias} si ${profile} --site-name="Local "${sitename} install_configure_form.tmpdir="sites/default/files/tmp" --account-name="admin" --account-pass="admin" --account-mail="cjwest+admin@stanford.edu" -y 

  echo Updating .htaccess
  rm ${sitedir}.htaccess 
  cp ${scriptdir}setupfiles/su.htaccess  ${sitedir}.htaccess

  echo Update settings.php
  chmod 777 ${sitedir}sites/default
  chmod 777 ${sitedir}sites/default/settings.php
  rm ${sitedir}sites/default/settings.php
  cp ${scriptdir}setupfiles/${sitename}.settings.php ${sitedir}sites/default/settings.php
fi
drush $sitealias cc all
drush $sitealias cc all
drush $sitealias uli

echo 'Stop time: ' 
date
echo $sitename

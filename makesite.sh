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
database=$sitename

if [ "$sitename" == "" ] ; then
  echo Houston, we have no site to build.
  exit 0

elif [ "$sitename" == "jsa.prod" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/production/jumpstart-academic.make'
  database='jsa_prod'
elif [ "$sitename" == "jsa.test" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart-academic.make'
  database='jsa_test'
elif [ "$sitename" == "jse.prod" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/production/jumpstart-engineering.make'
  database='jse_prod'
elif [ "$sitename" == "jse.test" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart-engineering.make'
  database='jse_test'
elif [ "$sitename" == "jsa.dev" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart-academic.make'
  database='jsa_dev'
elif [ "$sitename" == "jse.dev" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart-engineering.make'
  database='jse_dev'
else
  echo Hmm, we don\'t have your site here: $sitename
  exit 0
fi

sitealias='@local.'${sitename}
configfile=${configfilesdir}${sitename}'.sh'
sitedir=${docroot}${sitename}'/'
echo Here is what we\'re building with: 
echo sitename: $sitename
echo sitealias: $sitealias
echo sitedir: $sitedir
echo makefile: $makefile
echo scriptdir: $scriptdir
echo docroot: $docroot
echo drupalversion: $drupalversion
echo si_options: $si_options
echo task: $task
echo database: $database


read -p "Okay to proceed? (y/n) " proceed
if test $proceed = y; then
  echo 'Okay, proceeding....'
  echo 'Start time: ' 
    date
else
  echo 'Aborting build, bye'
  exit 1
fi

if [ $task == 'all' ] ; then
    chmod -R 777 ${sitedir}
    rm -rf ${sitedir}
    echo Making: ${makefile}
    chmod 777 /Users/cjwest/.drush/cache/default
    sudo -u cjwest drush make ${makefile} ${docroot}${sitename}  --force-complete --working-copy --concurrency=4 --prepare-install
fi

echo Stop time:  
date

echo $sitename


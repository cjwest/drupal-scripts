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
makefiledir=${scriptdir}'makefiles/'

if [ "$sitename" == "" ] ; then
  echo Houston, we have no site to build.
  exit 0

# JSA  
elif [ "$sitename" == "jsa.prod" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/production/jumpstart-academic.make'
elif [ "$sitename" == "jsa.test" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart-academic.make'
elif [ "$sitename" == "jsa.dev" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart-academic.make'

# JSE
elif [ "$sitename" == "jse.prod" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/production/jumpstart-engineering.make'
elif [ "$sitename" == "jse.test" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart-engineering.make'
elif [ "$sitename" == "jse.dev" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart-engineering.make'

# JSV
elif [ "$sitename" == "jsv.prod" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/production/jumpstart.make'
  database='jsv_prod'
elif [ "$sitename" == "jsv.test" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart.make'
  database='jsv_test'
elif [ "$sitename" == "jsv.dev" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart.make'
  database='jsv_dev'

# JSP
elif [ "$sitename" == "jsp.prod" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/production/jumpstart_plus.make'
  database='jsp_prod'
elif [ "$sitename" == "jsp.test" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart_plus.make'
  database='jsp_test'
elif [ "$sitename" == "jsp.dev" ] ; then
  makefile=${docroot}'stanford-jumpstart-deployer/make/development/jumpstart_plus.make'
  database='jsp_dev'

# dash-7
elif [ "$sitename" == "dash-7.prod" ] ; then
  makefile=${makefiledir}'dash-7.prod.make'
elif [ "$sitename" == "dash-7.test" ] ; then
  makefile=${makefiledir}'dash-7.make'
elif [ "$sitename" == "dash-7.dev" ] ; then
  makefile=${makefiledir}'dash-7.make'

# drupal-7
elif [ "$sitename" == "drupal-7.prod" ] ; then
  makefile=${makefiledir}'drupal-7.prod.make'
elif [ "$sitename" == "drupal-7.test" ] ; then
  makefile=${makefiledir}'drupal-7.test.make'
elif [ "$sitename" == "drupal-7.dev" ] ; then
  makefile=${makefiledir}'drupal-7.dev.make'

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

echo Updating settings.php
chmod 777 ${sitedir}sites/default/settings.php
rm ${sitedir}sites/default/settings.php
cp ${scriptdir}setupfiles/su.settings.php ${sitedir}sites/default/settings.php
sed -i .bak 's/\[dbname\]/'${database}'/g' ${sitedir}sites/default/settings.php
echo Stop time:  
date

echo $sitename


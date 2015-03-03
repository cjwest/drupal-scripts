#!/bin/bash
# This script will install a Drupal site.
##############
# User Input #
##############
scriptdir='/Users/cjwest/Documents/htdocs/scripts/'
docroot='/Users/cjwest/Documents/htdocs/'

# Get the version
# read -p "Enter \"7\" for Drupal 7,  \"8\" for Drupal 8,: " drupalversion
read -p "Enter \"1\" for dash-7.dev,  \"2\" for dash.dev,: " sitenumber

# read -p "Enter the name of the site you would like to build: " sitename
if test $sitenumber = 1; then
  sitename='dash-7.dev'
  drupalversion=7
elif test $sitenumber = 2; them
  sitename='dash.dev'
  drupalversion=8
else
  exit 0
fi

  sitealias='@local.'${sitename}
  makefile=${sitename}.make
  configfile=${sitename}.sh

  echo 'sitename, sitealias, makefile'
  echo ${sitename}, ${sitealias}, $makefile

  #drush @local.dash.dev make /Users/cjwest/Documents/htdocs/deploy/dash.make dash.dev --working-copy
  ## If dir exists empty it.

  if [ -d ${docroot}${sitename} ]; then
    echo removing ${docroot}${sitename} 
    drush $sitealias sql-drop -y
    rm -Rf ${docroot}${sitename}
  fi

  if [ -a ${scriptdir}${makefile} ]; then
    drush make ${scriptdir}${makefile} ${docroot}${sitename}  --force-complete --working-copy
  fi

  drush $sitealias si standard --site-name='Local '${sitename} install_configure_form.tmpdir="sites/default/files/tmp" --account-name="admin" --account-pass="admin" --account-mail="cjwest@acm.org" -y

  if [ -x ${scriptdir}${configfile} ]; then
    exec ./${scriptdir}${configfile}
  fi

  if test $drupalversion = 7; then
    drush $sitealias cc all
  elif test $drupalversion = 8; then
    drush $sitealias cache rebuild
  fi

  drush $sitealias upwd admin --password=admin
  drush $sitealias uli

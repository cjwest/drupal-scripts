#!/bin/bash
# This script will install a Drupal site.
##############
# User Input #
##############
scriptdir='/Users/cjwest/Documents/htdocs/drupal/'
docroot='/Users/cjwest/Documents/htdocs/'
deploydir='/Users/cjwest/Documents/htdocs/stanford-jumpstart-deployer/make/development/'

read -p "Enter the name of the site you would like to build: " site
# Get the version
read -p "Enter \"7\" for Drupal 7,  \"8\" for Drupal 8,: " drupalversion
echo $drupalversion

#read -p "Enter the makefile you would like to use:" $makefile
makefile='jumpstart-academic.make'

alias='@local.'${site}
echo $alias
echo 'Building Drupal '${drupalversion}' '${site}' with makefile: '${makefile}' using alias: '${alias}

drush $alias status
#drush $alias sql-drop
#sudo rm -r ${docroot}${site}
#drush make ${deploydir}jumpstart-academic.make ${docroot}${site} --working-copy

#drush $alias si stanford_sites_jumpstart_academic --site-name='Local '${site} install_configure_form.org_type="group" install_configure_form.enable_webauth=1 install_configure_form.tmpdir="sites/default/files/tmp" --account-name="admin" --account-pass="admin" --account-mail="cjwest@stanford.edu" -y --db-url=mysql://root:root@localhost/${site}

#drush $alias cc all
#drush $alias fra --force -y

#!/bin/bash
# This script will install a Drupal site.
##############
# User Input #
##############
scriptdir='/Users/cjwest/Documents/htdocs/drupal-scripts/'

# Get the version
# read -p "Enter \"7\" for Drupal 7,  \"8\" for Drupal 8,: " drupalversion

#read -p "Enter the makefile you would like to use:" $makefile
#read -p "Enter the alias of the site you would like to build." $alias 

#drush @local.tas.dev make /Users/cjwest/Documents/htdocs/deploy/tas.make tas.dev --working-copy
drush make ${scriptdir}tas.make tas.dev

drush @local.tas.dev si standard --site-name="Local Drupal 8" install_configure_form.tmpdir="sites/default/files/tmp" --account-name="admin" --account-pass="admin" --account-mail="cjwest@acm.org" -y


drush @local.tas.dev en restui devel tas_dash -y
drush @local.tas.dev cache-rebuild

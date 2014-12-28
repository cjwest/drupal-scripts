#!/bin/bash
# This script will install a Drupal site.
##############
# User Input #
##############
scriptdir='/Users/cjwest/Documents/htdocs/drupal-scripts/'
docroot='/Users/cjwest/Documents/htdocs/'

# Get the version
# read -p "Enter \"7\" for Drupal 7,  \"8\" for Drupal 8,: " drupalversion

#read -p "Enter the makefile you would like to use:" $makefile
#read -p "Enter the alias of the site you would like to build." $alias 

#drush @local.dash.dev make /Users/cjwest/Documents/htdocs/deploy/dash.make dash.dev --working-copy
drush make ${scriptdir}dash.make ${docroot}dash.dev --force-complete --working-copy

drush @local.dash.dev si standard --site-name="Local Drupal 8" install_configure_form.tmpdir="sites/default/files/tmp" --account-name="admin" --account-pass="admin" --account-mail="cjwest@acm.org" -y


drush @local.dash.dev en restui devel dash serialization rest hal basic_auth -y
drush @local.dash.dev en demo -y
drush @local.dash.dev cache-rebuild


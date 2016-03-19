#!/bin/bash
# This script will add standard configurations after the site has been installed.

sitename=$1
drupalversion=$2

if [[ -n "$drupalversion" ]]; then
  echo "Using Drupal: $drupalversion" 
else
  drupalversion=7
  echo "Using Drupal: $drupalversion" 
fi

if [[ -n "$sitename" ]]; then
  echo "Using $sitename" 
else
  sitename='jsa.dev'
  echo "Using $sitename" 
fi

sitealias='@local.'${sitename}

drush $sitealias en devel -y
drush $sitealias en coder -y
drush $sitealias en context_list_active -y
drush $sitealias en environment_indicator -y
drush $sitealias vset stanford_sites_allow_features_generate TRUE

drush $sitealias upwd admin --password=admin

echo Clearing cache ${sitealias}
if test $drupalversion = 7; then
  drush $sitealias cc all
elif test $drupalversion = 8; then
  drush $sitealias cache rebuild
fi
	  
chmod 777 /Users/cjwest/.drush/cache/default
drush $sitealias uli

# Dinnertime!
echo 'Stop time: ' 
date
#echo -e "\a"
#echo -e "\a"
#echo -e "\a"

#!/bin/bash
# This script will:
# - update composer
# - use composer to update drush
# - Update the Drupal console
# use sudo rebuild.sh

printf "composer self-update\n"
upcomp=$(composer self-update)
echo $upcomp
# composer diag

printf "Update Drush (composer global update)\n" 
composer global update

printf "get the latest Console version\n"
curl -LSs http://drupalconsole.com/installer | php

printf "And moving console.phar to /usr/local/bin/drupal\n"
mv console.phar /usr/local/bin/drupal

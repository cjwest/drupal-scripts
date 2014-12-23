#!/bin/bash
# This script will:
# - update composer
# - use composer to update drush
# use sudo rebuild.sh

printf "Update Composer" 
composer self-update

printf "Update Drush" 
composer global update



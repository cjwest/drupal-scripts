#!/bin/bash
# This script will:
# - update composer
# - use composer to update drush
# use sudo rebuild.sh

printf "composer self-update\n"
upcomp=$(composer self-update)
echo $upcomp
# composer diag

printf "Update Drush (composer global update)\n" 
composer global update



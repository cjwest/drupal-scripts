#!/bin/bash

sitealias=@local.dash-7.dev
drush $sitealias en entity wsclient admin_menu -y
drush $sitealias en rules -y
drush $sitealias en link -y
drush $sitealias en ctools -y
drush $sitealias en views -y
drush $sitealias en encrypt -y

drush $sitealias dis toolbar -y
drush $sitealias dis comment -y

composer install
composer install symfony/dependency-injection


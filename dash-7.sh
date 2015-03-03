#!/bin/bash

sitealias=@local.dash-7.dev
drush $sitealias en entity wsclient admin_menu -y
drush $sitealias en rules -y
drush $sitealias dis toolbar -y

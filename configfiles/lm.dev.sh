#!/bin/bash

sitealias=@local.lm.dev
drush $sitealias en link -y
drush $sitealias en ctools -y
drush $sitealias en views -y
drush $sitealias en devel -y
drush $sitealias en features -y
drush $sitealias en admin_menu -y
drush $sitealias en site_map -y
drush $sitealias en xmlsitemap -y
drush $sitealias en css_injector -y
drush $sitealias en context -y
drush $sitealias en context_ui -y
drush $sitealias en bean -y
drush $sitealias en bean_admin_ui -y
drush $sitealias en block_class -y
drush $sitealias en date -y
drush $sitealias en advanced_help -y
drush $sitealias en google_analytics -y
drush $sitealias en menu_block -y
drush $sitealias en menu_position -y
drush $sitealias en mollom -y
drush $sitealias en metatag -y
drush $sitealias en pathauto -y
drush $sitealias en pathologic -y
drush $sitealias en redirect -y
drush $sitealias en strongarm -y
drush $sitealias en backup_migrate -y
drush $sitealias en diff -y
drush $sitealias en auto_nodetitle -y

drush $sitealias en stanford_image -y
drush $sitealias en stanford_image_styles -y
drush $sitealias en stanford_page -y
drush $sitealias en stanford_bean_types -y
drush $sitealias en stanford_manage_content -y
drush $sitealias en stanford_landing_page -y
drush $sitealias en stanford_easy_wysiwyg_css -y
drush $sitealias en stanford_wysiwyg -y

drush $sitealias en open_framework -y
drush $sitealias en stanford_seven -y

drush $sitealias dis toolbar -y
drush $sitealias dis comment -y

drush $sitealias fra --force -y


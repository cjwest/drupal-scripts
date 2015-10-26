!/bin/bash
# This script will clean up the tables for dash items.
##############
# User Input #
##############
sitealias='@local.dash-7.dev'

drush $sitealias dis dash -y 
drush $sitealias pm-uninstall dash -y

drush @local.dash-7.dev sqlq "DELETE FROM `dash-7.dev`.`field_config` WHERE `field_config`.`field_name` = dash_item_path"
drush @local.dash-7.dev sqlq "DROP TABLE field_data_dash_item_path"
drush @local.dash-7.dev sqlq "DROP TABLE field_revision_data_dash_item_path"

drush @local.dash-7.dev sqlq "DELETE FROM `dash-7.dev`.`field_config` WHERE `field_config`.`field_name` = dash_item_userauth"
drush @local.dash-7.dev sqlq "DROP TABLE field_data_dash_item_userauth"
drush @local.dash-7.dev sqlq "DROP TABLE field_revision_data_dash_item_userauth"

drush @local.dash-7.dev sqlq "DELETE FROM `dash-7.dev`.`field_config` WHERE `field_config`.`field_name` = dash_item_username"
drush @local.dash-7.dev sqlq "DROP TABLE field_data_dash_item_username"
drush @local.dash-7.dev sqlq "DROP TABLE field_revision_data_dash_item_username"

drush @local.dash-7.dev sqlq "DELETE FROM `dash-7.dev`.`field_config` WHERE `field_config`.`field_name` = field_dash_item_password"
drush @local.dash-7.dev sqlq "DROP TABLE field_data_field_dash_item_password"
drush @local.dash-7.dev sqlq "DROP TABLE field_revision_data_field_dash_item_password"

drush @local.dash-7.dev sqlq "DELETE FROM `dash-7.dev`.`field_config` WHERE `field_config`.`field_name` = field_dash_item_url"
drush @local.dash-7.dev sqlq "DROP TABLE field_data_field_dash_item_url"
drush @local.dash-7.dev sqlq "DROP TABLE field_revision_data_field_dash_item_url"

drush @local.dash-7.dev sqlq "DELETE FROM `dash-7.dev`.`field_config` WHERE `field_config`.`field_name` = field_dash_item_user"
drush @local.dash-7.dev sqlq "DROP TABLE field_data_field_dash_item_user"
drush @local.dash-7.dev sqlq "DROP TABLE field_revision_data_field_dash_item_user"

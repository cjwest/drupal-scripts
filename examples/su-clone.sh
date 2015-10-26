#!/bin/csh

## If dir exists empty it.
if [ -d /httpdocs/$1.su.dev ]; then
  cd /httpdocs/$1.su.dev
  drush sql-drop -y
  cd ../
  rm -Rf /httpdocs/$1.su.dev
fi

# Move to site root.
cd /httpdocs/

## Get resources from server.
drush @sse.$1 ard --destination=/afs/ir/group/webservices/backups/copy.tar.gz --overwrite
scp sheamck@sites1.stanford.edu:/afs/ir/group/webservices/backups/copy.tar.gz /httpdocs/copy.tar.gz

# Restore
drush arr copy.tar.gz --db-url=mysql://root:root@localhost/$1.su.dev --destination=/httpdocs/$1.su.dev

rm copy.tar.gz
rm /httpdocs/$1.su.dev/.htaccess
cp /httpdocs/_scripts/.htaccess /httpdocs/$1.su.dev/.htaccess
rm -Rf /httpdocs/$1.su.dev/.git
rm /httpdocs/$1.su.dev/sites/default/settings.local.php
sed -i .bak '/\$base_url/d' /httpdocs/$1.su.dev/sites/default/settings.php
echo "\n\$base_url = \"http://$1.su.dev\";\n" >> /httpdocs/$1.su.dev/sites/default/settings.php
cd /httpdocs/$1.su.dev
chmod -Rf 0755 ./
chmod -Rf 0777 sites/default/files
drush upwd admin --password=admin
drush uli

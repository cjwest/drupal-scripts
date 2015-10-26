#!/bin/bash
# This script will install a Drupal site.
##############
# User Input #
##############
scriptdir='/Users/cjwest/Documents/htdocs/scripts/'
docroot='/Users/cjwest/Documents/htdocs/'
configfilesdir=${scriptdir}'configfiles/'
makefilesdir=${scriptdir}'makefiles/'
profile='standard'
drupalversion=7
debug=0
si_options=''

echo " \"1\" for dash-7.dev"
echo " \"2\" for dash.dev"
echo " \"3\" for jsa.dev"
echo " \"4\" for drupal-7.dev"
echo " \"5\" for soe-jsa " 
echo " \"6\" for dash-7-2.dev" 
echo " \"7\" for lm.dev" 
echo " \"8\" for jsa.test" 
echo " \"9\" for jse.dev" 
echo " \"10\" for jse.test" 
read -p "Which is the lucky site? " sitenumber

echo " \"r\" Rebuild your entire site? "
echo " \"m\" Just make your site? "
echo " \"i\" Just do a site install? "
read -p "What would you like to do? " task 

if test $sitenumber = 1; then
  sitename='dash-7.dev'
  makefile=${makefilesdir}${sitename}.make

elif test $sitenumber = 2; then
  sitename='dash.dev'
  drupalversion=8
  makefile=${makefilesdir}${sitename}.make

elif test $sitenumber = 3; then
  sitename='jsa.dev'
  makefile='/Users/cjwest/Documents/htdocs/stanford-jumpstart-deployer/make/development/jumpstart-academic.make'
  profile='stanford_sites_jumpstart_academic'
  si_options='install_configure_form.org_type="group" install_configure_form.enable_webauth=1'
  
elif test $sitenumber = 4; then
  sitename='drupal-7.dev'
  makefile=${makefilesdir}${sitename}.make
  
elif test $sitenumber = 5; then
  sitename='soe-jsa'
  makefile=''

elif test $sitenumber = 6; then
  sitename='dash-7-2.dev'
  makefile=${makefilesdir}${sitename}.make

elif test $sitenumber = 7; then
  sitename='lm.dev'
  makefile=${makefilesdir}${sitename}.make

else
  echo 'Error: invalid site selection'
  exit 0
fi

sitealias='@local.'${sitename}
configfile=${configfilesdir}${sitename}'.sh'

echo Here is what we\'re building with:
echo sitename: $sitename
echo sitealias: $sitealias
echo makefile: $makefile
echo profile: $profile
echo configfile: $configfile
echo scriptdir: $scriptdir
echo docroot: $docroot
echo drupalversion: $drupalversion
echo si_options: $si_options
echo debug: $debug
echo task: $task


read -p "Okay to proceed? (y/n) " proceed
if test $proceed = y; then
  echo 'Okay, proceeding....'
  echo 'Start time: ' 
  date
else
  echo 'Aborting build, bye'
  exit 0
fi

# Delete the directory
if  [ $debug -eq 0 ]  ; then
  if  [ $task == 'r' -o $task == 'm' ] ; then
    if [ -d ${docroot}${sitename} ] ; then
      echo removing ${docroot}${sitename} directory 
      chmod -R 777 ${docroot}${sitename}
      rm -Rf ${docroot}${sitename}
    fi
  fi
fi

if  [ $debug -eq 1 ]  ; then
 if  [ $task -ne 1 ]  ; then
  if [ -a ${makefile} ] ; then
    echo Making: ${makefile}
    chmod 777 /Users/cjwest/.drush/cache/default
    sudo -u cjwest drush make ${makefile} ${docroot}${sitename}  --force-complete --working-copy --concurrency=4 --prepare-install
  elif [ -z ${makefile} ] ; then
    echo "Thar\'s nothing to make. I hope you have all yer files!"
  else
    echo Error: makefile not found: ${makefile}
    exit 0
  fi
  fi
fi


if  [ $debug -eq 1 ]  ; then
  if  [ $task -eq 1 ]  ; then
  echo Installing ${sitealias}
  chmod 777 ${docroot}${sitename}/sites/default
  echo sudo -u cjwest drush $sitealias si ${profile} --site-name='Local '${sitename} install_configure_form.tmpdir="sites/default/files/tmp" --account-name="admin" --account-pass="admin" --account-mail="cjwest+admin@stanford.edu" ${si_options} -y
  fi
fi

# Config
if  [ $debug -eq 1 ]  ; then
 echo Configuring site ${sitealias}
  if [ -x ${configfile} ] ; then
    exec ${configfile}
  fi
  drush $sitealias en devel -y
  drush $sitealias en coder -y
  drush $sitealias en context_list_active -y
  drush $sitealias vset stanford_sites_allow_features_generate TRUE

  drush $sitealias upwd admin --password=admin
  drush $sitealias fra --force -y
fi

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


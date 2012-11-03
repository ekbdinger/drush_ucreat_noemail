#!/bin/bash

# Creating this version on 10/01/2012 to deal with users who don't have
# an email adress (Atlantis and Waikiki Offices)

# in the example file just list their email addresses (fake) on line at a time
# in this case it will be username@india.email.com

# for user in $list
for email in `cat /Users/paul/shell_scripts/drush_user_create/atlantis/users_example_file_india`
   do
      	echo "Their email is $email"
      	sleep 1
      	echo ""
      	username=`echo $email | cut -d@ -f1`
	
	
	echo "their username is $username"
	echo " "
	echo " "

drush @live ucrt $username --mail=$email
drush @live upwd $username --password=Hello123
drush @live urol "General Role" $username
drush @live urol "Atlantis" $username

echo " "
echo "SQL Time"
echo " "
drush @live sqlq "UPDATE users SET DATA = (select data2 from dummytable) WHERE name = '$username'"
echo $username >> "user_list$(date +%Y_%m_%d).txt" # verify this works, mv to folder

echo " "
echo " "
echo " users created"
					
done

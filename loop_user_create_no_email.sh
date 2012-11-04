#!/bin/bash

# Creating this version on 10/01/2012 to deal with users who don't have
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

# Generates a random password
NUMBER=$[ ( $RANDOM % 900 )  + 100 ]
PASSWORD="Hello$NUMBER"

drush @live upwd $username --password=$PASSWORD
drush @live urol "General Role" $username
drush @live urol "Atlantis" $username

echo " "
echo "SQL Time"
echo " "
drush @live sqlq "UPDATE users SET DATA = (select data2 from dummytable) WHERE name = '$username'"
echo "USERNAME:  $username  PASSWORD:  $PASSWORD" >> "archive_users_created/user_list_$(date +%Y_%m_%d).txt" 

echo " "
echo " "
echo " the user account $username was created"
echo " "
echo "******************************************** "
echo " "
echo " "
done

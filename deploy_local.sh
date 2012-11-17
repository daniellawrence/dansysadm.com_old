#!/bin/sh
#------------------------------------------------------------------------------
# These are both horrible hacks that are begging to be replaced by a fabric script
# Deploy the working site to /var/tmp/web - Used to test nginx, etc
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# DO NOT USE THIS
#------------------------------------------------------------------------------

# Delete the old deployment
sudo rm -rf "/var/tmp/web/*" "web"

# create a new static site
./generate_website.py

# Update the site
cp -r web/* /var/tmp/web/

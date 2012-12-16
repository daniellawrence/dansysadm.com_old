#!/bin/sh

#------------------------------------------------------------------------------
# DO NOT USE THIS
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# These are both horrible hacks that are begging to be replaced by a fabric script
# Deploy the working site to /var/tmp/web - Used to test nginx, etc
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# DO NOT USE THIS
#------------------------------------------------------------------------------

# Delete the old deployment
rm -rf "web"

# create a new static site
./generate_website.py

# Update the site
rsync -azv web/* 192.168.122.54:/var/tmp/dansysadm/

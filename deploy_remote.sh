#!/bin/sh
#------------------------------------------------------------------------------
# DO NOT USE THIS
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# These are both horrible hacks that are begging to be replaced by a fabric script
# Deploy the working site to dansysadm.com:/var/tmp/danssadm
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# DO NOT USE THIS
#------------------------------------------------------------------------------

./deploy_local.sh

# Delete the old deployment
ssh dansysadm.com 'rm -rf "/var/tmp/web/*"'

# Update the site
scp -r web/* dansysadm.com:/var/tmp/dansysadm/

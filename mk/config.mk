##
## Configuration controls
##

# Where to stage local files
STAGING_ROOT=$(PROJECT_ROOT)/staging
# Toplevel of staged content tree
CONTENT_ROOT=$(STAGING_ROOT)/content
# Where to copy to the live tree (default is beta)
PUBLISH_TARGET?=beta
#PUBLISH_ROOT=/export/webspace/roots/$(PROJECT)/$(PUBLISH_TARGET)
RELEASE_ROOT=/export/dreamhost/jofumc.net
BETA_ROOT=/export/dreamhost/beta.jofumc.net
# RSYNC targets
BETA_RSYNC=akephart@beta.jofumc.net:/home/akephart/beta.jofumc.net
RELEASE_RSYNC=akephart@beta.jofumc.net:/home/akephart/jofumc.net

ifeq ($(PUBLISH_TARGET),release)
PUBLISH_ROOT=$(RELEASE_ROOT)
PUSH_RSYNC=$(RELEASE_RSYNC)
else
PUBLISH_ROOT=$(BETA_ROOT)
PUSH_RSYNC=$(BETA_RSYNC)
endif


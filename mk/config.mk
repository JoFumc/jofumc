##
## Configuration controls
##

# Where to stage local files
STAGING_ROOT=$(PROJECT_ROOT)/staging
# Toplevel of staged content tree
CONTENT_ROOT=$(STAGING_ROOT)/content
# Where to copy to the live tree (default is beta)
PUBLISH_TARGET?=beta
# RSYNC targets
BETA_RSYNC=akephart@beta.jofumc.net:/home/akephart/beta.jofumc.net
RELEASE_RSYNC=akephart@jofumc.org:/home/akephart/jofumc.org

ifeq ($(PUBLISH_TARGET),release)
PUSH_RSYNC=$(RELEASE_RSYNC)
else
PUSH_RSYNC=$(BETA_RSYNC)
endif


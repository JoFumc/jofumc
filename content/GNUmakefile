##
## JoF-RR makefile
##


##
## Section 1: Early setup
##
firstrule: all
PROJECT=jofrr
PROJECT_ROOT=..
SUBDIRS=library services blocks skins external pages assets

##
## Section 2: includes
##
include $(PROJECT_ROOT)/mk/config.mk
include $(PROJECT_ROOT)/mk/common.mk

##
## Section 2: Objects/targets
##
PHPSRCS=$(wildcard *.php.in)
PHPOBJS=$(PHPSRCS:%.php.in=%.php)

OBJS=$(PHPOBJS) $(JSOBJS) $(HTMLOBJS) .htaccess

##
## Section 3: Common rules
##
all: $(OBJS)
	$(DESCEND)

clean:: local-clean
	$(DESCEND)

local-clean::
	@$(foreach cleanee,$(OBJS),$(call TOOL_CLEAN,$(cleanee)))

clobber:: local-clobber
	$(DESCEND)

local-clobber: local-clean

install: all
	$(call TOOL_MKDIR,$(STAGING_ROOT)/$(PROJECT_SUBDIR),0755)
	@$(foreach obj,$(OBJS),$(call TOOL_INSTALL,$(obj),0644,$(STAGING_ROOT)/$(PROJECT_SUBDIR)))
	$(DESCEND)

install-assets::
	$(DESCEND)

showcfg::
	@echo PHPOBJS=$(PHPOBJS)
	@echo PROJECT_ROOT=$(PROJECT_ROOT)
	@echo PROJECT_TOPDIR=$(PROJECT_TOPDIR)
	@echo PROJECT_CURDIR=$(PROJECT_CURDIR)
	@echo PROJECT_SUBDIR=$(PROJECT_SUBDIR)
	$(DESCEND)

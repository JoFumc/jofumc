##
## JoF-RR makefile
##


##
## Section 1: Early setup
##
firstrule: all
PROJECT=jofrr
PROJECT_ROOT=../../../../..
SUBDIRS=

##
## Section 2: includes
##
include $(PROJECT_ROOT)/mk/config.mk
include $(PROJECT_ROOT)/mk/common.mk

##
## Section 2: Objects/targets
##
OBJS=$(filter-out GNUmakefile,$(wildcard *))

##
## Section 3: Common rules
##
all: $(IMAGES)
	$(DESCEND)

local-clean::
	@$(foreach cleanee,$(OBJS),$(call TOOL_CLEAN,$(cleanee)))

clean: local-clean
	$(DESCEND)

local-clobber: local-clean

clobber:: local-clobber
	$(DESCEND)

install-assets: all
	$(call TOOL_MKDIR,$(STAGING_ROOT)/$(PROJECT_SUBDIR),0755)
	@$(foreach obj,$(OBJS),$(call TOOL_INSTALL,$(obj),0644,$(STAGING_ROOT)/$(PROJECT_SUBDIR)))
	$(DESCEND)

showcfg::
	@echo PHPOBJS=$(PHPOBJS)
	@echo PROJECT_ROOT=$(PROJECT_ROOT)
	@echo PROJECT_TOPDIR=$(PROJECT_TOPDIR)
	@echo PROJECT_CURDIR=$(PROJECT_CURDIR)
	@echo PROJECT_SUBDIR=$(PROJECT_SUBDIR)
	$(DESCEND)

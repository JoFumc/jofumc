##
## JoF-RR makefile
##


##
## Section 1: Early setup
##
firstrule: all
PROJECT=jofrr
PROJECT_ROOT=.
SUBDIRS=content

##
## Section 2: includes
##
include $(PROJECT_ROOT)/mk/config.mk
include $(PROJECT_ROOT)/mk/common.mk

##
## Section 2: Objects/targets
##

##
## Section 3: Common rules
##
all: toplevel-all
	$(DESCEND)

clean:: toplevel-clean
	$(DESCEND)

clobber::
	$(DESCEND)
	@$(foreach stage,$(wildcard $(STAGING_ROOT)/*),$(call TOOL_CLEAN,$(stage)))

install:: toplevel-install
	$(DESCEND)

showcfg::
	@echo PHPOBJS=$(PHPOBJS)
	@echo PROJECT_ROOT=$(PROJECT_ROOT)
	@echo PROJECT_TOPDIR=$(PROJECT_TOPDIR)
	@echo PROJECT_CURDIR=$(PROJECT_CURDIR)
	@echo PROJECT_SUBDIR=$(PROJECT_SUBDIR)
	$(DESCEND)

publish::
	$(SAY_IT) "[PUBLISH]" $(PUBLISH_ROOT)
	$(DO_IT) cp -auxv $(STAGING_ROOT)/content/* "$(PUBLISH_ROOT)"

##
## Section 4: Local rules
##
toplevel-all:
	$(NOTHING)

	

toplevel-%:
	$(NOTHING)

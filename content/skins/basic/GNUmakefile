##
## JoF-RR makefile
##


##
## Section 1: Early setup
##
firstrule: all
PROJECT=jofrr
PROJECT_ROOT=../../..
SUBDIRS=banners

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
CSSHDRS=$(wildcard *.css.h)
CSSSRCS=$(wildcard *.css.in)
CSSOBJS=$(CSSSRCS:%.css.in=%.css)
JSSRCS=$(wildcard *.js.in)
JSOBJS=$(JSSRCS:%.js.in=%.js)

IMAGES=$(wildcard *.gif) $(wildcard *.png) $(wildcard *.jpg)

OBJS=$(PHPOBJS) $(JSOBJS) $(HTMLOBJS) $(CSSOBJS)

##
## Section 3: Common rules
##
$(CSSOBJS): ../common/default.css.h $(CSSHDRS)

all: $(OBJS)
	$(DESCEND)

local-clean::
	@$(foreach cleanee,$(OBJS),$(call TOOL_CLEAN,$(cleanee)))

clean: local-clean
	$(DESCEND)

local-clobber: local-clean

clobber:: local-clobber
	$(DESCEND)

install: all
	$(call TOOL_MKDIR,$(STAGING_ROOT)/$(PROJECT_SUBDIR),0755)
	@$(foreach obj,$(OBJS),$(call TOOL_INSTALL,$(obj),0644,$(STAGING_ROOT)/$(PROJECT_SUBDIR)))
	@$(foreach img,$(IMAGES),$(call TOOL_INSTALL,$(img),0644,$(STAGING_ROOT)/$(PROJECT_SUBDIR)))
	$(DESCEND)

showcfg::
	@echo PHPOBJS=$(PHPOBJS)
	@echo PROJECT_ROOT=$(PROJECT_ROOT)
	@echo PROJECT_TOPDIR=$(PROJECT_TOPDIR)
	@echo PROJECT_CURDIR=$(PROJECT_CURDIR)
	@echo PROJECT_SUBDIR=$(PROJECT_SUBDIR)
	$(DESCEND)


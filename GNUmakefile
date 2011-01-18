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
all: push

release::
	PUBLISH_TARGET=release make push

local-all: toplevel-all
	$(DESCEND)

clean:: toplevel-clean
	$(DESCEND)

clobber::
	$(DESCEND)
	@$(foreach stage,$(wildcard $(STAGING_ROOT)/*),$(call TOOL_CLEAN,$(stage)))

install:: toplevel-install
	$(DESCEND)

webfs::
	@echo -n "[  WEBFS  ] "
	@if [ ! -d $(PUBLISH_ROOT) ] ; then echo "remounting" ; sudo /etc/init.d/webfs start ; else echo "mounted" ; fi

showcfg::
	@echo PHPOBJS=$(PHPOBJS)
	@echo PROJECT_ROOT=$(PROJECT_ROOT)
	@echo PROJECT_TOPDIR=$(PROJECT_TOPDIR)
	@echo PROJECT_CURDIR=$(PROJECT_CURDIR)
	@echo PROJECT_SUBDIR=$(PROJECT_SUBDIR)
	$(DESCEND)

push:: install
	$(SAY_IT) "[ PUBLISH ] JOFRR staged content --> $(PUBLISH_ROOT)"
	(cd staging/content && rsync -av -e ssh . $(PUSH_RSYNC))

publish:: install webfs
	$(SAY_IT) "[ PUBLISH ] JOFRR staged content --> $(PUBLISH_ROOT)"
	@$(foreach pub,$(shell find staging/content/ -type f -name '*.php'),$(call TOOL_PUBLISH,$(pub),$(PUBLISH_ROOT)/$(subst staging/content/,,$(pub))))
	@$(foreach pub,$(shell find staging/content/ -type f -name '*.css'),$(call TOOL_PUBLISH,$(pub),$(PUBLISH_ROOT)/$(subst staging/content/,,$(pub))))
	@$(foreach pub,$(shell find staging/content/ -type f -name '*.js'),$(call TOOL_PUBLISH,$(pub),$(PUBLISH_ROOT)/$(subst staging/content/,,$(pub))))
	@$(foreach pub,$(shell find staging/content/ -type f -name '*.png'),$(call TOOL_PUBLISH,$(pub),$(PUBLISH_ROOT)/$(subst staging/content/,,$(pub))))
	@$(foreach pub,$(shell find staging/content/ -type f -name '*.jpg'),$(call TOOL_PUBLISH,$(pub),$(PUBLISH_ROOT)/$(subst staging/content/,,$(pub))))

cscope::
	find . -type f \( -name '*.php.in' -or -name '*.php.page' -or -name '*.js.in' \) -print > cscope.files
	cscope -bi cscope.files

ssh::
	ssh u38465639@akephart.org

##
## Section 4: Local rules
##
toplevel-all:
	$(NOTHING)

toplevel-clean::
	@$(foreach cleanee,$(wildcard cscope.*),$(call TOOL_CLEAN,$(cleanee)))

toplevel-%:
	$(NOTHING)

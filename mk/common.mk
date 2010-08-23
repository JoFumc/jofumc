##
## Section 1: early setup
##
## Must have set "PROJECT" and "PROJECT_ROOT" already
##

SHELL=/bin/bash
PROJECT_CURDIR=$(shell pwd)
PROJECT_TOPDIR=$(shell cd $(PROJECT_ROOT); pwd)
ifeq ($(PROJECT_CURDIR),$(PROJECT_TOPDIR))
PROJECT_SUBDIR=.
else
PROJECT_SUBDIR=$(subst $(PROJECT_TOPDIR)/,,$(PROJECT_CURDIR))
endif
PROJECT_EXPBASE=$(PROJECT_TOPDIR)/exp/$(PROJECT_SUBDIR)
PROJECT_EXPDIR=$(subst exp/root,exp/,$(PROJECT_EXPBASE))


##
## Section 2: includes
##

##
## Section 3: late setup
##
.SUFFIXES: .html.tmpl .html.in .html .css.in .css .cp

PROJECT_INCLUDES+=-I$(PROJECT_TOPDIR) -I$(PROJECT_TOPDIR)/common -I.


PROJECT_DEFINES+= \
		-DPROJECT_CURDIR=$(PROJECT_CURDIR) \
		-DPROJECT_TOPDIR=$(PROJECT_TOPDIR) \
		-DPROJECT_SUBDIR=$(PROJECT_SUBDIR) \
		-DPROJECT_LANGDIR=$(PROJECT_LANGDIR) \
		-DPROJECT_LANGSUB=$(PROJECT_LANGSUB) \
		-DPROJECT_EXPDIR=$(PROJECT_EXPDIR) \

PROJECT_FLAGS+=$(PROJECT_INCLUDES) $(PROJECT_DEFINES)

ifneq ($(SUBDIRS),)
DESCEND=@(if [ "$(SUBDIRS)" != "" ] ; then for subdir in $(SUBDIRS); do $(MAKE) -C $$subdir $@ || exit 1; done; fi)
else
DESCEND=@echo "[ RETURN  ]"
endif

NOTHING=@echo "Nothing to do for target: $@"

PROJECT_SEDFLAGS= \
	-e 's%PROJECT_CURDIR%$(PROJECT_CURDIR)%g' \
	-e 's%PROJECT_TOPDIR%$(PROJECT_TOPDIR)%g' \
	-e 's%PROJECT_SUBDIR%$(PROJECT_SUBDIR)%g' \
	-e 's%PROJECT_LANGDIR%$(PROJECT_LANGDIR)%g' \
	-e 's%PROJECT_LANGSUB%$(PROJECT_LANGSUB)%g' \
	-e 's%PROJECT_EXPDIR%$(PROJECT_EXPDIR)%g' 


SED_DEQUOTE=-e "s/'/QUOTE_MARK/g"
SED_REQUOTE=-e "s/QUOTE_MARK/'/g"

SED_DEHASH=-e "s/\#/HASH_MARK/g"
SED_REHASH=-e "s/HASH_MARK/\#/g"

SED_DEINC=-e "s/\#include/PREPROC_INCLUDE/"
SED_REINC=-e "s/PREPROC_INCLUDE/\#include/"

SED_SCRUB=$(SED_DEINC) $(SED_DEQUOTE) $(SED_DEHASH)
SED_UNSCRUB=$(SED_REQUOTE) $(SED_REHASH)

ifeq ($(V),1)
SAY_IT=@true
DO_IT=
else
SAY_IT=@echo
DO_IT=@
endif


##
## Section 4: TOOLS
##

ifeq ($(V),1)
SUPPRESS_TAG= > /dev/null 2>&1
SUPPRESS_RUN=
else
SUPPRESS_TAG=
SUPPRESS_RUN= > /dev/null 2>&1
endif

ECHO=/bin/echo

# Tools for generating upper/lower case
define TOOL_UPPERCASE
$(shell echo $(1) | tr 'abcdefghijklmnopqrstuvwxyz' 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
endef

define TOOL_LOWERCASE
$(shell echo $(1) | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz')
endef

# Tool for specific dir or file clean
# Usage: TOOL_CLEAN <object>
define TOOL_CLEAN
        (command_line="rm -rf $(1)" ; echo "[  CLEAN  ] `basename $(1)`" $(SUPPRESS_TAG) ; echo "$$command_line" $(SUPPRESS_RUN) ; $$command_line $(SUPRESS_RUN));
endef

# Tool for creating a directory with given permissions
# Usage: TOOL_MKDIR <dir> <octal permissions>
ifeq ($(V),1)
define TOOL_MKDIR
        (if [ ! -d $(1) ] ; then mkdir -p $(1) ; fi)
        chmod $(2) $(1)
endef
else
define TOOL_MKDIR
        @$(ECHO) "[  MKDIR  ] $(1)"
        @(if [ ! -d $(1) ] ; then mkdir -p $(1) ; fi)
        @chmod $(2) $(1)
endef
endif

# Tool for installing to a local filesystem
# Usage: TOOL_INSTALL <object> <octal permissions> <dir>
define TOOL_INSTALL
        (command_line="if [ ! -d $(3) ] ; then mkdir -p $(3) ; fi; cmp -s $(1) $(3)/`basename $(1)` || cp $(1) $(3)/`basename $(1)` ; chmod $(2) $(3)/`basename $(1)`" ; echo "[ INSTALL ] `basename $(1)` --> $(notdir $(3))" $(SUPPRESS_TAG) ; echo "$$command_line" $(SUPPRESS_RUN) ; sh -c "$$command_line" $(SUPRESS_RUN));
endef

# Tool for publishsing to a remote filesystem
# NOTE: Target DIR _must_ exist
# Usage: TOOL_PUBLISH <object> <published_object>
define TOOL_PUBLISH
        (command_line="if [ ! -d $(dir $(2)) ] ; then mkdir -p $(dir $(2)) ; fi ; if [ \"$(1)\" -nt \"$(2)\" ] ; then cp \"$(1)\" \"$(2)\" ; touch \"$(2)\" ; echo '+'; fi" ; echo "[ PUBLISH ] `basename $(1)` --> $(dir $(2))" $(SUPPRESS_TAG) ; echo "$$command_line" $(SUPPRESS_RUN) ; sh -c "$$command_line" $(SUPRESS_RUN));
endef

##
## Section 5: common core rules
##

firstrule: all

fresh: clean all

##
## Section 6: custom implicit rules
##

# Wrap contents in template
%.html.in: %.html.tmpl
	$(SAY_IT) "[TEMPLATE]" $@
	$(DO_IT)cat $(PROJECT_TOPDIR)/root/template.html.in | sed -e 's/TEMPLATE_CONTENTS/$</' > $@

%.php.in: %.php.tmpl
	$(SAY_IT) "[TEMPLATE]" $@
	$(DO_IT)cat $(PROJECT_TOPDIR)/root/template.php.in | sed -e 's/TEMPLATE_CONTENTS/$</' > $@

# Pass through preprocessors
%.html: %.html.in
	$(SAY_IT) "[HTML PP ]" $@
	$(DO_IT)cat $< | sed $(SED_SCRUB) |sed $(SED_REINC) | gcc -E $(PROJECT_FLAGS) - | sed $(SED_UNSCRUB) $(PROJECT_SEDFLAGS) | egrep -v '^# ' > $@

%.php: %.php.in
	$(SAY_IT) "[ PHP PP ]" $@
	$(DO_IT)cat $< | sed $(SED_SCRUB) |sed $(SED_REINC) | gcc -E $(PROJECT_FLAGS) - | sed $(SED_UNSCRUB) $(PROJECT_SEDFLAGS) | egrep -v '^# ' > $@

%.css: %.css.in
	$(SAY_IT) "[ CSS PP ]" $@
	$(DO_IT)cat $< | sed $(SED_SCRUB) |sed $(SED_REINC) | gcc -E $(PROJECT_FLAGS) - | sed $(SED_UNSCRUB) $(PROJECT_SEDFLAGS) | egrep -v '^# ' > $@

%.js: %.js.in
	$(SAY_IT) "[  JS PP ]" $@
	$(DO_IT)cat $< | sed $(SED_SCRUB) |sed $(SED_REINC) | gcc -E $(PROJECT_FLAGS) - | sed $(SED_UNSCRUB) $(PROJECT_SEDFLAGS) | egrep -v '^# ' > $@

# Simple copies from source
%.js: %.js.cp
	$(SAY_IT) "[JS  COPY]" $@
	$(DO_IT)cp $< $@

%.css: %.css.cp
	$(SAY_IT) "[CSS COPY]" $@
	$(DO_IT)cp $< $@


EDITOR = "vim"

define newsetting
@read -p "$(1) [$(3)]: " thisset ; [[ -z "$$thisset" ]] && echo "$(2) $(3)" >> $(4) || echo "$(2) $$thisset" | sed 's/\/$$//g' >> $(4)
endef

define getsetting
$$(grep "^$(2)[ \t]*" $(1) | sed 's/^$(2)[ \t]*//g')
endef

define newtable
fields=($(1)) ; hostidx="0" ; while true; do echo ""; for i in $$(seq 0 $$[$${#fields[@]}-1]); do read -p "Enter $${fields[$$i]}: " thisfld; echo $$thisfld; done > $(2)/$$hostidx.txt; export hostidx="$$[$$hostidx+1]"; read -p "Continue (y/n) " -n1 -s again; [[ "$$again" == "n" || "$$again" == "N" ]] && break; done
endef

define getfield
awk 'function printline(num) { for(i=0; i < num-1; i++) { getline; } print; exit;} { printline($(1)) }'
endef

all: 
	@echo "Build options:"
	@echo "   1) make edit -> edit hosts.txt file"
	@echo "   2) make create -> create template"

edit:
	$(EDITOR) hosts.txt

create: build/web-content.xml


build/web-content.xml: tmp/all-httptests.xml tmp/all-triggers.xml build tmp/all-graphs.xml
	m4 -DHOSTGROUP="$(call getsetting,tmp/settings.txt,GROUP)" -DZBXHOST="$(call getsetting,tmp/settings.txt,HOST)" -DALLHTTPTESTS="$$(cat tmp/all-httptests.xml)" -DALLGRAPHS="$$(cat tmp/all-graphs.xml)" -DALLTRIGGERS="$$(cat tmp/all-triggers.xml)" host.xml.m4 > build/web-content.xml

tmp/all-httptests.xml: tmp/hosts/list tmp tmp/settings.txt
	for thisfile in $$(ls ./tmp/hosts/*); do m4 -DUNIQNAME="$$($(call getfield,1) < $$thisfile)" -DPROTO="$$($(call getfield,2) < $$thisfile)" -DSITECN="$$($(call getfield,3) < $$thisfile)" -DURI="$$($(call getfield,4) < $$thisfile | sed 's/&/&amp;/g')" -DSEARCHTXT="$$($(call getfield,6) < $$thisfile)" -DSTATCODE="$$($(call getfield,5) < $$thisfile)" httptest.xml.m4 ; done > tmp/all-httptests.xml

tmp/all-triggers.xml: tmp/hosts/list tmp tmp/settings.txt
	for thisfile in $$(ls ./tmp/hosts/*); do m4 -DUNIQNAME="$$($(call getfield,1) < $$thisfile)" -DSITECN="$$($(call getfield,3) < $$thisfile)" -DURI="$$($(call getfield,4) < $$thisfile | sed 's/&/&amp;/g')" trigger.xml.m4 ; done > tmp/all-triggers.xml

tmp/all-graphs.xml: tmp/hosts/list tmp/settings.txt
	for thisfile in $$(ls ./tmp/hosts/*); do m4 -DUNIQNAME="$$($(call getfield,1) < $$thisfile)" -DSITECN="$$($(call getfield,3) < $$thisfile)" -DURI="$$($(call getfield,4) < $$thisfile | sed 's/&/&amp;/g')" -DZBXHOST="$(call getsetting,tmp/settings.txt,HOST)" graph.xml.m4; done > tmp/all-graphs.xml

tmp/settings.txt: tmp
	$(call newsetting,Enter hostname in Zabbix,HOST,Web Content Checks,tmp/settings.txt)
	$(call newsetting,Enter Host Group name,GROUP,Hosts,tmp/settings.txt)

tmp/hosts/list: tmp/hosts
	awk 'BEGIN { fileno=0 } /^#/ { next; } /^[ \t]*$$/ { next; } { filepath = "tmp/hosts/" fileno ".txt" ; printf("%s\n%s\n%s\n%s\n%s\n%s",$$1,$$2,$$3,$$4,$$5,gensub(/^.* [1-9][0-9][0-9] /,"","g",$$0)) > filepath; fileno++; }' hosts.txt
	
tmp/hosts: tmp
	mkdir tmp/hosts
	
tmp:
	mkdir tmp

build:
	mkdir build

clean:
	rm -rf tmp
	rm -rf build

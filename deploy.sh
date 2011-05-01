#!/bin/sh
git submodule update --init && \
if [ ! -d .tup ] ; then tup init; fi && \
tup upd && \
ssh -t brad@braddunbar.net sudo stop braddunbar && \
rsync \
	-f "- *.scss" \
	-f "- static/css/compass" \
	-f "- Tupfile" \
	-f "- *.swp" \
	-f "- *.swo" \
	-f "- .gitignore" \
	--delete --delete-excluded \
	-Lavz -e ssh web/ brad@braddunbar.net:/var/sites/braddunbar && \
ssh -t brad@braddunbar.net sudo start braddunbar

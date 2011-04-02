#!/bin/sh
tup upd && \
rsync \
	-f "- *.scss" \
	-f "- static/css/compass" \
	-f "- Tupfile" \
	-f "- *.swp" \
	-f "- .gitignore" \
	--delete --delete-excluded \
	-Lavz -e ssh web/ brad@braddunbar.net:/var/sites/braddunbar

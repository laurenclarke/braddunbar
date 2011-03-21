#!/bin/sh
tup upd && \
rsync -f "- *.scss" -f "- Tupfile" -f "- *.swp" --delete --delete-excluded -avz -e ssh web/ brad@braddunbar.net:/var/sites/braddunbar

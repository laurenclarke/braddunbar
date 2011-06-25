#!/bin/sh -e

echo "module.exports ="

for f in $*
do
	printf "  '/$f': '/$f?%s'\n" "`git hash-object $f`"
done

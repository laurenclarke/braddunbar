#!/bin/sh

echo "module.exports = {"

for f in $*
do
	echo "\"/$f\": \"/$f?`git hash-object $f`\","
done

echo "};"

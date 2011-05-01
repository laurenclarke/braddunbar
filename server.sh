#!/bin/sh
git submodule update --init && \
if [ ! -d .tup ] ; then tup init; fi && \
tup upd && \
cd web && \
npm install && \
env REPO="../repo/.git" node-dev .

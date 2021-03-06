#!/bin/bash

GLADYS_TOP_FOLDER="/home/pi/gladys"
GLADYS_FOLDER="/home/pi/gladys/node_modules/gladys"
HOOK_FOLDER="$GLADYS_FOLDER/api/hooks"
CACHE_FOLDER="$GLADYS_FOLDER/cache"
TMP_HOOK_FOLDER="/tmp/gladys_hooks"
TMP_CACHE_FOLDER="/tmp/gladys_cache"

# Cleaning Gladys hook folder
rm -rf $TMP_HOOK_FOLDER

# Cleaning Gladys cache folder
rm -rf $TMP_CACHE_FOLDER

# Then, we create the temp hook folder
mkdir $TMP_HOOK_FOLDER

# Then, we create the temp hook folder
mkdir $TMP_CACHE_FOLDER

# We copy the hooks repository of the old folder
cp -ar /home/pi/gladys/node_modules/gladys/api/hooks/. $TMP_HOOK_FOLDER

# We copy the cache folder of the old gladys
cp -ar /home/pi/gladys/node_modules/gladys/cache/. $TMP_CACHE_FOLDER

# stopping gladys (silent is in case gladys is not running)
# silent remove any errors cause by PM2
pm2 stop --silent gladys

cd $GLADYS_TOP_FOLDER

npm update gladys

# we copy back the hook and cache folder
cp -ar /tmp/gladys_hooks/. $HOOK_FOLDER
cp -ar /tmp/gladys_cache/. $CACHE_FOLDER

# go to gladys folder
cd $GLADYS_FOLDER

# start init script
node init.js

#BuildProd 
grunt buildProd

# restart gladys
pm2 start gladys
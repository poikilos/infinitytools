#!/bin/bash
# This script overwrites the bucket_game versions of the textures,
# and adds/overwrites any README.md or changelog.md in
# BUCKET_GAME/mods/coderbuild/infinitytools as well.
# - This patch renames the files in this repo to the bucket_game naming
#   used by ipushbutton2653 in a temporary directory before patching.

if [ "@$BUCKET_GAME" = "@" ]; then
    BUCKET_GAME=$1
fi
if [ "@$BUCKET_GAME" = "@" ]; then
    echo "Error: provide a parameter that is the path to bucket_game"
    exit 1
fi

if [ ! -d "$BUCKET_GAME/mods" ]; then
    echo "$BUCKET_GAME has no mods directory so it doesn't appear to be a game."
    exit 1
fi

if [ ! -d "$BUCKET_GAME/mods/coderbuild/infinitytools" ]; then
    echo "$BUCKET_GAME has no mods/coderbuild/infinitytools directory so this patch won't work."
    exit 1
fi
_good_src_flag="./textures/infinitytools_compressed_mese.png"
if [ ! -f "$_good_src_flag" ]; then
    echo "Error: This script must be run in the poikilos/infinitytools repo directory (\"$_good_src_flag\" is not in the current directory \"`pwd`\")."
    exit 1
fi


TMP_MOD_DIR=/tmp/infinitytools
TMP_TEX_DIR=$TMP_MOD_DIR/textures
TMP_PRJ_DIR=$TMP_MOD_DIR/projects
mkdir -p "$TMP_TEX_DIR"
mkdir -p "$TMP_PRJ_DIR"
if [ $? -ne 0 ]; then exit; fi
#cp textures/* "$TMP_TEX_DIR/"
#if [ $? -ne 0 ]; then exit; fi
#cp projects/* "$TMP_TEX_DIR/"
#if [ $? -ne 0 ]; then exit; fi
rsync -rt ./ $TMP_MOD_DIR
if [ $? -ne 0 ]; then exit; fi
cd "$TMP_TEX_DIR"
if [ $? -ne 0 ]; then exit; fi
mv infinitytools_axe.png infinity_axe.png
if [ $? -ne 0 ]; then exit; fi
mv infinitytools_compressed_mese.png compressedmese.png
if [ $? -ne 0 ]; then exit; fi
mv infinitytools_infinity_block.png infinityblock.png
if [ $? -ne 0 ]; then exit; fi
mv infinitytools_pick.png infinity_pick.png
if [ $? -ne 0 ]; then exit; fi
mv infinitytools_shovel.png infinity_shovel.png
if [ $? -ne 0 ]; then exit; fi
mv infinitytools_sword.png infinity_sword.png
if [ $? -ne 0 ]; then exit; fi
# cd "$TMP_PRJ_DIR" # These are already named in the ipushbutton2653 style
rsync -t $TMP_TEX_DIR $BUCKET_GAME/mods/coderbuild/infinitytools
if [ $? -ne 0 ]; then exit; fi
rsync -t $TMP_PRJ_DIR $BUCKET_GAME/mods/coderbuild/infinitytools
if [ $? -ne 0 ]; then exit; fi
cp $TMP_MOD_DIR/README.md $BUCKET_GAME/mods/coderbuild/infinitytools/
if [ $? -ne 0 ]; then exit; fi
cp $TMP_MOD_DIR/changelog.md $BUCKET_GAME/mods/coderbuild/infinitytools/
if [ $? -ne 0 ]; then exit; fi
rm -Rf $TMP_MOD_DIR
if [ $? -ne 0 ]; then exit; fi
echo "Done patching $BUCKET_GAME/mods/coderbuild/infinitytools"

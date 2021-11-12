#!/bin/bash
if [ "@$BUCKET_GAME" = "@" ]; then
    BUCKET_GAME=$1
fi
if [ "@$BUCKET_GAME" = "@" ]; then
    echo "Error: provide a parameter that is the path to bucket_game"
    exit 1
fi

if [ ! -f "$BUCKET_GAME/mods" ]; then
    echo "$BUCKET_GAME has no mods directory and doesn't appear to be a mod."
    exit 1
fi

if [ ! -d "$BUCKET_GAME/mods/coderbuild/infinitytools" ]; then
    echo "$BUCKET_GAME has no mods/coderbuild/infinitytools directory so this patch won't work."
    exit 1
fi

TMP_MOD_DIR=/tmp/infinitytools
TMP_TEX_DIR=$TMP_MOD_DIR/textures
TMP_PRJ_DIR=$TMP_MOD_DIR/projects
mkdir -p "$TMP_TEX_DIR"
mkdir -p "$TMP_PRJ_DIR"
if [ $? -ne 0 ]; then exit; fi
cp textures/* "$TMP_TEX_DIR/"
if [ $? -ne 0 ]; then exit; fi
cp projects/* "$TMP_TEX_DIR/"
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
rm -Rf $TMP_MOD_DIR
if [ $? -ne 0 ]; then exit; fi

#!/bin/bash
TMP_MOD_DIR=/tmp/infinitytools
TMP_TEX_DIR=$TMP_MOD_DIR/textures
mkdir -p "$TMP_MOD_DIR"
if [ $? -ne 0 ]; then exit; fi
cp textures/* "$TMP_MOD_DIR/"
if [ $? -ne 0 ]; then exit; fi
cd "$TMP_MOD_DIR"
if [ $? -ne 0 ]; then exit; fi
mv infinitytools_axe.png infinity_axe.png
mv infinitytools_compressed_mese.png compressedmese.png
mv infinitytools_infinity_block.png infinityblock.png
mv infinitytools_pick.png infinity_pick.png
mv infinitytools_shovel.png infinity_shovel.png
mv infinitytools_sword.png infinity_sword.png
cat <<END
Now you can do something like:
# Set BUCKET_GAME then:
rsync -t $TMP_TEX_DIR/ $BUCKET_GAME/mods/coderbuild/infinitytools/textures
rm -Rf $TMP_MOD_DIR
END

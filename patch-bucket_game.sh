#!/bin/bash

. repo_naming.rc
# ^ Variables in src_naming.rc represent the source filenames and should
#   only change if the poikilos repo naming changes.


#region destination filenames
_compressed_mese="compressedmese.png"
_infinity_block="infinityblock.png"
_infinity_readme="README.md"
_infinity_changelog="changelog.md"
# ^ These 4 are changed later if bucket_game 211111a detected; if the
#   script still fails, change these, and the others below if they fail.
_infinity_pick="infinity_pick.png"
_infinity_shovel="infinity_shovel.png"
_infinity_sword="infinity_sword.png"
_infinity_axe="infinity_axe.png"
#endregion destination filenames


_dest_mod_relative_subdir="mods/coderbuild/infinitytools"


if [ $? -ne 0 ]; then
    echo "Error: src_naming.rc is missing."
    echo "You must run this from the poikilos/infinitytools repo."
    exit 1
fi
if [ -z "$_src_infinity_axe" ]; then
    echo "_src_infinity_axe is not set."
    exit 1
fi
if [ -z "$_src_compressed_mese" ]; then
    echo "_src_compressed_mese is not set."
    exit 1
fi
if [ -z "$_src_infinity_block" ]; then
    echo "_src_infinity_block is not set."
    exit 1
fi
if [ -z "$_src_infinity_pick" ]; then
    echo "_src_infinity_pick is not set."
    exit 1
fi
if [ -z "$_src_infinity_shovel" ]; then
    echo "_src_infinity_shovel is not set."
    exit 1
fi
if [ -z "$_src_infinity_sword" ]; then
    echo "_src_infinity_sword is not set."
    exit 1
fi

for sfn in $_src_infinity_axe $_src_compressed_mese $_src_infinity_block $_src_infinity_pick $_src_infinity_shovel $_src_infinity_sword
do
    if [ ! -f "textures/$sfn" ]; then
        echo "Error: textures/$sfn is not a file. reponaming.rc is not correct."
        exit 1
    fi
done

cat <<END
This script overwrites the bucket_game versions of the textures,
and adds/overwrites any $_infinity_readme or $_infinity_changelog in
BUCKET_GAME/mods/coderbuild/infinitytools as well (the documentation
filenames will be prepended with "infinitytools-" if the infinitytools
are defined in coderblocks).

This patch renames the files in this repo to the bucket_game naming
in a temporary directory before patching.
- If coderbuild/infinitytools is a directory, the ipushbutton2653
  texture naming is used.
- If coderbuild/coderblocks/infinitytools.lua is detected, the
  bucket_game 211111a texture naming is used.
- The naming scheme is verified to exist on the destination
  before patching will continue.
END


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


printf "* verifying naming of infinity tools textures..."
name_change=""
if [ ! -d "$BUCKET_GAME/$_dest_mod_relative_subdir" ]; then
    if [ -f "$BUCKET_GAME/mods/coderbuild/coderblocks/infinitytools.lua" ]; then
        printf "trying 211111a naming..."
        _compressed_mese="infinity_compressedmese.png"
        _infinity_block="infinity_block.png"
        _dest_mod_relative_subdir="mods/coderbuild/coderblocks/textures"
        _infinity_readme="infinitytools-README.md"
        _infinity_changelog="infinitytools-changelog.md"
        # ^ These are the new bucket_game 211111a filenames
        #   (any version where coderblocks rather than the infinitytools
        #   mod defines the nodes as indicated by the lua file detected
        #   in the nested case above.
        name_change="211111a"
    else
        echo "$BUCKET_GAME has no mods/coderbuild/infinitytools directory nor $BUCKET_GAME/mods/coderbuild/coderblocks/infinitytools.lua so this patch won't work."
        exit 1
    fi
fi

for fn in $_compressed_mese $_infinity_shovel $_infinity_pick infinity_axe.png $infinityblock $_infinity_sword
do
    tryName="$BUCKET_GAME/$_dest_mod_relative_subdir/$fn"
    if [ ! -f "$tryName" ]; then
        echo "Error: There is no \"$tryName\", so the texture naming convention is unrecognized (Scripted patching is not implemented for your version of bucket_game)."
        exit 1
    fi
done

echo "OK"

if [ ! -z "$name_change" ]; then
    echo "* changed to new bucket_game $name_change naming:"
    echo "  - _compressed_mese=$_compressed_mese"
    echo "  - _infinity_block=$_infinity_block"
    echo "  - _dest_mod_relative_subdir=$_dest_mod_relative_subdir"
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
mv $_src_infinity_axe $_infinity_axe
if [ $? -ne 0 ]; then exit; fi
mv $_src_compressed_mese $_compressed_mese
if [ $? -ne 0 ]; then exit; fi
mv $_src_infinity_block $_infinity_block
if [ $? -ne 0 ]; then exit; fi
mv $_src_infinity_pick $_infinity_pick
if [ $? -ne 0 ]; then exit; fi
mv $_src_infinity_shovel $_infinity_shovel
if [ $? -ne 0 ]; then exit; fi
mv $_src_infinity_sword $_infinity_sword
if [ $? -ne 0 ]; then exit; fi
# cd "$TMP_PRJ_DIR" # These are already named in the ipushbutton2653 style
printf "* updating textures..."
rsync -t $TMP_TEX_DIR $BUCKET_GAME/$_dest_mod_relative_subdir
if [ $? -ne 0 ]; then exit; fi
echo "OK"
printf "* updating projects..."
rsync -t $TMP_PRJ_DIR $BUCKET_GAME/$_dest_mod_relative_subdir
if [ $? -ne 0 ]; then exit; fi
echo "OK"
if [ -f "$BUCKET_GAME/$_dest_mod_relative_subdir/$_infinity_readme" ]; then
    printf "* overwriting $_infinity_readme..."
else
    printf "* adding $_infinity_readme..."
fi
cp $TMP_MOD_DIR/README.md $BUCKET_GAME/$_dest_mod_relative_subdir/$_infinity_readme
if [ $? -ne 0 ]; then exit; fi
echo "OK"
if [ -f "$BUCKET_GAME/$_dest_mod_relative_subdir/$_infinity_changelog" ]; then
    printf "* overwriting $_infinity_changelog..."
else
    printf "* adding $_infinity_changelog..."
fi
cp "$TMP_MOD_DIR/changelog.md" "$BUCKET_GAME/$_dest_mod_relative_subdir/$_infinity_changelog"
if [ $? -ne 0 ]; then exit; fi
echo "OK"
printf "* removing $TMP_MOD_DIR..."
rm -Rf $TMP_MOD_DIR
if [ $? -ne 0 ]; then exit; fi
echo "OK"
echo
echo "Done patching $BUCKET_GAME/$_dest_mod_relative_subdir"
echo

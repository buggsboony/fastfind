#!/bin/bash

#install stuff
what=fastfind
extension=.sh
#peut être extension vide

echo "Rendre exécutable..."
chmod +x $what$extension
echo "lien symbolique vers usr bin"
sudo ln -s "$PWD/$what$extension" /usr/bin/$what


#!/bin/bash

# ===================================================================================================
# REQUIREMENT : first you must go to the same folder as your .ins and .dtx files
# USE         :  ./package.sh
# TASK        : Create a .sty file, create a folder in the correct place, copy the file in it, and upload the database
# ===================================================================================================


read -p 'Your file name (without extension) : ' filename
fileins=$filename".ins"
filedtx=$filename".dtx"
filesty=$filename".sty"

if [ ! -e $filesty ]
then
  while [ ! -e $fileins ] || [ ! -e $filedtx ]
  do
    read -p 'Files not found. Give another file name : ' filename
    fileins=$filename".ins"
    filedtx=$filename".dtx"
  done
  echo "$fileins and $filedtx has been found"

  tex $fileins
  filesty=$filename".sty"
  echo "$filesty has been created"
fi

cd /usr/share/texlive/texmf-dist/tex/latex
if [ -e $filename ]
then
  echo "Package $filename is probably already installed"
  exit
fi

sudo mkdir $filename
sudo cp $filesty /usr/share/texlive/texmf-dist/tex/latex/$filename
sudo mktexlsr /usr/share/texlive/texmf-dist/tex/latex
echo "Package $filename successfully installed"

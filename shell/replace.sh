#!/bin/bash

## ファイルの一部を置換する

echo "## ファイルを検索するし、変数に格納する";

DirPath="${PWD}/../TestFolder"
FileName="find_file.sh"

# 検索したファイルパス
echo "find ${DirPath} -name ${FileName}"
findFilePath=`find ${DirPath} -name ${FileName}`

if [ -e $findFilePath ]; then
    echo "ファイルが存在する"
else
    echo "ファイルが存在しない"
    exit 1;
fi

echo $findFilePath

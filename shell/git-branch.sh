#!/bin/bash

readonly LineSeq='================================================================'

# 検索する深さ
depth=0 # TODO : まだ使えない
# Repositoryを表示するか
isRepository=true

dirPath=$(cd $(dirname $0); pwd)

# Directory指定
if [ $# -eq 1 ]; then
    if [ -d $1 ]; then
        dirPath=$1
    else
        echo "Not Find Directory: $1"
        exit 1
    fi
fi

dirPath=$(cd $dirPath; pwd)

echo ${LineSeq}
echo
echo "DirectoryPath: ${dirPath}"
# Depthが指定されていれば表示を行う
if [ ${depth} -gt 0 ]; then
    # echo "Depth: ${depth}"
fi
echo 

for _dir in `ls ${dirPath}`; do
    dir="${dirPath}/${_dir}"
    # ディレクトリの場合
    if [ -d ${dir} ]; then
        branchName=`git -C ${dir} branch 2>/dev/null | grep '*' | tr '^*' ' ' | xargs`
        repositoryName=`git -C ${dir} remote -v 2>/dev/null | tail -n 1 | sed -e 's/^origin.*://' | sed -e 's/\.git.*//' | xargs`

        if [ ${branchName} ]; then
            echo "\033[0;36m${dir}\033[0;39m"
            echo "\033[0;32m- Branch: ${branchName}\033[0;39m"

            if ${isRepository} ; then
                echo "\033[0;32m- Repository: ${repositoryName}\033[0;39m"
            fi
        fi
    fi
done

echo ${LineSeq}

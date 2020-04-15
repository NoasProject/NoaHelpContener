#!/bin/bash

readonly LineSeq='================================================================'

## Vertial
depth=0 # 検索する深さ
isRepository=true # Repositoryを表示するか
dirPath=$(cd $(dirname $0); pwd)

# Depth指定
if [ $# -ge 1 ]; then
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        depth=$1
    else
        echo "Not Numeric Plase Depth Input Numeric.: $1"
        exit 1
    fi
fi

# Directory指定
if [ $# -ge 2 ]; then
    if [ -d $2 ]; then
        dirPath=$2
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
    echo "Depth: ${depth}"
fi
echo 

dirPathAry=(${dirPath})
idx=0
for dep in `seq 0 $((depth))`; do
    # 配列の最後を取得する
    _max=${#dirPathAry[@]}
    # LoopさせてDirectoryを取得する
    for ((i=${idx}; i<$_max; i++)); do
        # 一時的なDirectoryを作成
        _dirDepth=${dirPathAry[i]}
        for _dir in `ls ${_dirDepth}`; do
            if [ -d "${_dirDepth}/${_dir}" ]; then
                dirPathAry+=("${_dirDepth}/${_dir}")
            fi
        done
        let idx++
    done
done

for dir in ${dirPathAry[@]}; do
    
    # ディレクトリではない場合
    if [ ! -d ${dir} ]; then
        continue;
    fi

    # .gitが存在しない場合
    if [ ! -d "${dir}/.git" ]; then
        continue;
    fi

    branchName=`git -C ${dir} branch 2>/dev/null | grep '*' | tr '^*' ' ' | xargs`
    repositoryName=`git -C ${dir} remote -v 2>/dev/null | tail -n 1 | sed -e 's/^origin.*://' | sed -e 's/\.git.*//' | xargs`

    if [ ${branchName} ]; then
        echo "\033[0;36m${dir}\033[0;39m"
        echo "\033[0;32m- Branch: ${branchName}\033[0;39m"

        if ${isRepository} ; then
            echo "\033[0;32m- Repository: ${repositoryName}\033[0;39m"
        fi
    fi
done

echo ${LineSeq}

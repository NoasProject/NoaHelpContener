#!/bin/bash

## Function -->

SeparateLine() {
    str="#"
    count=100
    echo "`printf %${count}s | sed "s/ /${str}/g"`"
}

## <--

## Constant
readonly installGnuSed=true
readonly installGit=true
readonly installGitLFS=true
readonly installMono=true
readonly installNodeBrew=true
readonly installUnRar=true
readonly installTig=true

# OS Version Check
OS_CATALINA=101500    # macOS Catalina
OS_BIGSUR=110000      # macOS Big Sur
OS_SONOMA=140201      # maxOS Sonama
OS_VERSION=$(sw_vers -productVersion | (IFS=. read -r major minor micro; printf "%2d%02d%02d" ${major:-0} ${minor:-0} ${micro:-0}) | sed -e 's/[^0-9]//g')

echo `SeparateLine`

echo "OsVersion: `sw_vers -productVersion` - ${OS_VERSION}"

# Path
BashProfilePath="~/.bash_profile"
BashrcPath="~/.bashrc"

# OSX Catalina
if [ ${OS_VERSION} -ge ${OS_BIGSUR} ]; then
    echo 'Mac OS Big Sur'
    BashProfilePath="~/.zprofile"
    BashrcPath="~/.zshrc"
elif [ ${OS_VERSION} -ge ${OS_CATALINA} ]; then
    echo 'OSX Catalina'
    BashProfilePath="~/.zprofile"
    BashrcPath="~/.zshrc"
else
    echo 'OSX Mojave'
fi

# Validate File
# if [ ! -e $BashProfilePath ]; then
#     echo "Not find bash_profile path. : ${BashProfilePath}"
#     exit 1
# fi

# if [ ! -e ${BashrcPath} ]; then
#     echo "Not find bashrc path. : ${BashrcPath}"
#     exit 1
# fi

# User Name
# if [ ${OS_Version} -ge ${OS_Catalina} ]; then
    # echo "# User Name Viewer" >> ${BashrcPath}
    # echo 'export PS1="%n@%m%f %1~%f \$ "' >> ${BashrcPath}
# fi

# brew install
BREW_VERSION="$(brew -v | grep 'command not found')"
if [ ${BREW_VERSION} ]; then
    `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
    echo "SetUp --> brew"
else
    echo 'installed brew'
fi

# tig
if "${installTig}"; then
    result="$(tig --version)"
    if [ $? -ne 0 ]; then

        echo 'tig not find install !!!'

        brew install tig

    else
        echo 'Installed tig'
    fi
fi

# gnu-sed
if "${installGnuSed}"; then
    result="$(sed --version | grep 'sed \(GNU sed\)')"
    if [ $? -ne 0 ]; then

        echo 'gnu-sed not find install !!!'
        brew install gnu-sed

    else
        echo 'installed gnu-sed'
    fi
    echo "grep \'/usr/local/opt/gnu-sed/libexec/gnubin\' ${BashrcPath}"
    isGnuSedProfile=`grep '/usr/local/opt/gnu-sed/libexec/gnubin' ${BashrcPath}`
    if [ ${isGnuSedProfile} ]; then
        echo '# gnu-sed' >> ${BashrcPath}
        echo 'PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"' >> ${BashrcPath}
        source ${BashrcPath}
    else
        echo "Added gnu-sed PATH. ${BashrcPath}"
    fi
fi

# git
if "${installGit}"; then
    if [ `git --version | grep 'command not found'` ]; then

        brew install git

        echo "SetUp --> git"
    else
        echo 'installed git'
    fi
fi

# git-lfs
if "${installGitLFS}"; then
    if [ `git-lfs --version | grep 'command not found'` ]; then

        brew install git-lfs

        echo "SetUp --> git-lfs"
    else
        echo 'installed git-lfs'
    fi
fi

# mono
if "${installMono}"; then
    if [ `mono --version | grep 'command not found'` ]; then

        brew install mono

        echo "SetUp --> mono"
    else
        echo 'installed mono'
    fi
fi

# nodebrew
if "${installNodeBrew}"; then
    if [ `nodebrew --version | grep 'command not found'` ]; then

        brew install nodebrew
        nodebrew setup
        
        echo "Install --> nodebrew"
    else
        echo 'Installed nodebrew'
    fi

    isExportNodeBrew=`grep '/usr/local/var/nodebrew/current/bin' '/.nodebrew/current/bin' ${BashProfilePath}`
    if [ ${isExportNodeBrew} ]; then
        echo '# nodebrew' >> ${BashProfilePath}
        echo 'export PATH=/usr/local/var/nodebrew/current/bin:$PATH' >> ${BashProfilePath}
        echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ${BashProfilePath}
        source ${BashProfilePath}
    else
        echo "Added nodebrew PATH. ${BashProfilePath}"
    fi
fi

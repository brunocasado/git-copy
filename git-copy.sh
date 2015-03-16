#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This script have the following propose:
# Create structure files to make a easily deploy ( in fuck ftp )
# Author Bruno Casado <bruno.casado@ibrasil.info>

TARGET=$3

TARGET=""
COMMIT=()

#Set fonts for Help.
NORM=`tput sgr0`
BOLD=`tput bold`
REV=`tput smso`

#Help function
function HELP {
  echo -e \\n"Help documentation for ${BOLD}$0 ${NORM}"\\n
  echo -e "${BOLD}this script have to stay in git project folder"\\n
  echo -e "${REV}Basic usage:${NORM} ${BOLD}$0 -t TARGET GIT_COMMIT ... [commit]${NORM}"\\n
  
  echo -e "${REV}-h${NORM}  --Displays this help message."\\n
  echo -e "Mandatory" \\n
  echo -e "${REV}-t${NORM}  --Target Path to create folders. "\\n
  echo "./git-copy.sh  -t ~/projects/TEST_TAG/edicaonatura/ 6a5893a2be70f41301876eb60dacb4191d50524e 8fce41d1dae330dfa2b4b38e5e78305db7cc13ef"\\n
  exit 1
}

if [ ! $# ]; then
  HELP
fi
    
while getopts ":t:" OPT; do
  case $OPT in
    t)        
        TARGET=${OPTARG}
      ;;
  esac
done

shift $((OPTIND-1))
for i
do        
    COMMIT+="$i "
done

FILES=()

echo $PATH
for i in $COMMIT
do
    FILES+=($(git diff-tree --name-only --no-commit-id -r $i))
done

for i in ${FILES[@]}
do
    echo "Copying file $i to $TARGET/$i"
    mkdir -p "$TARGET/$(dirname $i)"
    cp "$i" "$TARGET/$i"
done

echo "Done"
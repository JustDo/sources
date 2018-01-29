#!/bin/bash
#author http://blog.csdn.net/hursing

# this variable should be complex enough to avoid naming pollution
shortcut_and_paths=(
  'd ~/Desktop'
  's ~/Downloads/subversion-1.7.17'
  '7 ~/Downloads/gmock-1.7.0'
  'crm ~/Documents/amily_h5/CRM/'
  'wk /home/liuhx/Desktop/WebKit/Source/WTF/icu'
)

for ((i = 0; i < ${#shortcut_and_paths[@]}; i++)); do
  cmd=${shortcut_and_paths[$i]}
  shortcut=${cmd%% *}
  path=${cmd#* }
  func="g2$shortcut() { cd $path; }"
  eval $func
done

g2help() {
  for ((i = 0; i < ${#shortcut_and_paths[@]}; i++)); do
    cmd=${shortcut_and_paths[$i]}
    shortcut=${cmd%% *}
    path=${cmd#* }
    echo -e "g2$shortcut\t=>\tcd $path"
  done
  echo -e "\033[0;33;1mexample: input 'g2${shortcut_and_paths[0]%% *}' to run 'cd ${shortcut_and_paths[0]#* }'\033[0m"
}

#!/bin/bash
DE=$(xdotool get_desktop)
allterms=($(xdotool search --desktop $DE --onlyvisible --class "gnome-terminal"))
num=${#allterms[*]}
echo ${allterms[*]}
declare -a terms
for ter in ${allterms[@]}
do
  echo $ter
  desk=$(xdotool get_desktop_for_window $ter)
  if [ $DE == $desk ]; then
    terms+=($ter)
  fi
done
echo terms
echo ${terms[*]}

declare -a pids
for j in $( eval echo {0..$(( $num - 1 ))} ); do
  pids[$j]=$(xdotool getwindowpid ${terms[$j]})
done
echo piddssss
echo "${pids[*]}"
echo termss
for ix in ${!terms[*]}
do
    printf "   %s\n" "${terms[$ix]}"
done


fun() {
  #find if terminal not runing anything
  termcount=$(dir /dev/pts/ | wc -w)
  termcount=$(expr $termcount - 1)
  for i in $( eval echo {0..$termcount} )
  do
    #str=$(ps -t $i -hj)
    wcl=$(ps  -t $i -a | grep pts/$i | wc -l)
    str=$(ps -t $i -a | grep pts/$i | grep bash)
    if [[ -z $str ]]; then
      continue;
    fi
    #is free
    if [ $wcl == 1 ]; then
      echo "i:${i} wcl: ${wcl}"
      # is on current workspace
      ppid=$(ps -t $i -h -o ppid,comm | grep bash | head -n1 | sed -e 's/\s.*$//')
      echo "ppid: ${ppid}"
      for t in "${pids[@]}"
      do
        echo ${pids[$t]}
        if [ "$t" == "$ppid" ] ; then
          for k in $( eval echo {0..$(( $num - 1 ))} ); do
            if [ "${pids[$k]}" == "$ppid" ]; then
#              windesktop=$(xdotool get_desktop_for_window ${terms[$k]})
              # echo $DE
              # echo $windesktop
              # if [ $DE == $windesktop ]; then
                xdotool windowactivate --sync ${terms[$k]}
                exit 0
              # fi
            fi
          done
        fi
      done
    fi
  done
  #if there is no free terminals
  gnome-terminal --disable-factory --working-directory=~ &
  exit 0
}

fun

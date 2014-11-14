#!/bin/bash
# TODO: add recursive copy

control_c()
{
  if [[ $(jobs | wc -l) > 0 ]]; then
      kill %%
  fi
  exit $?
}

bytes()
{
    du -sb $@ | awk '{print $1}'
}

cummulative_bytes()
{
    bytes $1 | awk '{print $1 " +"}' | xargs | sed 's/+$//g' | xargs expr
}

trap control_c SIGINT

argc=$(($#-1))
src=${@:1:$argc}
dest="${!#}"
bytes_transferred=0
total_bytes=$(cummulative_bytes)

for src_file in $src
do
    # ensure source exists
    if [ ! -e $src_file ]; then
        echo "File or directory $src_file does not exist." 1>&2
        continue
    fi
        
    # was an explicit destination filename listed or do we copy to a directory?
    if [ -d $dest ]; then
        dest_file="$dest/$(basename $src_file)"
    else
        dest_file=$dest
    fi

    # get the size of the source file, init the size of the destination file to zero
    src_size=$(bytes $src_file)
    dest_size=0

    # start the copy job for the current file in the background
    # use full path to avoid aliases and other scripts with the same name
    /bin/cp $src_file $dest_file &

    # wait for copying to begin
    while [ ! -e $dest_file ]
    do
        sleep .1
    done

    # update progress until all bytes are copied
    echo -n "         " $(basename $src_file)
    while [ $dest_size -lt $src_size ]
    do
        dest_size=$(cummulative_bytes $dest_file)
        let temp_size=dest_size+bytes_transferred
        echo -ne "\r         \r$(expr 100 \* $temp_size / $total_bytes)%"
        echo -ne " $(expr 100 \* $dest_size / $src_size)%"
        sleep .1
    done

    # wait for the copy job to exit
    wait

    # one last time, get the destination file and total sizes
    dest_size=$(cummulative_bytes $dest_file)
    let temp_size=dest_size+bytes_transferred
    echo -ne "\r         \r$(expr 100 \* $temp_size / $total_bytes)%"
    echo -ne " $(expr 100 \* $dest_size / $src_size)%"

    # start a new output line
    echo

    # update the total bytes transferred
    let bytes_transferred+=dest_size
done

# cleanup on exit
if [[ $(jobs | wc -l) > 0 ]]; then
  kill %%
fi
exit $?

complete -c portcheck -x -a '(lsof -n -i4TCP | grep LISTEN | awk '\''{split($9,a,":"); if(a[2]!="") print a[2]}'\'' | sort -u)'

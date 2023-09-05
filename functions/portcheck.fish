function portcheck -d "Check the processes listening on the specified port and display some info about them."
    set port $argv[1]
    set pids (lsof -n -i4TCP:$port | grep LISTEN | awk '{print $2}' | sort -u | tr '\n' ',')
    set pid_list (string trim -c ',' -- $pids)
    
    if test -z "$pid_list"
        echo "No processes found listening on port $port" >&2
        return 1
    else
        ps -p $pid_list -o pid,comm
    end
end

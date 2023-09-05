function cdp
    # Navigates upwards from the current directory in the directory tree 
    # until it finds a directory containing a .git subdirectory. Once 
    # found, it changes the current working directory to that directory.
    # If no such directory is found up until the root, it outputs an
    # error message.
    
    set current_dir (pwd)
    while test (basename $current_dir) != "/"
        if test -d "$current_dir/.git"
            cd $current_dir
            return 0
        end
        set current_dir (dirname $current_dir)
    end
    echo "No .git directory found."
    return 1
end

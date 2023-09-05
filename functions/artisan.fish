function artisan -d "Executes the project's 'artisan' file from the current or nearest parent directory."
    # Start with the current directory.
    set current_dir (pwd)

    while true
        # If 'artisan' file is found in the current directory.
        if test -f "$current_dir/artisan"
            # Execute the file with the given arguments.
            php "$current_dir/artisan" $argv
            return
        end

        # If already at the root directory, break out of the loop.
        if test "$current_dir" = "/"
            echo "artisan file not found."
            return 1
        end

        # Move up to the parent directory.
        set current_dir (dirname $current_dir)
    end
end


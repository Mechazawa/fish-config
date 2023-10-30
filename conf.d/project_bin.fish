# Used for adding vendor/bin and node_modules/.bin to my path when in a project (sub)directory

function find_nearest
    set -l dir (pwd)
    set -l target $argv[1]
    while test "$dir" != "/"
        set -l candidate "$dir/$target"
        if test -d "$candidate"
            echo "$candidate"
            return 0
        end
        set dir (dirname "$dir")
    end
    return 1
end

function update_project_bin_path # --on-event fish_prompt
    # Initialize default_path if not set
    set temp_path ""

    for i in $PATH
        if not string match -q -- "*vendor/bin" "$i"
            if not string match -q -- "*node_modules/.bin" "$i"
                set temp_path "$temp_path $i"
            end
        end
    end

    set -l nearest_vendor_bin (find_nearest "vendor/bin")
    set -l nearest_node_bin (find_nearest "node_modules/.bin")
    
    if test -n "$nearest_vendor_bin"
        set temp_path $nearest_vendor_bin $temp_path
    end

    if test -n "$nearest_node_bin"
        set temp_path $nearest_node_bin $temp_path
    end

    set -gx PATH $temp_path
end

function __fish_complete_fish_remove_path
    for uri in $PATH
        echo $uri
    end
end

complete -c fish_remove_path -a '(__fish_complete_remove_path)'

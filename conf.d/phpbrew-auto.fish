function phpbrew-auto --on-variable PWD
    if not type -q phpbrew
        return 0
    end

    if test ! -f composer.json
        return 0
    end 

    set php_version (jq -r '.require.php' composer.json)

    if test -z "$php_version"
        return 0
    end

    set php_version_simple (echo $php_version | grep -wo -E '[0-9].*')

    set installed_versions (phpbrew list | string match -r '\b([0-9]+\.[0-9]+\.[0-9]+)' | grep -v php-)

    set target_version (echo $installed_versions | grep -wo -E "$php_version_simple"'[^ ]*')
    set target_version (echo $target_version | cut -d' ' -f 1)

    if test -z "$target_version"
        return 0
    end

    set current_version (phpbrew use | grep -wo -E '[0-9].+')

    if test "$target_version" = "$current_version"
        return 0
    end 

    echo "Switching to PHP version $target_version"

    phpbrew use $target_version
end

function phpbrew-auto --on-variable PWD
    if test ! -f composer.json
        return 0
    end 

    set php_semver (jq -r '.require.php' composer.json)

    if test -z "$php_semver"
        return 0
    end

    set installed_versions (phpbrew list | grep -woE '[0-9.]+')

    set target_version (semver -r "$php_semver" $installed_versions | head -n 1)

    if test -z "$target_version"
        return 0
    end

    set current_version (phpbrew use | grep -woE '[0-9.]+')

    if test "$target_version" = "$current_version"
        return 0
    end 

    echo "Switching to PHP version $target_version"

    phpbrew use $target_version
end

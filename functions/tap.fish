function tap -d "Output stdin to stdout and optionally to a file instead of stderr"
    set -l outfile $argv[1]

    if test -n "$outfile"
        tee $outfile
    else
        tee /dev/stderr
    end
end

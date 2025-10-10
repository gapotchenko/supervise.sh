set windows-shell := ["gnu-tk", "-i", "-c"]
set script-interpreter := ["gnu-tk", "-i", "-l", "sh", "-eu"]
set unstable := true

@help:
    just --list

# Format source code
[group("development")]
[script]
format:
    echo 'Formatting **/*.sh...'
    find . -type d -name '.?*' -prune -o -type f -name '*.sh' -exec shfmt -i 4 -l -w "{}" \;
    echo 'Formatting **/justfile...'
    find . -type d -name '.?*' -prune -o -type f -name justfile -exec just --unstable --fmt --justfile "{}" \;
    echo 'Formatting *.md...'
    deno fmt *.md

# Check source code
[group("development")]
[script]
check:
    echo 'Checking **/*.sh...'
    find . -type d -name '.?*' -prune -o -type f -name '*.sh' -exec shellcheck "{}" \;

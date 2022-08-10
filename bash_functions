function exrcs() {
    IFS='/' read -ra path <<< "$@"
    cd "$(exercism download --track="${path[0]}" --exercise="${path[1]}" 2>&1 | tail --lines=1)" || return
}

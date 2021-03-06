#!/bin/bash
# httpd.bash: simple HTTP server written in bash script
# usage:
#   ./httpd.bash [port]
#   (port is default to 3000)
# requires:
#   bash, nc (netcat), file, wc, cat
# warning:
#   This isn't secure. Don't export to internet.

readonly CRLF=$'\r\n'
readonly SERVERNAME='httpd.bash/0.01'

function content_type() {
    local file=$1
    local mtype=$(file -b --mime "$file")
    [[ $mtype != *\;* ]] && mtype=${mtype/ /\; } # for file < 5.0
    [[ $mtype != unknown ]] && echo -n "Content-Type: $mtype$CRLF"
}

function content_length() {
    local file=$1
    echo -n "Content-Length: $(wc -c "$file")$CRLF"
}

function ok_200() {
    local file=$1
    echo -n "HTTP/1.0 200 OK$CRLF"
    echo -n "Server: $SERVERNAME$CRLF"
    content_type "$file"
    content_length "$file"
    echo -n "$CRLF"
    cat "$file"
}

function not_implemented_501() {
    echo -n "HTTP/1.0 501 Not Implemented$CRLF"
    echo -n "Server: $SERVERNAME$CRLF"
    echo -n "$CRLF"
    echo "501 Not Implemented"
}

function not_found_404() {
    echo -n "HTTP/1.0 404 Not Found$CRLF"
    echo -n "Server: $SERVERNAME$CRLF"
    echo -n "$CRLF"
    echo "404 Not Found"
}

function dispatch() {
    local method=$1 path=$2
    if [[ $method == GET ]]; then
        [[ $path == /* ]] && path=".$path"
        path=${path#../}
        path=${path//\/..\//}
        [ -d "$path" ] && path="$path/index.html"
        if [ -f "$path" ]; then
            ok_200 "$path"
        else
            not_found_404
        fi
    else
        not_implemented_501
    fi
}

function run() {
    local method path ver
    read method path ver
    path=${path%$'\r'}
    dispatch "$method" "$path"
}

export -f content_type content_length ok_200 not_implemented_501 \
  not_found_404 dispatch run
export CRLF SERVERNAME

trap 'echo shutdown.; exit' INT
echo 'Ctrl-C to shutdown server'
while :; do
    nc -l -p ${1:-3000} -c 'bash -c run'
done

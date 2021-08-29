#!/usr/bin/env bash

build_template() {
    export CGO_ENABLED=0
    export GOOS=$1
    export GOARCH=$2
    export GOARM=7
    ext=$3
    date=$(date +'%Y.%m.%d')
    version=${CIRCLE_BUILD_NUM-$date}
    tag=v$version-$(git log --format=%h -1)
    echo $tag-$GOOS-$GOARCH
    go build -ldflags="-X main.Version=$tag" -o ./bin/goia-$tag-$GOOS-$GOARCH$ext
}

# go tool dist list

build_template darwin amd64
build_template darwin arm64
build_template dragonfly amd64
build_template freebsd amd64
build_template freebsd arm64
build_template illumos amd64
build_template linux amd64
build_template linux arm64
build_template linux riscv64
build_template netbsd amd64
build_template netbsd arm64
build_template openbsd amd64
build_template openbsd arm64
build_template solaris amd64
build_template windows amd64 .exe
build_template windows arm .exe

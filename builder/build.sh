#!/bin/bash

echo "create gopath"
mkdir /tmp/go
export GOPATH=/tmp/go

echo "Build arduino-builder"

echo "[get] github.com/go-errors/error"
go get -v github.com/go-errors/errors

echo "[get] github.com/stretchr/testify"
go get -v github.com/stretchr/testify

echo "[get] github.com/jstemmer/go-junit-report"
go get -v github.com/jstemmer/go-junit-report

echo "[get] github.com/arduino/go-properties-map"
go get -v -u github.com/arduino/go-properties-map

echo "[get] github.com/arduino/go-timeutils"
go get -v -u github.com/arduino/go-timeutils

go get -v google.golang.org/grpc
echo "[get] google.golang.org/grpc"

echo "[get] github.com/golang/protobuf/proto"
go get -v github.com/golang/protobuf/proto

echo "[get] golang.org/x/net/context"
go get -v golang.org/x/net/context

echo "[get] github.com/fsnotify/fsnotify"
go get -v github.com/fsnotify/fsnotify

echo "[get] github.com/arduino/arduino-builder"
go get -v github.com/arduino/arduino-builder

echo "[build] github.com/arduino/arduino-builder/arduino-builder"
go build github.com/arduino/arduino-builder/arduino-builder

echo "clear gopath"
export GOPATH=$HOME/go
rm -rf /tmp/go


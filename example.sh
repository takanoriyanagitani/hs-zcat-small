#!/bin/sh

echo helo |
    gzip --fast |
    head --bytes=1048576 |
    ./hs-zcat-small

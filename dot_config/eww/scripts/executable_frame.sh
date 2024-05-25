#!/usr/bin/env bash

function get {
    echo "background-image: url('assets/toothless/output_${FRAME}.png')"
}

if [[ $1 == 'get' ]]; then get; fi

#!/usr/bin/env bash

sed -i 's/# default = \["sqlite"\]/default = ["postgresql"]/' ./Cargo.toml

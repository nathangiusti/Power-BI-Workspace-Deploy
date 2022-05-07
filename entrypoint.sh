#!/bin/sh
pip install --upgrade pip
pip install requests
pip install pyyaml
python /scripts/workspace_deploy.py "$1" $2 $3 $4
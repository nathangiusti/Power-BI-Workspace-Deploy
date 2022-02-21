#!/bin/sh
pip install --upgrade pip
pip install requests
pip install pyyaml
python /scripts/workspace_deploy.py --files "$1" --tenant_id $2 --workspace_id $3 --pbix_name_conflict $4 \
--override_model_name $5 --override_report_label $6 --max_file_size_supported_in_mb $7 \
--rdl_max_file_size_supported_in_mb $8 --rdl_name_conflict $9
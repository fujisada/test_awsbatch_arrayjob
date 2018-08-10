#!/bin/bash

item=$(cat << EOS
{
    "id" : {
        "S" : "$(date +%s)_$(echo $(( $RANDOM )))"
    },
    "seq_id" : {
        "S" : "$SEQ_ID"
    },
    "job_array_index" : {
        "N" : "$AWS_BATCH_JOB_ARRAY_INDEX"
    },
    "unixtime" : {
        "N" : "$(date +%s)"
    }
}
EOS
)

echo "put item: $item"
aws dynamodb put-item \
    --table-name $DYNAMO_TABLE \
    --item "$item"

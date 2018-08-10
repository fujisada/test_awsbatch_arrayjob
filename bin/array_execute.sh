#!/bin/bash

tablename=$DYNAMO_TABLE
item=$(cat << EOS
{
    "id" : {
        "S" : "$(date +%s)_$(echo $(( $RANDOM )))"
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
    --table-name test_batcharray \
    --item "$item"

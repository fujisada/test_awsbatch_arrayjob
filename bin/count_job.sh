#!/bin/bash

condition=$(cat <<EOS
{
    "seq_id" : {
        "ComparisonOperator" : "EQ",
        "AttributeValueList" : [
            {
                "S": "$SEQ_ID"
            }
        ]
    }
}
EOS
)

return=$(aws dynamodb query \
    --table-name $DYNAMO_TABLE \
    --index-name seq_id-index \
    --key-conditions "$condition"
)

num=$(
    echo $return \
    | jq -r '.Items[].sleep_time.N' \
    | awk '{if ($1 >= 5) print $1;}' \
    | wc -l
)

echo "5[sec]以上sleepしたJobの数は "$num" 個です"

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

total=$(echo $return | jq .Count)

num=$(
    echo $return \
    | jq -r '.Items[].sleep_time.N' \
    | awk '{if ($1 >= 5) print $1;}' \
    | wc -l
)

msg="5[sec]以上sleepしたJobの数は "$total" 個中 "$num" 個です"
echo $msg

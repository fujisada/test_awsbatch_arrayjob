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

aws dynamodb query \
    --table-name $DYNAMO_TABLE \
    --index-name seq_id-index \
    --key-conditions "$condition"

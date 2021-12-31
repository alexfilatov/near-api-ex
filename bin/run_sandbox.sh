#!/bin/bash

cd ../test/sandbox/nearcore \
 && rm -rf /tmp/near-sandbox/ \
 && target/debug/near-sandbox --home /tmp/near-sandbox init \
 && target/debug/near-sandbox --home /tmp/near-sandbox run

#!/bin/bash

cd ../test/sandbox/nearcore \
 && target/debug/near-sandbox --home /tmp/near-sandbox init \
 && target/debug/near-sandbox --home /tmp/near-sandbox run

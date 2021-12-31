#!/bin/bash

cd ../test/sandbox \
  && git clone https://github.com/near/nearcore \
  && cd nearcore \
  && make sandbox

#!/bin/bash

echo "Testing tool info..."

../src/tool.sh info

if [ $? -eq 0 ]; then
   echo "info test passed"
else
   echo "info test failed"

fi

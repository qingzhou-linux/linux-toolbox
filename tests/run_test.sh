#!/bin/bash


echo "======================"
echo " Linux Toolbox Test "
echo "======================"


echo ""

echo "Running info test..."

./test_info.sh


if [ $? -eq 0 ]; then
    echo "info test OK"
else
    echo "info test FAILED"
fi


echo ""

echo "======================"
echo " Test Finished "
echo "======================"

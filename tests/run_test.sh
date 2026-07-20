#!/bin/bash


echo "======================"
echo " Linux Toolbox Test "
echo "======================"


TEST_DIR=$(cd "$(dirname "$0")" && pwd)


pass_count=0
fail_count=0



run_test()
{

    name=$1
    file=$2


    echo ""

    echo "Running $name..."


    if bash "$TEST_DIR/$file"; then

        echo "[PASS] $name"

        pass_count=$((pass_count+1))


    else

        echo "[FAIL] $name"

        fail_count=$((fail_count+1))

    fi

}



run_test "info test" "test_info.sh"


run_test "backup test" "test_backup.sh"


run_test "clean test" "test_clean.sh"

run_test "compress test" "test_compress.sh"

echo ""

echo "======================"

echo " Test Summary "

echo "======================"

echo "Passed: $pass_count"

echo "Failed: $fail_count"



if [ "$fail_count" -ne 0 ]; then

    exit 1

fi



echo ""

echo "All tests passed"

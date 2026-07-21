#!/bin/bash


echo "======================"
echo " Shell Code Check "
echo "======================"


PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)



echo ""
echo "Running bash syntax check..."



find "$PROJECT_ROOT/src" \
"$PROJECT_ROOT/tests" \
-name "*.sh" \
-print0 |
while IFS= read -r -d '' file
do

    echo "Checking: $file"

    bash -n "$file"

    if [ $? -ne 0 ]; then

        echo "Syntax error: $file"

        exit 1

    fi

done



echo "bash syntax check passed"



echo ""
echo "Running ShellCheck..."



shellcheck \
"$PROJECT_ROOT"/src/*.sh \
"$PROJECT_ROOT"/src/lib/*.sh \
"$PROJECT_ROOT"/tests/*.sh



if [ $? -ne 0 ]; then

    echo "ShellCheck failed"

    exit 1

fi



echo ""
echo "ShellCheck passed"



echo ""
echo "All code checks passed"

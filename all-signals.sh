#!/bin/bash

#dotnet build -c Release

SIGNALS=$(man 7 signal | col -b | grep -v -i 'synonym' | grep -Po 'SIG(\w+)\s+(?:P\d+|-)\s+(Core|Term|Ign!|Cont!|Stop!)' |  sed -r 's/(SIG\S+)\s+\S+\s+(\w+)/\1=\2/' | grep -vP '(POLL|EMT|LOST)=')

for ss in $SIGNALS; do

    echo -en '\033[32m'
    echo $ss | sed -r 's/(\w+)=(\w+)/Signal \1 (\2)/'
    echo -en '\033[0m'
    s=$(echo $ss | sed -r 's/(\w+)=(\w+)/\1/')

    ./test-signal/bin/Release/net10.0/test-signal >/dev/null &
    PID=$!
    sleep 2
    echo -e "\033[33mSending $s...\033[0m"
    echo -en '\033[31m'
    kill -n $s $PID
    wait $PID
    echo -en '\033[0m'
done




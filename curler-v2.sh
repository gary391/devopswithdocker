#!/bin/sh

while true
do
  echo "Searching..";
  sleep 1; curl http://$1;
done

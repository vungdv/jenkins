#!/bin/bash
sleep 5
test $(curl calculator:8080/sum?a=1\&b=2) -eq 3
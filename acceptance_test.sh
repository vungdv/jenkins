#!/bin/bash
CALCULATOR_PORT=$(docker-compose port calculator 8080 | cut -d: -f2)
echo http://localhost:$CALCULATOR_PORT/sum?a=1\&b=2
curl http://localhost:$CALCULATOR_PORT/sum?a=1\&b=2
test $(curl http://localhost:$CALCULATOR_PORT/sum?a=1\&b=2) -eq 3
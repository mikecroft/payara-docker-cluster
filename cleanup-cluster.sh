#!/bin/bash - 
#===============================================================================
#
#          FILE: teardown-cluster.sh
# 
#         USAGE: ./teardown-cluster.sh 
# 
#   DESCRIPTION: A script to cleanup the Payara cluster containers
# 
#        AUTHOR: Mike Croft
#  ORGANIZATION: Payara
#===============================================================================

set -o nounset                              # Treat unset variables as an error


# Attempt to clean up any old containers
docker kill das   >/dev/null 2>&1
docker kill node1 >/dev/null 2>&1

docker rm das     >/dev/null 2>&1
docker rm node1   >/dev/null 2>&1

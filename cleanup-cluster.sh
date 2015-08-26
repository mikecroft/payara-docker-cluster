#!/bin/bash - 
#===============================================================================
#
#          FILE: teardown-cluster.sh
# 
#         USAGE: ./teardown-cluster.sh 
# 
#   DESCRIPTION: A script to cleanup the Payara cluster containers
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Mike Croft
#  ORGANIZATION: Payara
#       CREATED: 08/26/2015 21:08
#      REVISION: 0.1
#===============================================================================

set -o nounset                              # Treat unset variables as an error


# Attempt to clean up any old containers
docker kill das   >/dev/null 2>&1
docker kill node1 >/dev/null 2>&1

docker rm das     >/dev/null 2>&1
docker rm node1   >/dev/null 2>&1

#!/bin/bash - 
#===============================================================================
#
#          FILE: resume-cluster.sh
# 
#         USAGE: ./resume-cluster.sh 
# 
#   DESCRIPTION: Resumes docker cluster rather than recreating
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 08/12/15 09:53
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

ASADMIN=/opt/payara41/glassfish/bin/asadmin
PAYA_HOME=/opt/payara41
PASSWORD=admin
RASADMIN="$ASADMIN --user admin --passwordfile=$PAYA_HOME/pfile --port 4848 --host das"

docker start das 2>/dev/null
docker start node1 2>/dev/null

docker exec das $ASADMIN start-domain domain1

docker exec das   $RASADMIN start-local-instance --sync  full i00
docker exec das   $RASADMIN start-local-instance --sync  full i01
docker exec node1 $RASADMIN start-local-instance --sync  full i10
docker exec node1 $RASADMIN start-local-instance --sync  full i11

#!/bin/bash - 
#===============================================================================
#
#          FILE: run-cluster.sh
# 
#         USAGE: ./run-cluster.sh 
# 
#   DESCRIPTION: A script to launch Payara docker containers and configure them
#                in a cluster
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

ASADMIN=/opt/payara41/glassfish/bin/asadmin
PAYA_HOME=/opt/payara41

# Attempt to clean up any old containers
docker kill das   >/dev/null 2>&1
docker kill node1 >/dev/null 2>&1

docker rm das     >/dev/null 2>&1
docker rm node1   >/dev/null 2>&1

# Run new containers
docker run -i -p 4848:4848 -t -d --name das   payara:4.1.152.1.zulu8  /bin/bash
docker run -i              -t -d --name node1 payara:4.1.152.1.zulu8  /bin/bash

# Create cluster
docker exec das $ASADMIN start-domain domain1

docker exec das curl  -X POST \
    -H 'X-Requested-By: YeaGlassFish' \
    -H "Accept: application/json" \
    -d id=admin \
    -d AS_ADMIN_PASSWORD= \
    -d AS_ADMIN_NEWPASSWORD=glassfish \
    http://localhost:4848/management/domain/change-admin-password

docker exec das $ASADMIN --user admin --passwordfile pwdfile enable-secure-admin
docker exec das $ASADMIN restart-domain domain1

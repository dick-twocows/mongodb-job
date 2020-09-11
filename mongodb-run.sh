#!/usr/bin/env bash

source "/common.sh"

log_info "--username ${MONGODB_USERNAME} --password ${MONGODB_PASSWORD} --authenticationDatabase admin --host ${MONGODB_HOST} ${MONGODB_RUN}"

mongo --username "${MONGODB_USERNAME}" --password "${MONGODB_PASSWORD}" --authenticationDatabase "admin" --host "${MONGODB_HOST}" "${MONGODB_RUN}"
mongo_exit_status=${?}
log_info "mongo exit status [${mongo_exit_status}]"
exit ${mongo_exit_status}

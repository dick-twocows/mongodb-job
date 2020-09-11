#!/usr/bin/env bash

# LOGFILE=/notify-mysql.log
# RETAIN_NUM_LINES=100

function logsetup {
  echo [${LOGFILE}] [${RETAIN_NUM_LINES}]
  TMP=$(tail -n $RETAIN_NUM_LINES $LOGFILE 2>/dev/null) && echo "${TMP}" > $LOGFILE
  exec > >(tee -a $LOGFILE)
  exec 2>&1
}

function log_setup {
  echo "LOG_DEBUG [${LOG_DEBUG}] LOG_INFO [${LOG_INFO}]"
  while read LINE; do
    log_echo "${LINE}"
  done </release.txt
}

function log_echo {
  echo "[$(date --rfc-3339=seconds)]: $*"
}

function log_debug {
  if [ "${LOG_DEBUG}" == "true" ]
  then
    log_echo [debug] ${*}
  fi
}

function log_error {
  log_echo [error] ${*}
}

function log_info {
  log_echo [info] ${*}
}

#!/usr/bin/env bash

# DickM
# Wrapper which will gracefully exit when SIGTERM is received.
# The term_handler() will send a SIGTERM to the wrapped process and wait for it to exit.

source "/common.sh"

pid=0

# SIGUSR1-handler
sigusr1_handler() {
  log_info "SIGUSR1"
  if [ -f "/sigusr1.sh" ]
  then
    "/sigusr1.sh"
  fi
}

# SIGTERM-handler
sigterm_handler() {
  log_info "SIGTERM"

  if [ -f "/sigterm.sh" ]
  then
    "/sigterm.sh"
  fi

  if [ ${pid} -ne 0 ]
  then
    log_info "SIGTERM wrapped process"
    kill -SIGTERM "$pid"
    log_info "Wait for wrapped process"
    wait "$pid"
  fi

  log_info "Exit (Bye)"
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
log_info "Trap SIGUSR1"
trap 'kill ${!}; sigusr1_handler' SIGUSR1
log_info "Trap SIGTERM"
trap 'kill ${!}; sigterm_handler' SIGTERM

log_info "Run wrapped process [${@}]"
${@} &
pid="${!}"
log_info "Wrapped proces PID [${pid}]"

# wait forever
log_info "Wait forever (I love you)"
# while true
# do
#   tail -f /dev/null & wait ${!}
# done
wait ${pid}
child_exit_status=${?}
log_info "Child exited with [${child_exit_status}]"
log_info "Bye"
exit ${child_exit_status}

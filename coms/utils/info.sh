#!/usr/bin/env bash

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/logging.sh"


# Touch a empty file with version record
function stamp_version_record {
  local -r outdir=$1
  local -r record=$2
  local -r fpath=${outdir}/version.${record}
  if [[ ! -f ${fpath} ]]; then
    touch ${fpath}
    log_info "Stamped version record."
  else
    log_info "${fpath} already stamped."
  fi
}

# Print help message
function print_help_message {
  local -r prog=$1
  local -r version=$2
  local -r description=$3
  local -r usage=$4
  echo -e "\nProgram: ${prog}\nVersion: ${version}\nDescription: ${description}\n\nUsage: ${usage}\n"
}

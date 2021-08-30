#!/usr/bin/env bash

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/logging.sh"


# Create directories simple
function create_dirs {
  for path in $*; do
    if [[ ! -d ${path} ]]; then
      mkdir -p ${path}
      log_info "Created ${path}."
    else
      log_info "Directory ${path} already exists."
    fi
  done
}


# Create directories with mode and user group
function create_dirs_advanced {
  local -r user_group=$1
  local -r permission=$2
  shift 2
  for path in $*; do
    if [[ ! -d ${path} ]]; then
      mkdir -p -m=${permission} ${path} \
        && chown -R ${user_group} ${path} \
        && log_info "Created ${path} with mode ${permission} for ${user_group}."
    else
      log_info "Directory ${path} already exists."
    fi
  done
}

# Create file linking
function link_file {
  local -r src_file=$1
  local -r des_file=$2
  if [[ -f ${src_file} ]]; then
    ln -s ${src_file} ${des_file} && log_info "Has linked ${des_file} to ${src_file}"
  else
    log_error "Source file ${src_file} not exists"
  fi
}
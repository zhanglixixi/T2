#!/usr/bin/env bash

# Here are settings that global to modules and scenarios
# Be aware that ANY changes will apply to ALL modules


# versioning
function global_settings_version {
  local -r name=$(basename "${BASH_SOURCE[0]}")
  local -r version_main="1.0"
  local -r update="200921"
  local -r version_full="${version_main}.${update}"
  echo "${name}: ${version_full}"
}


# set sentieon environment
function set_sentieon_envs {
#  set -x
  export SENTIEON_LICENSE="10.10.10.11:8990"
  sentieon_version="201911"
  export SENTIEON_INSTALL_DIR="/aegis/staff/yongchu/sentieon/sentieon-genomics-${sentieon_version}"
  sentieon_bindir="${SENTIEON_INSTALL_DIR}/bin"
  export PATH=$PATH:${sentieon_bindir}
  export bwt_max_mem=60G
  printenv | grep bwt_max_mem
}


# activate conda environment
function set_global_conda_env {
  local -r conda_dir="/qh03/env/anaconda3.dev1"
  local -r env_name="biomodules"
  source ${conda_dir}/bin/activate ${env_name}
}


# source commonly used functions
function use_common_functions {
  source $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common-functions.sh
}

# General settings
function set_general_configs {
  nt_com=24
  nt_fastp=16
  nt_roh=8
  temp_dir="/aegi/projects/scratch/Coms"
  ref_fasta="/qh04/database/human/genome/hg19/v1/fasta/human_g1k_v37_modified.fasta"
}

use_common_functions
set_general_configs

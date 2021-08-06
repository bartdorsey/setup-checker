#!/bin/bash
NO_FORMAT="\033[0m"
C_GREEN="\033[1;92m"
C_CYAN="\033[0;36m"
C_RED="\033[1;91m"
F_BOLD="\033[1m"
C_WHITE="\033[1:97m"
C_YELLOW="\033[1;33m"

hr() {
  s=$(printf "%-${COLUMNS}s" "")
  f_bold "${s// /―}"
  return
}

title() {
  c_cyan "${@}"
  return
}

c_cyan() {
  printf "%b%s%b\n" "${C_CYAN}" "${@}" "${NO_FORMAT}"
  return
}

c_red() {
  printf "%b%s%b\n" "${C_RED}" "${@}" "${NO_FORMAT}"
  return
}

c_yellow() {
  printf "%b%s%b\n" "${C_YELLOW}" "${@}" "${NO_FORMAT}"
  return
}

c_green() {
  printf "%b%s%b\n" "${C_GREEN}" "${@}" "${NO_FORMAT}"
  return
}

f_bold() {
  printf "%b%b%s%b\n" "${F_BOLD}" "${C_WHITE}" "${@}" "${NO_FORMAT}"
  return
}

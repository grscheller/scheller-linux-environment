#!/bin/sh
# shellcheck shell=sh
# shellcheck source=/dev/null
#
#    ~/.env_init
#
#  Configure initial values of $PATH and environment
#  variables you wish child processes, perhaps other
#  shells, to initially inherit.
#
#  This was traditionally done in .profile or .bash_profile
#  whenever a login shell was created.  Unfortunately,
#  in most Desktop Environments, the shells in terminal
#  emulators are not decendant from a login shell.
#  We no longer are assured that .profile ever gets sourced.
#
#  Non-existent path and duplicate path elements
#  will be dealt with near end of script.
#

## Sentinel value to mark completion of
#  an initial environment configuration.
export ENV_INIT_LVL=${ENV_INIT_LVL:=0}
ENV_INIT_LVL=$(( ENV_INIT_LVL + 1 ))

## Default file permissions - group way too broad for work CentOS 7
if [ ! -f /etc/redhat-release ]
then
    umask u=rwx,g=rx,o=
else
    umask u=rwx,g=,o=
fi

export EDITOR=vim
export VISUAL=vim
export FCEDIT=vim

## My e-mail addresses
export ME_HOVER='geoffrey@scheller.com'
export ME_GMAIL='grscheller@gmail.com'
export ME_WORK='geoffrey.scheller.1@us.af.mil'

## Set locale so applications (like Python) display unicode correctly
export LANG=en_US.utf8

## Python configuration
export PYTHONPATH=lib:../lib
export PIP_REQUIRE_VIRTUALENV=true

## Save original PATH
[ -z "$VIRGIN_PATH" ] && export VIRGIN_PATH=$PATH

## For Haskell locally contained and administered via stack
PATH=~/.local/bin:$PATH

## Location Rust Toolchain
PATH=~/.cargo/bin:$PATH

## Locally installed SBT (Scala Build Tool)
PATH=~/opt/sbt/bin:$PATH

## For Termux environment
PATH=$PATH:/data/data/com.termux/files/usr/bin/applets

## Put home bin directory near end
PATH=$PATH:~/bin

## Put a relative bin directory at end of PATH, this is for
#  projects where my user takes up residence in the project's
#  root directory.
PATH=$PATH:bin 

## Clean up PATH - remove duplicate absolute path entries
[ -x ~/bin/pathtrim ] && PATH=$(~/bin/pathtrim "$PATH")

## Information for ssh configuration
#
#                  Host-Name           port   login
export    VOLTRON='rvsllschellerg2        22  schelleg'
export      KOALA='rvswlschellerg1        22  schelleg'
export LITTLEJOHN='rvswlwojcikj1          22  schelleg'
export    GAUSS17='gauss17             31502  grs'
export   MAXWELL4='maxwell4            29801  geoffrey'
export     EULER7='euler7                 22  grs'

#!/bin/bash
set -e
# BuildKit is only supported on docker > 18.09
# Buildkit can be enabled on 18.03 by enabling experimental features.
docker_image_tag_prefix="oscimp-buildroot"

buildkit_enabled=0

display_usage()
{
  # Display help
cat << EOF
Usage : build.sh [options]

Build OSCIMP Buildroot inside docker.
This script uses buildkit,
See options to disable buildkit if you have issues.

-k --enable-buildkit   Enable docker build-kit
-l --no-latest-tag     Disable tagging latest
-h --help              Display this message
-b --board {pluto|red} Board type
EOF
}


display_info()
{
  printf "\n--------------------------------------------------------\n"
  printf "Build Version           : ${BOARD}\n"
  printf "Docker Tag              : ${docker_image_tag}\n"
  printf "Buildkit status         : ${buildkit_enabled}\n"
  printf "Disable Latest Tag      : ${disable_latest_tag}\n"
  printf "\n--------------------------------------------------------\n"
}


build_docker_image()
{
  if [[ $buildkit_enabled == "0" ]]; then
    printf "Docker Buildkit is disabled!\n"
    export DOCKER_BUILDKIT=0
  else
    printf "Buildkit is enabled! please disable it if you experience issues!\n"
    export DOCKER_BUILDKIT=1
  fi

  printf "Building docker image for ${BOARD}\n"

  if [[ $CI == "true" ]]; then
    COMMIT_ID="${CIRCLE_SHA1}"
  else
    COMMIT_ID="$(git rev-parse HEAD)"
  fi

  if [[ $skip_build == "true" ]];then
    echo "Skipping Build"
    env
    ( set -o posix ; set )
  else
    docker_image_tag="${docker_image_tag_prefix}-${BOARD}:${COMMIT_ID:0:7}"
    docker build --tag ${docker_image_tag} ${BOARD}

    if [[ $disable_latest_tag == "true" ]]; then
      printf "Image will not be tagged latest.\n"
    else
      printf "Add latest tag...\n"
      docker tag "${docker_image_tag}" "${docker_image_tag_prefix}-${BOARD}:latest"
    fi

    if [[ $run_dummy == "true" ]]; then
      docker run --name buildroot ${docker_image_tag_prefix}-${BOARD}:${COMMIT_ID:0:7} /bin/true
    fi
  fi

}


main()
{
  while [ "${1}" != "" ]; do
    case ${1} in
      -k | --enable-buildkit)          buildkit_enabled=1;;
      -l | --no-latest-tag)            disable_latest_tag="true";;
      -h | --help)                     display_usage;exit 0;;
      -b | --board)                    shift;board="${1}";;
      -d | --dummy)                    run_dummy="true";;
      --skip-build)                    skip_build="true";;
      *)                               printf "Invalid argument!\n";exit 1;;
    esac
    shift
  done

  case ${board} in
    pluto | plutosdr )     echo "Board is set to pluto"; BOARD="plutosdr";;
    redpitaya | red)       echo "Board is set to RedPitaya";BOARD="redpitaya";;
    *)                     echo "Board not supported!";exit 1;;
  esac

  display_info
  build_docker_image;
}

main "$@"
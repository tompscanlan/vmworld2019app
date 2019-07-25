#!/bin/bash

set -eu -o pipefail

if [ "${DEMO_ENVIRONMENT:-none}" = "aws" ] ; then
  aws ecr get-login --region us-east-1 | sed 's, -e none , ,'  | sh
fi

if [ "${DOCKER_REGISTRY_USERNAME:-}" != "" ] && [ "${DOCKER_REGISTRY_PASSWORD:-}" != "" ] ; then
  docker login -u "${DOCKER_REGISTRY_USERNAME}" -p "${DOCKER_REGISTRY_PASSWORD}" "${DOCKER_REGISTRY}"
fi

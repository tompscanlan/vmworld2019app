#!/bin/bash

uniqueBuildTag() {
  echo "${CI_PROJECT_ID}:${CI_PIPELINE_ID}:${CI_RUNNER_ID}" | sha256sum - | sed 's,\s.*$,,'
}

imageTag() {
  git rev-parse HEAD
}

#!/bin/sh

set -eu

. "$(dirname "${0}")/functions.sh"

pushChart() {
  local filename="kubernetes/helm/acmefitness-$(imageTag).tgz"

  echo "Uploading chart..."
  ls -la "${filename}"

  curl --data-binary "@${filename}" ${CHARTMUSEUM_REGISTRY}
}

pushChart

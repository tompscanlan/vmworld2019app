#!/bin/bash

set -eu -o pipefail

if [ "${CHARTMUSEUM_KUBEAPPS_REPO:-}" != "" ] ; then
  echo "Patching kubeapps ${CHARTMUSEUM_KUBEAPPS_REPO} repository..."
  kubectl patch apprepos -n kubeapps "${CHARTMUSEUM_KUBEAPPS_REPO}" -p "[{\"op\": \"replace\", \"path\": \"/spec/resyncRequests\", \"value\": \"$RANDOM\"}]" --type=json
fi

#!/bin/bash

set -eu -o pipefail

. "$(dirname "${0}")/functions.sh"

prepareValuesYaml() {
  sed -i \
    "s!^.*#PLACEHOLDER:image:registry!  registry: \"${DOCKER_REGISTRY}\"!;s!^.*#PLACEHOLDER:image:repositoryPrefix!  repositoryPrefix: \"${DOCKER_REPOSITORY_PREFIX}\"!;s!^.*#PLACEHOLDER:image:tag!  tag: \"$(imageTag)\"!" \
    "acme_fitness_demo/helm/acmefitness/values.yaml"
}

buildChart() {
  bash -c "rm -f acme_fitness_demo/helm/acmefitness-*.tgz"

  docker run --entrypoint=/bin/sh --rm -v $(pwd)/acme_fitness_demo/helm:/apps alpine/helm:2.14.0 -c \
    'helm init --client-only && helm package /apps/acmefitness -d /apps'

  mv acme_fitness_demo/helm/acmefitness-*.tgz "acme_fitness_demo/helm/acmefitness-$(imageTag).tgz"

  ls -la "acme_fitness_demo/helm/acmefitness-$(imageTag).tgz"
}

prepareValuesYaml
buildChart

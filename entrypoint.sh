#!/bin/sh -l

KUBERNETES_CERT="$1"
KUBERNETES_SERVER="$2"
KUBERNETES_TOKEN="$4"
NAMESPACE="$3"
DEPLOYMENT="$6"
IMAGE="$7"
CONTAINER="$7"

env

if [ -z "${KUBERNETES_USER}" ]; then
  KUBERNETES_USER="default"
fi

kubectl config set-credentials default --token="${KUBERNETES_TOKEN}"

echo "${KUBERNETES_CERT}" | base64 -d > ca.crt

kubectl config set-cluster default --server="${KUBERNETES_SERVER}" --certificate-authority=ca.crt
kubectl config use-context default

echo "Deploying to $KUBERNETES_SERVER"

kubectl -n "${NAMESPACE}" set image "deployment/${DEPLOYMENT}" "${CONTAINER}=${IMAGE}" --record

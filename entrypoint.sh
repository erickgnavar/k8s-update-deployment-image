#!/bin/sh -l

KUBERNETES_CERT="${INPUT_CERT}"
KUBERNETES_SERVER="${INPUT_SERVER}"
KUBERNETES_TOKEN="${INPUT_TOKEN}"
NAMESPACE="${INPUT_NAMESPACE}"
DEPLOYMENT="${INPUT_NAME}"
IMAGE="${INPUT_IMAGE}"
CONTAINER="${INPUT_CONTAINER}"

# TODO: remove this env call
env

if [ -z "${KUBERNETES_USER}" ]; then
  KUBERNETES_USER="default"
fi

kubectl config set-credentials default --token="${KUBERNETES_TOKEN}"

echo "${KUBERNETES_CERT}" | base64 -d > ca.crt

kubectl config set-cluster default --server="${KUBERNETES_SERVER}" --certificate-authority=ca.crt
kubectl config use-context default

echo "Deploying to ${KUBERNETES_SERVER}"

kubectl -n "${NAMESPACE}" set image "deployment/${DEPLOYMENT}" "${CONTAINER}=${IMAGE}"

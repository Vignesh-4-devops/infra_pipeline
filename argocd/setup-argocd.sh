#!/bin/bash

set -ex

NAMESPACE="argocd"
PORT_LOCAL=4444
PORT_REMOTE=443

echo "[1/5] Creating namespace '$NAMESPACE'..."
kubectl create namespace "$NAMESPACE" || echo "Namespace already exists."

echo "[2/5] Installing ArgoCD..."
kubectl apply -n "$NAMESPACE" -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "[3/5] Waiting for ArgoCD server to be ready..."
kubectl wait --for=condition=available deployment/argocd-server -n "$NAMESPACE" --timeout=180s

echo "[4/5] Fetching ArgoCD initial admin password..."
ARGO_PASS=$(kubectl get secret argocd-initial-admin-secret -n "$NAMESPACE" \
  -o jsonpath="{.data.password}" | base64 -d)
echo "=============================================="
echo " ArgoCD is ready! Login at: https://localhost:$PORT_LOCAL"
echo " Username: admin"
echo " Password: $ARGO_PASS"
echo "=============================================="

echo "[5/5] Starting port-forward to localhost:$PORT_LOCAL..."
echo "Press Ctrl+C to stop."

# Trap Ctrl+C and clean up
cleanup() {
  echo -e "\nStopping port-forward..."
  exit 0
}
trap cleanup INT

# Run port-forward in foreground
kubectl port-forward svc/argocd-server -n "$NAMESPACE" $PORT_LOCAL:$PORT_REMOTE

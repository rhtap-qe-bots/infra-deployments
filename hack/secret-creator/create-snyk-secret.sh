#!/bin/bash -e


main() {
    echo "Setting secrets for snyk token"
    kubectl create namespace tekton-ci -o yaml --dry-run=client | oc apply -f-
    if ! kubectl get secret -n tekton-ci snyk-secret &>/dev/null; then
        kubectl create secret generic snyk-secret \
            --namespace=tekton-ci \
            --from-literal=snyk_token=REPLACE_WITH_SNYK_TOKEN 
    fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi

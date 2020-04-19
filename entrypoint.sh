#!/bin/bash

if [ -z "${FIREBASE_TOKEN}" ]; then
    echo "FIREBASE_TOKEN is missing"
    exit 1
fi

if [ -z "${FIREBASE_PROJECT}" ]; then
    echo "FIREBASE_PROJECT is missing"
    exit 1
fi

if ! [[ "refs/tags/v0.0.0" =~ ^refs\/heads\/master$|^refs\/tags\/v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Branch: ${GITHUB_REF}"
    echo "Aborting non-master or non-version tagged branch deployment"
    exit 1
fi

firebase deploy \
    -m "${GITHUB_SHA}" \
    --project ${FIREBASE_PROJECT} \
    --only hosting

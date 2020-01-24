#!/bin/bash
# This is created from the IAM steps provided here:
# https://docs.openshift.com/container-platform/4.2/installing/installing_gcp/installing-gcp-account.html

PROJECT_ID=$(gcloud config get-value core/project)

echo "You are about to create a service account with an Owner role in project: ${PROJECT_ID}"
read -p "[Return to continue, control+c to quit]"
echo "----"

echo "Creating service account"
gcloud iam service-accounts create openshift4-installer \
--description "This is used for installing OpenShift 4" \
--display-name "OpenShift 4 Installer Service Account"
echo ""

echo "Binding role of owner to service account"
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member=serviceAccount:openshift4-installer@${PROJECT_ID}.iam.gserviceaccount.com \
  --role=roles/owner
echo ""

echo "creating access keys for service account"
gcloud iam service-accounts keys create ./openshift4-gcp-key.json \
  --iam-account openshift4-installer@${PROJECT_ID}.iam.gserviceaccount.com
echo ""

echo "----"
echo "All done."
echo "Your new SA is created and configured, the access key in your home path ./openshift4-gcp-key.json"

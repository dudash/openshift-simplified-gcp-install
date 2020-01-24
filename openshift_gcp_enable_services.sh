#!/bin/bash
# This is created from the list provided here:
# https://docs.openshift.com/container-platform/4.2/installing/installing_gcp/installing-gcp-account.html

gcloud config list
echo "This is your current config, you are about to enable services in the current project"
read -p "[Return to continue, control+c to quit]"
echo "----"

echo "enabling compute.googleapis.com"
gcloud services enable compute.googleapis.com
echo ""
echo "enabling cloudapis.googleapis.com"
gcloud services enable cloudapis.googleapis.com
echo ""
echo "enabling cloudresourcemanager.googleapis.com"
gcloud services enable cloudresourcemanager.googleapis.com
echo ""
echo "enabling dns.googleapis.com"
gcloud services enable dns.googleapis.com
echo ""
echo "enabling iamcredentials.googleapis.com"
gcloud services enable iamcredentials.googleapis.com
echo ""
echo "enabling iam.googleapis.com"
gcloud services enable iam.googleapis.com
echo ""
echo "enabling servicemanagement.googleapis.com"
gcloud services enable servicemanagement.googleapis.com
echo ""
echo "enabling serviceusage.googleapis.com"
gcloud services enable serviceusage.googleapis.com
echo ""
echo "enabling storage-api.googleapis.com"
gcloud services enable storage-api.googleapis.com
echo ""
echo "enabling storage-component.googleapis.com"
gcloud services enable storage-component.googleapis.com

echo "----"
echo "All done. Here are your enabled services"
gcloud services list
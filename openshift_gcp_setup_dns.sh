#!/bin/bash
# This is created from the DNS steps provided here:
# https://docs.openshift.com/container-platform/4.2/installing/installing_gcp/installing-gcp-account.html

PROJECT_ID=$(gcloud config get-value core/project)

echo "Please provide your DNS domain or subdomain for the OpenShift public zone (e.g. example.com):"
read DNS_DOMAIN
echo "You are about to create a public zone for ${DNS_DOMAIN} in project: ${PROJECT_ID}"
read -p "[Return to continue, control+c to quit]"
echo "----"
gcloud dns managed-zones create openshift-zone \
    --dns-name="${DNS_DOMAIN}" \
    --description="A zone for your OpenShift 4 cluster" \
    --visibility=public

sleep 2

echo "Here are your zone details (including name servers):"
gcloud dns managed-zones describe openshift-zone
echo "----"

echo "You should now go update the name servers to use the above."
echo "For example if you registered your domain using google domains, then you will go here:"
echo "https://domains.google.com/m/registrar/${DNS_DOMAIN}/dns"

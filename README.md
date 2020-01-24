[![OpenShift Version][openshift4x-logo]][openshift4x-url]

# OpenShift Simplified - Setting up OpenShift on GCP

I'm going to try to simplify setting up OpenShift for you. If you want to do this the offical way, just follow Red Hat instructions here:
https://docs.openshift.com/container-platform/4.3/installing/installing_gcp/installing-gcp-account.html

## Prereqs
* You have a google cloud account
* You installed the `gcloud` [CLI/SDK](https://cloud.google.com/sdk/gcloud/).
* You've got an OpenShift 4 subscription or a trial
* You've got a domain name to use for this cluster and can update the NS records to point to GCP

## Steps
1. Create a new gcloud project or switch to a new one
    >`gcloud projects create ocp43demo`

2. If you need to link billing, do that in the dashboard:
    [https://console.cloud.google.com/home/dashboard](https://console.cloud.google.com/home/dashboard)

3. I wrote 3 shell scripts for configuring the GCP project. Download them from my github gists:
    > `curl https://raw.githubusercontent.com/dudash/openshift-simplified-gcp-install/master/openshift_gcp_enable_services.sh > openshift_gcp_enable_services.sh`

    > `curl https://raw.githubusercontent.com/dudash/openshift-simplified-gcp-install/master/openshift_gcp_setup_iam.sh > openshift_gcp_setup_iam.sh`

    >`curl https://raw.githubusercontent.com/dudash/openshift-simplified-gcp-install/master/openshift_gcp_setup_dns.sh > openshift_gcp_setup_dns.sh`

    >`chmod a+x openshift_gcp*`

4. Now run the scripts and provide requested info:
    >`./openshift_gcp_enable_services.sh`

    >`./openshift_gcp_setup_iam.sh`

    >`./openshift_gcp_setup_dns.sh`

5. We need a SSH keypair to access the master nodes (for debugging / admin) - if you don't already you can make/add them with:
   >`ssh-keygen -t rsa -b 4096 -N '' -f ~/.ssh/gcp_ocp43demo`
   
   >`ssh-add ~/.ssh/gcp_ocp43demo`

6. Download and extract the OpenShift installer for your OS from here: [https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/)
   
   *optional: might as well download the client tools from there too*

7. Go to this redhat webpage, scroll down to the `Copy Pull Secret` button and click it. [https://cloud.redhat.com/openshift/install/gcp/installer-provisioned](https://cloud.redhat.com/openshift/install/gcp/installer-provisioned)
   
8. Run the openshift installer and answer questions, then paste the pull secret in when it prompts for it.
   >`./openshift-install create cluster --dir=. --log-level=info`

That should be it!

## Deleting a cluster
>`./openshift-install destroy cluster`

## Other Notes
* Quotas might cause errors at runtime
  * Check OCP quotas here:
    * https://docs.openshift.com/container-platform/4.3/installing/installing_gcp/installing-gcp-account.html#installation-gcp-limits_installing-gcp-account
  * You can request quota increases in GCP here (make sure you're in the right project):
    * https://console.cloud.google.com/iam-admin/quotas



[openshift4x-url]: https://docs.openshift.com/container-platform/4.3/welcome/index.html

[openshift4x-logo]: https://img.shields.io/badge/openshift-4.x-820000.svg?labelColor=grey&logo=data:image/png;base64,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


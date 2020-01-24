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
    > `curl https://gist.githubusercontent.com/dudash/533d49d5e8c1b50e3d8f4d783cea7688/raw/abfb97fb69e364569f2be7ad142885cf3934faaf/openshift_gcp_enable_services.sh > openshift_gcp_enable_services.sh`

    > `curl https://gist.githubusercontent.com/dudash/58b3d9c67e2fe788a2b9d910f64e0ba3/raw/98e16dcf3e0989162e6331807aaa5b5333b8a77d/openshift_gcp_setup_iam.sh > openshift_gcp_setup_iam.sh`

    >`curl https://gist.githubusercontent.com/dudash/db5178b086cd5c977d14e801591ab047/raw/d8d77a12d496e3b41207efec727eb9542b4acc6d/openshift_gcp_setup_dns.sh > openshift_gcp_setup_dns.sh`

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

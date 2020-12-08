FROM python:3.6-alpine

LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="ansible-docker" \
  org.label-schema.description="Dockercontainer for running Ansible Playbookds" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vendor="daBONDi" \
  org.label-schema.version=$VERSION \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vcs-url="https://github.com/daBONDi/ansible-docker" \
  org.label-schema.url="https://github.com/daBONDi/ansible-docker/blob/master/README.md"

# Install new packages
RUN apk add --update build-base python3-dev jpeg-dev zlib-dev libffi-dev openssl-dev git openssh-client sshpass

# Upgrade pip
RUN pip install --upgrade pip

# Change LIBRARY_PATH environment variable because of error in building zlib
ENV LIBRARY_PATH=/lib:/usr/lib

# Set Workdir
WORKDIR /src

# Define volumes
VOLUME [ "/src" ]

# Install ansible
ARG ANSIBLE_VERSION=2.10
RUN pip install ansible==$ANSIBLE_VERSION

# Add Azure Collection
RUN pip install packaging requests[security] xmltodict azure-cli-core==2.11.1 azure-cli-nspkg==3.0.2 azure-common==1.1.11 azure-mgmt-authorization==0.51.1 azure-mgmt-batch==5.0.1 azure-mgmt-cdn==3.0.0 azure-mgmt-compute==10.0.0 azure-mgmt-containerinstance==1.4.0 azure-mgmt-containerregistry==2.0.0 azure-mgmt-containerservice==9.1.0 azure-mgmt-dns==2.1.0 azure-mgmt-keyvault==1.1.0 azure-mgmt-marketplaceordering==0.1.0 azure-mgmt-monitor==0.5.2 azure-mgmt-network==10.2.0 azure-mgmt-nspkg==2.0.0 azure-mgmt-privatedns==0.1.0 azure-mgmt-redis==5.0.0 azure-mgmt-resource==10.2.0 azure-mgmt-rdbms==1.4.1 azure-mgmt-servicebus==0.5.3 azure-mgmt-sql==0.10.0 azure-mgmt-storage==11.1.0 azure-mgmt-trafficmanager==0.50.0 azure-mgmt-web==0.41.0 azure-nspkg==2.0.0 azure-storage==0.35.1 msrest==0.6.10 msrestazure==0.6.4 azure-keyvault==1.0.0a1 azure-graphrbac==0.61.1 azure-mgmt-cosmosdb==0.5.2 azure-mgmt-hdinsight==0.1.0 azure-mgmt-devtestlabs==3.0.0 azure-mgmt-loganalytics==1.0.0 azure-mgmt-automation==0.1.1 azure-mgmt-iothub==0.7.0
RUN ansible-galaxy collection install azure.azcollection
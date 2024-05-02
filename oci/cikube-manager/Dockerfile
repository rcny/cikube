FROM docker.io/library/alpine:3.19.1

# Base
RUN apk add --no-cache \
        bash \
        ca-certificates \
        curl \
        git \
        libarchive-tools \
        nodejs \
        openssh-client \
        python3 \
        py3-pip \
        tar \
        unzip \
        wget

# Versions
ENV ANSIBLE_VERSION 9.2.0
ENV GCLOUD_VERSION 474.0.0
ENV HELM_VERSION 3.13.3
ENV K3SUP_VERSION 0.13.5
ENV KUBERNETES_VERSION 1.28.6
ENV PACKER_VERSION 1.9.5
ENV SOPS_VERSION 3.8.1
ENV TERRAFORM_VERSION 1.6.6
# Multiple RUN instructions are used because the image is built by Buildah and Buildah squashes layers by default

# Allow installing of Python packages system-wide
RUN mkdir -p ~/.config/pip && echo -e "[global]\nbreak-system-packages = true" > ~/.config/pip/pip.conf

# Ansible
RUN pip3 install ansible==${ANSIBLE_VERSION}

# gcloud CLI
# "--override-components" is used to bypass installation of the bundled Python
RUN wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz -O - | tar -xz -C /usr/share \
    && /usr/share/google-cloud-sdk/install.sh --quiet --usage-reporting false --override-components core gcloud-crc32c gsutil \
    && ln -s /usr/share/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud

# Helm
RUN wget -q https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm

# k3sup
RUN wget -q https://github.com/alexellis/k3sup/releases/download/${K3SUP_VERSION}/k3sup -O /usr/local/bin/k3sup

# kubectl
RUN wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl

# Packer
RUN wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O - | bsdtar -xf - -C /usr/local/bin packer

# SOPS
RUN wget -q https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux.amd64 -O /usr/local/bin/sops

# Terraform
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O - | bsdtar -xf - -C /usr/local/bin terraform

# Normalize permissions
RUN chown root:root /usr/local/bin/* \
    && chmod 755 /usr/local/bin/*

# Pre-install Packer plugins
RUN packer plugins install github.com/hashicorp/googlecompute v1.1.4 \
    && packer plugins install github.com/hashicorp/ansible v1.1.1

ENTRYPOINT ["/bin/bash", "-c"]

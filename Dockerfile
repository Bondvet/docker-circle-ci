FROM cimg/node:18.14.2

RUN \
    # add gcloud sdk \
    sudo apt-get install -y apt-transport-https ca-certificates gnupg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg \
    && sudo apt-get update -y  \
    && sudo apt-get install -y  \
    google-cloud-sdk -y hub build-essential \
    libavahi-compat-libdnssd-dev libssl-dev g++ \
    # install git-crypt \
    git-crypt \
    # install AWS CLI \
    && cd /tmp \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install

# fix missing libssl1.1
RUN wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.0l-1~deb9u6_amd64.deb \
    && sudo dpkg -i libssl1.1*.deb \
    && rm libssl1.1*.deb

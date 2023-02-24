FROM cimg/node:18.14.2



RUN \
    # add gcloud sdk \
    sudo apt-get install -y apt-transport-https ca-certificates gnupg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg \
    && sudo apt-get update -y  \
    && sudo apt-get install -y  \
    google-cloud-sdk -yhub build-essential \
    libavahi-compat-libdnssd-dev libssl-dev g++ \
    # install AWS CLI \
    && cd /tmp \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install
    # install git-crypt \
RUN curl https://github.com/AGWA/git-crypt/archive/refs/tags/0.7.0.tar.gz > git-crypt-0.7.0.tar.gz \
    && tar -xvzf git-crypt-0.7.0.tar.gz \
    && cd git-crypt-0.7.0 \
    && make && sudo make install PREFIX=/usr/local \
    # cleanup \
    && sudo apt-get autoremove -y \
    && sudo apt-get autoclean -y \
    && sudo apt-get clean -y \
    && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

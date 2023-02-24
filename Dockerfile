FROM cimg/node:18.14.2

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
  # add gcloud sdk
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
  && sudo apt-get update -y -qq \
  && sudo apt-get install -y \
    google-cloud-sdk hub build-essential \
    libavahi-compat-libdnssd-dev \
  # install AWS CLI \
  && cd /tmp \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && sudo ./aws/install \
  # install git-crypt
  && curl https://www.agwa.name/projects/git-crypt/downloads/git-crypt-0.6.0.tar.gz > git-crypt-0.6.0.tar.gz \
  && tar -xvzf git-crypt-0.6.0.tar.gz \
  && cd git-crypt-0.6.0 \
  && make && sudo make install PREFIX=/usr/local \
  # cleanup
  && sudo apt-get autoremove -y \
  && sudo apt-get autoclean -y \
  && sudo apt-get clean -y \
  && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

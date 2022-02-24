FROM circleci/node:16.13.1

# install git-crypt
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
  && echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list \
  && sudo apt-get update -qq \
  && sudo apt-get install -y build-essential \
    libavahi-compat-libdnssd-dev \
  && cd /tmp \
  && curl https://www.agwa.name/projects/git-crypt/downloads/git-crypt-0.6.0.tar.gz > git-crypt-0.6.0.tar.gz \
  && tar -xvzf git-crypt-0.6.0.tar.gz \
  && cd git-crypt-0.6.0 \
  && make && sudo make install PREFIX=/usr/local \
    # add gcloud sdk
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
  && sudo apt-get update -y \
  && sudo apt-get install google-cloud-sdk -y \
  # cleanup
  && sudo apt-get autoremove -y \
  && sudo apt-get autoclean -y \
  && sudo apt-get clean -y \
  && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM circleci/node:16.13.1

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
  # add gcloud sdk
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
  # add Github CLI
  && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt-get update -y -qq \
  && sudo apt-get install -y \
    google-cloud-sdk gh build-essential \
    libavahi-compat-libdnssd-dev \

  # install git-crypt
  && cd /tmp \
  && curl https://www.agwa.name/projects/git-crypt/downloads/git-crypt-0.6.0.tar.gz > git-crypt-0.6.0.tar.gz \
  && tar -xvzf git-crypt-0.6.0.tar.gz \
  && cd git-crypt-0.6.0 \
  && make && sudo make install PREFIX=/usr/local \

  # install balena cli
  && cd /tmp \
  && wget https://github.com/balena-io/balena-cli/releases/download/v13.7.0/balena-cli-v13.7.0-linux-x64-standalone.zip -O balena-cli.zip \
  && unzip balena-cli.zip \
  && sudo mkdir -p /usr/local/lib \
  && sudo mv balena-cli /usr/local/lib/ \

  # cleanup
  && sudo apt-get autoremove -y \
  && sudo apt-get autoclean -y \
  && sudo apt-get clean -y \
  && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH="/usr/local/lib/balena-cli:${PATH}"


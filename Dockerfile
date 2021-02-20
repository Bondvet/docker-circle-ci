FROM circleci/node:10.21.0

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

  # install balena cli
  && cd /tmp \
  && wget https://github.com/balena-io/balena-cli/releases/download/v12.40.0/balena-cli-v12.40.0-linux-x64-standalone.zip -O balena-cli.zip \
  && unzip balena-cli.zip \
  && sudo mkdir -p /usr/local/lib \
  && sudo mv balena-cli /usr/local/lib/ \

  # cleanup
  && sudo apt-get autoremove -y \
  && sudo apt-get autoclean -y \
  && sudo apt-get clean -y \
  && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV PATH="/usr/local/lib/balena-cli:${PATH}"


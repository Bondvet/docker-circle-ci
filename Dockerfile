FROM cimg/node:18.14.2


  # add gcloud sdk
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/cloud.google.gpg
RUN sudo apt-get update -y -qq
RUN sudo apt-get install -y \
    google-cloud-sdk hub build-essential \
    libavahi-compat-libdnssd-dev \
  # install AWS CLI \
RUN cd /tmp
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
  # install git-crypt
RUN curl https://www.agwa.name/projects/git-crypt/downloads/git-crypt-0.6.0.tar.gz > git-crypt-0.6.0.tar.gz
RUN tar -xvzf git-crypt-0.6.0.tar.gz
RUN cd git-crypt-0.6.0
RUN make && sudo make install PREFIX=/usr/local
  # cleanup
RUN sudo apt-get autoremove -y
RUN sudo apt-get autoclean -y
RUN sudo apt-get clean -y
RUN sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

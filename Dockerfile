FROM node:9

# install aws
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python && \
  pip install awscli --upgrade --user
ENV PATH $PATH:/root/.local/bin

# ADD . /app
# WORKDIR /app

FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y curl

RUN curl -sSL https://get.haskellstack.org/ | sh

WORKDIR ~/my-project

COPY stack.yaml stack.yaml.lock package.yaml helloworld.cabal Setup.hs ./

RUN stack setup

COPY . .

RUN stack build

EXPOSE 8080

CMD stack exec helloworld-exe
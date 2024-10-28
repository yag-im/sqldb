FROM mcr.microsoft.com/devcontainers/base:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        iputils-ping \
        postgresql-client

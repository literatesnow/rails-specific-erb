FROM ruby:2.5.1

ARG USER_UID=2000
ARG USER_GID=2000

RUN echo "Install apt" \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y update \
  && apt-get install -y --no-install-recommends \
     apt-utils apt-transport-https \
  && echo "Yarn source" \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg > /tmp/yarn.gpg \
  && apt-key add /tmp/yarn.gpg \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
  && echo "Install packages" \
  && apt-get -y update \
  && apt-get install -y --no-install-recommends \
     nodejs sqlite3 yarn \
  && echo "Create user" \
  && groupadd --gid "$USER_GID" service \
  && useradd -m --home /home/service --uid "$USER_UID" --gid service --shell /bin/bash service \
  && echo "Permissions" \
  && chown -R service:service /home/service/ \
  && echo "Cleaning up" \
  && apt-get -y clean \
  && apt-get --purge -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && echo "Done"

COPY --chown=service:service . /opt/service/

USER service

WORKDIR /opt/service/

RUN echo "Bundle" \
  && bundle install --without development test \
  && echo "Done"

EXPOSE 3000

ENTRYPOINT ["/opt/service/entrypoint", "3000"]

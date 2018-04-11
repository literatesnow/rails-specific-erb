FROM ruby:2.5

ARG USER_UID=2000
ARG USER_GID=2000

RUN echo "Install packages" \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get -y update \
  && apt-get install -y --no-install-recommends \
     nodejs sqlite3 \
  && echo "Create user" \
  && groupadd --gid "$USER_GID" service \
  && useradd -m --home /home/service --uid "$USER_UID" --gid service --shell /bin/bash service \
  && echo "Permissions" \
  && chown -R service:service /home/service/ \
  && echo "Cleaning up" \
  && apt-get clean -y \
  && apt-get --purge -y autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && echo "Done"

COPY --chown=service:service . /opt/service/

USER service

WORKDIR /opt/service/

RUN echo "Bundle" \
  && gem install service \
  && bundle install \
  && echo "Done"

ENTRYPOINT ["/bin/bash"]

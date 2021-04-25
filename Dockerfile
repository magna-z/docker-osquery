FROM debian:buster-slim

ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    OSQUERY_APT_VERSION=4.7.0-1.linux

RUN set -ex \
    && apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates gnupg \
    && echo 'deb [arch=amd64] https://pkg.osquery.io/deb deb main' > /etc/apt/sources.list.d/osquery.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B \
    && apt-get update \
    && apt-get install --yes --no-install-recommends osquery=$OSQUERY_APT_VERSION \
    && apt-get autoremove --yes gnupg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

ENTRYPOINT ["/usr/bin/osqueryd", "--S"]

CMD ["--flagfile", "/etc/osquery/osquery.flags"]

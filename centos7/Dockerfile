# HDCore extended docker images
ARG VERSION=7
FROM centos:${VERSION}
ARG VERSION
ARG PHASE=buildimage

# Labels
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL "maintainer"="HDCore"
LABEL "org.opencontainers.image.ref.name"="hdcore/docker-centos:centos${VERSION}"
LABEL "org.opencontainers.image.title"="HDCore extended centos image"
LABEL "org.opencontainers.image.source"="https://github.com/hdcore/docker-centos"
LABEL "org.opencontainers.image.url"="https://hub.docker.com/repository/docker/hdcore/docker-centos"

# Workdir
WORKDIR /workdir

# Copy scripts and add to the path
COPY ./scripts/* /usr/local/bin/hdcore/
RUN chmod +x /usr/local/bin/hdcore/*.sh
ENV PATH="/usr/local/bin/hdcore:${PATH}"

# Add proxy on build time
ARG http_proxy
ARG HTTP_PROXY
RUN set-proxy.sh

# Install basic tools
RUN yum -y --setopt=tsflags=nodocs update \ 
    && yum -y install wget nano git openssh-clients net-tools telnet mailx \
    && yum clean all \
    && rm -rf /var/cache/yum

# Add certificates on build time
COPY ./certificates/* /certificates/
ARG CACERT_FILE_ROOT
RUN set-cacertificates.sh trueffh55

# Install Oracle Client 19
COPY ./centos7/ol7-temp.repo /etc/yum.repos.d/ol7-temp.repo
RUN curl https://yum.oracle.com/RPM-GPG-KEY-oracle-ol7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle \
    && curl https://yum.oracle.com/RPM-GPG-KEY-oracle-ol7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle \
    && gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle \
    && yum install -y --setopt=tsflags=nodocs oracle-release-el7 && yum clean all && rm -rf /var/cache/yum
RUN yum install -y --setopt=tsflags=nodocs oracle-instantclient19.8-basic.x86_64 oracle-instantclient19.8-sqlplus.x86_64 oracle-instantclient19.8-tools.x86_64 \
    && yum clean all \
    && rm -rf /var/cache/yum
RUN mkdir /etc/yum.repos.d/disabled/ \
    && mv /etc/yum.repos.d/*ol7* /etc/yum.repos.d/disabled/
ENV ORACLE_HOME /usr/lib/oracle/19.8/client64
ENV TNS_ADMIN /usr/lib/oracle/19.8/client64/network/admin/
ENV NLS_LANG American_America.UTF8

# Install Ruby 2.4.6
RUN yum -y install centos-release-scl \
    && yum-config-manager --enable rhel-server-rhscl-7-rpms \
    && yum -y install rh-ruby24 rh-ruby24-ruby-devel \
    && yum clean all \
    && source /opt/rh/rh-ruby24/enable \
    && gem install bundler \
    && gem install rubocop-ast:1.4.1 rubocop:1.12.1

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["/bin/bash"]
# HDCore extended docker images
FROM centos:7

# Labels
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL "maintainer"="HDCore"
LABEL "org.opencontainers.image.ref.name"="hdcore/docker-centos:${VERSION}"
LABEL "org.opencontainers.image.title"="HDCore extended centos image"
LABEL "org.opencontainers.image.source"="https://github.com/hdcore/docker-centos"
LABEL "org.opencontainers.image.url"="https://hub.docker.com/repository/docker/hdcore/docker-centos"

# Workdir
WORKDIR /workdir

# Copy scripts and add to the path
COPY ./scripts/* /usr/local/bin/hdcore/
RUN chmod +x /usr/local/bin/hdcore/*.sh
ENV PATH="/usr/local/bin/hdcore:${PATH}"

# Install basic tools
RUN yum -y update \ 
    && yum -y install wget nano git openssh-clients net-tools telnet \
    && yum clean all \
    && rm -rf /var/cache/yum

# Install mailx
RUN yum -y update && yum install -y mailx
# COPY mail.rc /etc/mail.rc

# Install Oracle Client 19
COPY ./centos7-sfpd/ol7-temp.repo /etc/yum.repos.d/ol7-temp.repo
RUN curl https://yum.oracle.com/RPM-GPG-KEY-oracle-ol7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
RUN curl https://yum.oracle.com/RPM-GPG-KEY-oracle-ol7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
RUN gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
RUN yum install -y oracle-release-el7 && yum clean all && rm -rf /var/cache/yum
RUN yum install -y oracle-instantclient19.8-basic.x86_64 oracle-instantclient19.8-sqlplus.x86_64 oracle-instantclient19.8-tools.x86_64 && yum clean all && rm -rf /var/cache/yum
RUN mkdir /etc/yum.repos.d/disabled/ && mv /etc/yum.repos.d/*ol7* /etc/yum.repos.d/disabled/
ENV ORACLE_HOME /usr/lib/oracle/19.8/client64
ENV TNS_ADMIN /dir/to/TNS/containing/ora/
ENV NLS_LANG American_America.UTF8

# Install Ruby 2.4.6
RUN yum -y install centos-release-scl \
    && yum-config-manager --enable rhel-server-rhscl-7-rpms \
    && yum -y install rh-ruby24 rh-ruby24-ruby-devel \
    && yum clean all \
    && source /opt/rh/rh-ruby24/enable \
    && gem install bundler \
    && gem install rubocop -v 1.12.1

# Run infinity
# CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
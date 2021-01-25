# Use an old version of Ubuntu as it works unlike more recent versions
FROM ubuntu:16.04

ENV LC_ALL=C.UTF-8

# User account to build the sources with. Config system has check 
# to NOT allow building as user "root" so must use some other user
ENV user=build
ENV group=build
ENV UID=1000
ENV GID=1000

# Prepare build env
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

# Install depenencies and add symlinks to a bash/tar/mkdir to keep the build script happy
RUN apt-get update && apt-get install -y build-essential curl devscripts gawk bash \ 
    gcc-multilib gengetopt gettext git groff file flex libncurses5-dev libssl-dev \
    python2.7 subversion unzip vim-common zlib1g-dev wget nano mc && \
    addgroup --gid ${GID} ${group} && \
    useradd -u ${UID} -g ${GID} -d /home/${user} ${user} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /home/${user}/src && \
    chown -R ${user}:${group} /home/${user} && \
    ln -s /bin/bash /usr/bin/bash && \
    ln -s /bin/tar /usr/bin/tar && \
    ln -s /bin/mkdir /usr/bin/mkdir


USER ${user}:${group}

WORKDIR /home/${user}/src

CMD ["/bin/bash"]

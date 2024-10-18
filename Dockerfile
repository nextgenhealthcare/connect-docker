FROM eclipse-temurin:17-jre

RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends locales make perl build-essential libz-dev \
unzip \ 
&& sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen

#Remove the installed version of openssl, and replace it with an up-to-date version
ARG OPENSSL_VERSION="openssl-3.1.6"
RUN cd home \
&& curl -OSLk https://s3.amazonaws.com/downloads.mirthcorp.com/openssl/${OPENSSL_VERSION}.tar.gz \ 
&& apt-get -y remove openssl \
&& tar -xzvf ${OPENSSL_VERSION}.tar.gz \
&& cd ${OPENSSL_VERSION} \
&& ./config \
&& make install \
&& cd .. \
&& rm -rf ${OPENSSL_VERSION} \
&& rm -f ${OPENSSL_VERSION}.tar.gz

ENV LD_LIBRARY_PATH "/usr/local/lib64"

ARG ARTIFACT

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV MC_DOWNLOAD_URL=https://s3.us-east-1.amazonaws.com/downloads.mirthcorp.com/connect/4.5.2.b363/mirthconnect-4.5.2.b363-unix.tar.gz
ENV MC_CHECKSUM="47757d532e68dfe06d751db071e15f2f  /tmp/mirthconnect.tar.gz"

#put the download in its own layer so we don't have to wait for it while messing with other parts of the build
# it will cache
RUN <<EOF
    curl --location --show-error --output /tmp/mirthconnect.tar.gz ${MC_DOWNLOAD_URL}
    echo ${MC_CHECKSUM} | md5sum --check -
    tar -xvzC /opt -f /tmp/mirthconnect.tar.gz --exclude='Mirth Connect/*cli-*' --exclude='Mirth Connect/*manager-*' --exclude='Mirth Connect/mccommand' --exclude='Mirth Connect/mcmanager'
	mv "/opt/Mirth Connect" /opt/connect
    rm /tmp/mirthconnect.tar.gz
EOF

VOLUME /opt/connect/appdata /opt/connect/custom-extensions
WORKDIR /opt/connect

RUN <<EOF
  useradd -u 1001 mirth
  mkdir -p /opt/connect/appdata
  (cat mcserver.vmoptions /opt/connect/docs/mcservice-java9+.vmoptions ; echo "") > mcserver_base.vmoptions
  chown -R mirth:mirth /opt/connect
EOF

EXPOSE 8443

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

USER mirth
CMD ["./mcserver"]
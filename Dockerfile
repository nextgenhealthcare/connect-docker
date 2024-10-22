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

RUN curl -SL https://s3.amazonaws.com/downloads.mirthcorp.com/connect/4.5.2.b363/mirthconnect-4.5.2.b363-unix.tar.gz \
    | tar -xzC /opt \
    && mv "/opt/Mirth Connect" /opt/connect

RUN useradd -u 1001 mirth
RUN mkdir -p /opt/connect/appdata && chown -R mirth:mirth /opt/connect/appdata

VOLUME /opt/connect/appdata
VOLUME /opt/connect/custom-extensions
WORKDIR /opt/connect
RUN rm -rf cli-lib manager-lib \
    && rm mirth-cli-launcher.jar mirth-manager-launcher.jar mccommand mcmanager
RUN (cat mcserver.vmoptions /opt/connect/docs/mcservice-java9+.vmoptions ; echo "") > mcserver_base.vmoptions
EXPOSE 8443

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

RUN chown -R mirth:mirth /opt/connect
USER mirth
CMD ["./mcserver"]
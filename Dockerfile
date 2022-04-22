FROM openjdk:11-jre

RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends locales \ 
&& sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN curl -SL 'https://s3.amazonaws.com/downloads.mirthcorp.com/connect/4.0.1.b293/mirthconnect-4.0.1.b293-unix.tar.gz' \
    | tar -xzC /opt \
    && mv "/opt/Mirth Connect" /opt/connect

RUN useradd -u 1000 mirth
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
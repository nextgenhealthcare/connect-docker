FROM openjdk:11

RUN apt-get clean && apt-get update && apt-get install -y locales
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY resources/gosu-amd64-1.11 /usr/local/bin/gosu
RUN chmod +x /usr/local/bin/gosu
RUN curl -SL 'https://s3.amazonaws.com/downloads.mirthcorp.com/connect/3.8.0.b2464/mirthconnect-3.8.0.b2464-unix.tar.gz' \
    | tar -xzC /opt \
    && mv "/opt/Mirth Connect" /opt/connect
VOLUME /opt/connect/appdata
WORKDIR /opt/connect
RUN cat /opt/connect/docs/mcservice-java9+.vmoptions >> mcserver.vmoptions
EXPOSE 8443
RUN useradd -u 1000 mirth
COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
RUN chmod 755 /entrypoint.sh
RUN chown -R mirth:mirth /opt/connect
CMD ["./mcserver"]
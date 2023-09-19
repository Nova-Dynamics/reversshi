FROM alpine:3.14

RUN apk add --no-cache openssh

RUN sed -i 's/\#\? *PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/\#\? *PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
# RUN sed -i 's/\#\? *LogLevel.*/LogLevel DEBUG/' /etc/ssh/sshd_config

# Fix password from "!" which means 'lock' to "*" which means 'unmatchable hash'
#  See: https://stackoverflow.com/a/69392851
run sed -i 's/root:!/root:*/g' /etc/shadow

COPY tunnel.sh tunnel.sh
COPY entrypoint.sh entrypoint.sh

CMD [ "./entrypoint.sh" ]

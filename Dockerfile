FROM alpine:3.14

RUN apk add --no-cache openssh

RUN mkdir -p /etc/reversshi/keys

RUN adduser \
   --system \
   --shell /bin/sh \
   --disabled-password \
   --home /home/reversshi \
   reversshi
# Fix password from "!" which means 'lock' to "*" which means 'unmatchable hash'
#  See: https://stackoverflow.com/a/69392851
run sed -i 's/reversshi:!/reversshi:*/g' /etc/shadow

RUN mkdir -p /home/reversshi/.ssh

RUN sed -i 's/\#\? *AllowTcpForwarding.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config
RUN sed -i 's/\#\? *PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/\#\? *PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/\#\? *GatewayPorts.*/GatewayPorts yes/' /etc/ssh/sshd_config
# RUN sed -i 's/\#\? *LogLevel.*/LogLevel DEBUG/' /etc/ssh/sshd_config

COPY keys.sh /home/reversshi/keys.sh

COPY ssh.sh ssh.sh
COPY entrypoint.sh entrypoint.sh

CMD [ "./entrypoint.sh" ]

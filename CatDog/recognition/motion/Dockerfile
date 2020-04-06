FROM resin/rpi-raspbian:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install vim -y && apt-get install motion -y
RUN mkdir /mnt/motion && chown motion /mnt/motion
COPY motion.conf /etc/motion/motion.conf

VOLUME /mnt/motion
EXPOSE 8081
ENTRYPOINT ["motion"]

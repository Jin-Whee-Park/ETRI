FROM resin/rpi-raspbian:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y vim 
RUN apt-get install -y python python-pip build-essential libssl-dev libffi-dev
RUN apt-get install -y python-dev
RUN pip install -U pip
RUN pip install paramiko 
RUN pip install scp
RUN mkdir /sender && chmod 757 /sender
RUN mkdir /sender/videos && chmod 757 /sender/videos
#RUN mkdir /sender/result && chmod 757 /sender/result

COPY sender.py /sender
#ENTRYPOINT python sender.py
WORKDIR /sender
ENTRYPOINT ["python"]
CMD ["sender.py"]


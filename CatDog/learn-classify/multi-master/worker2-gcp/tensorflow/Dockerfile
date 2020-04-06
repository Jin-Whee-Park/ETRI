FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y python3 python3-pip python3-dev vim
RUN pip3 install flask && pip3 install tensorflow && pip3 install keras && pip3 install pillow
RUN mkdir /app && chmod 777 /app
#COPY app.py /app 
#COPY predict.py /app
#COPY model.h5 /app
#COPY model.json /app

#RUN mkdir /app/data && chmod 777 /app/data
ADD . /app
WORKDIR /app

EXPOSE 5000

CMD ["python3", "app.py"]





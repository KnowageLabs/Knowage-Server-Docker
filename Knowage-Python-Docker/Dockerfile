FROM python:3.7 AS build

WORKDIR /app

RUN git clone --branch master https://github.com/KnowageLabs/Knowage-Server.git

RUN ls -l Knowage-Server/*

FROM python:3.7

WORKDIR /app

COPY --from=build /app/Knowage-Server/Knowage-Python/pythonwebservice/ /app/Knowage-Server/Knowage-Python/requirements.txt ./

COPY gunicorn.conf.py entrypoint.sh /app/
COPY config.xml /app/app

RUN apt-get update \
	&& apt-get install -y xmlstarlet \
	&& pip install gunicorn==20.0.4 \
	&& pip install -r requirements.txt

RUN useradd -M -r knowage \
	&& chown -R knowage:knowage /app \
	&& chmod a+x *.sh

USER knowage

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "gunicorn","-c","file:/app/gunicorn.conf.py","knowage-python" ]


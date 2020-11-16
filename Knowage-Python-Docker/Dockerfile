FROM alpine/git AS build

WORKDIR /app

ARG KNOWAGE_APP_BRANCH

RUN git clone --branch $KNOWAGE_APP_BRANCH https://github.com/KnowageLabs/Knowage-Server.git

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

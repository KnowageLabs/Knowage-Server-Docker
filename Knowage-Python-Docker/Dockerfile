FROM docker.io/knowagelabs/knowage-python-docker-base:2.0

USER root

WORKDIR /app

ADD src ./
COPY requirements.txt ./

COPY gunicorn.conf.py entrypoint.sh ./
COPY config.xml ./app

RUN pip install --no-cache-dir -r requirements.txt

RUN chown -R knowage:knowage /app \
	&& chmod a+x ./*.sh

USER knowage

EXPOSE 5000/tcp

# Not compatible with OCI
#HEALTHCHECK --start-period=10s                                           \
#            --interval=5s                                                \
#            --timeout=5s                                                 \
#            --retries=5                                                  \
#            CMD wget -q --content-on-error --spider http://127.0.0.1:5000/dataset/libraries || exit 1

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "gunicorn","-c","file:/app/gunicorn.conf.py","knowage-python" ]

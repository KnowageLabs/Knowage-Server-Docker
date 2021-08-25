FROM alpine/git:v2.26.2-amd64 AS build

WORKDIR /app

ARG KNOWAGE_APP_BRANCH

# Depth
RUN git clone --depth 1 --branch $KNOWAGE_APP_BRANCH https://github.com/KnowageLabs/Knowage-Server.git

FROM knowagelabs/knowage-r-docker-base:1.0

USER root

WORKDIR /app

COPY --from=build /app/Knowage-Server/Knowage-R .
COPY LICENSE entrypoint.sh ./

RUN chown -R knowage:knowage /app \
    && chmod a+x *.sh

USER knowage

EXPOSE 5001/tcp

HEALTHCHECK --start-period=10s                                           \
            --interval=5s                                                \
            --timeout=5s                                                 \
            --retries=5                                                  \
            CMD wget -q -O /dev/null http://127.0.0.1:5001/dataset/libraries || exit 1

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "r","knowage-r.R" ]

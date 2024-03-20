FROM alpine/git:latest AS build

# From external
ARG IMAGE_DATE=use-build-arg-argument-during-build
ARG IMAGE_VERSION=use-build-arg-argument-during-build
ARG IMAGE_REVISION=use-build-arg-argument-during-build

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
    && chmod a+x ./*.sh

USER knowage

EXPOSE 5001/tcp

HEALTHCHECK --start-period=10s                                           \
            --interval=5s                                                \
            --timeout=5s                                                 \
            --retries=5                                                  \
            CMD wget -q -O /dev/null http://127.0.0.1:5001/dataset/libraries || exit 1

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "r","knowage-r.R" ]

LABEL org.opencontainers.image.created=$IMAGE_DATE                                \
  org.opencontainers.image.url="https://www.knowage-suite.com/"                   \
  org.opencontainers.image.source="https://github.com/KnowageLabs/Knowage-Server" \
  org.opencontainers.image.version=$IMAGE_VERSION                                 \
  org.opencontainers.image.revision=$IMAGE_REVISION                               \
  org.opencontainers.image.vendor="KNOWAGE Labs"                                  \
  org.opencontainers.image.title="KNOWAGE Community Edition"                      \
  org.opencontainers.image.description="Open source analytics and BI suite"       \
  org.opencontainers.image.documentation="https://knowage-suite.readthedocs.io/"  \
  org.opencontainers.image.authors="KNOWAGE Labs"                                 \
  org.opencontainers.image.licenses="AGPL 3.0"                                    \
  org.opencontainers.image.ref.name=""


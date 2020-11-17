FROM alpine/git:v2.26.2-amd64 AS build

WORKDIR /app

RUN git clone --depth 1 --branch release-knowage-server-7.2 https://github.com/KnowageLabs/Knowage-Server.git

FROM r-base:3.6.3

WORKDIR /app

COPY --from=build /app/Knowage-Server/Knowage-R .
COPY LICENSE entrypoint.sh ./

RUN apt-get update \
	&& apt-get install --no-install-recommends -y libssl-dev file libcurl4-openssl-dev libsodium-dev

# It takes too long: makes a separate layer
RUN r -e "install.packages('plumber')"

RUN r -e "install.packages('base64enc')" \
	&& r -e "install.packages('jose')" \
	&& chmod a+x *.sh

EXPOSE 5001/tcp

ENTRYPOINT [ "./entrypoint.sh" ]

HEALTHCHECK --start-period=10s                                          \
            --interval=60s                                               \
            --timeout=5s                                                 \
            --retries=5                                                  \
            CMD wget -q --content-on-error --spider http://127.0.0.1:5001/ || exit 1

CMD [ "r","knowage-r.R" ]

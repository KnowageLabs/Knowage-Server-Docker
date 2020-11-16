FROM alpine/git AS build

WORKDIR /app

ARG KNOWAGE_APP_BRANCH

RUN git clone --branch $KNOWAGE_APP_BRANCH https://github.com/KnowageLabs/Knowage-Server.git

FROM r-base

WORKDIR /app

COPY --from=build /app/Knowage-Server/Knowage-R .
COPY LICENSE entrypoint.sh ./

RUN apt-get update \
	&& apt-get install -y libssl-dev file

# It takes too long: makes a separate layer
RUN r -e "install.packages('plumber')"

RUN r -e "install.packages('base64enc')" \
	&& r -e "install.packages('jose')" \
	&& chmod a+x *.sh

EXPOSE 5001/tcp

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "r","knowage-r.R" ]

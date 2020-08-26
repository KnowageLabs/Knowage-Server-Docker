FROM alpine/git AS build

WORKDIR /app

RUN git clone --branch release-knowage-server-7.2 https://github.com/KnowageLabs/Knowage-Server.git

FROM r-base

WORKDIR /app

COPY --from=build /app/Knowage-Server/Knowage-R .
COPY entrypoint.sh ./

RUN apt-get update \
	&& apt-get install -y libssl-dev file

# It takes too long: makes a separate layer 
RUN r -e "install.packages('plumber')"

RUN r -e "install.packages('base64enc')" \
	&& r -e "install.packages('jose')" \
	&& chmod a+x *.sh

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "r","knowage-r.R" ]


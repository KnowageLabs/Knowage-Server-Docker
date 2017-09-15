FROM java:8

ENV KNOWAGE_VERSION=6.0.0-CE-Installer-Unix
ENV KNOWAGE_RELEASE_DATE=20170710
ENV KNOWAGE_URL=http://download.forge.ow2.org/knowage/Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip

RUN apt-get update && apt-get install -y wget coreutils unzip mysql-client

ENV KNOWAGE_DIRECTORY /home/knowage
RUN mkdir ${KNOWAGE_DIRECTORY}
WORKDIR ${KNOWAGE_DIRECTORY}

#download knowage and extract it
RUN wget "${KNOWAGE_URL}" && \
	unzip Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip && \
	rm Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip
	
COPY ./entrypoint.sh ./
COPY ./params.properties ./
#make all scripts executable
RUN chmod +x *.sh

EXPOSE 8080
#-d option is passed to run knowage forever without exiting from container
ENTRYPOINT ["./entrypoint.sh"]

CMD ["./Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.sh -q -varfile params.properties"]

WORKDIR ${KNOWAGE_DIRECTORY}/Knowage-Server-CE/bin

#make the script executable by bash (not only sh) and
#make knowage running forever without exiting
RUN sed -i "s/bin\/sh/bin\/bash/" startup.sh && \
	sed -i "s/EXECUTABLE\" start/EXECUTABLE\" run/" startup.sh
CMD ["./startup.sh"]

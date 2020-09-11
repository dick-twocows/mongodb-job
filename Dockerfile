FROM mongo:4.2.8

MAINTAINER DickM <dick@twocows.org>

COPY ./common.sh /common.sh
RUN chmod +x /common.sh

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./mongodb-run.sh /mongodb-run.sh
RUN chmod +x /mongodb-run.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/mongodb-run.sh"]

FROM debian:bullseye-slim

LABEL maintainer="itmig@molindointigas.co.id"

ENV DEBIAN_FRONTEND=noninteractive
ENV USER_UID 1000
ENV USER_NAME itmig
ENV USER_HOME /home/itmig
ENV USER2_UID 1001
ENV USER2_NAME it
ENV USER2_HOME /home/it

RUN apt-get update && \
    useradd -ms /bin/bash -u $USER_UID $USER_NAME && \
    useradd -ms /bin/bash -u $USER2_UID $USER2_NAME && \
    apt-get install -y --no-install-recommends --no-install-suggests apt-transport-https wget curl ca-certificates tzdata \
    && dpkg-reconfigure -f noninteractive tzdata
COPY sources.list /etc/apt/
RUN apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/* \
    && rm -rf /etc/localtime
RUN echo "Asia/Jakarta" > /etc/timezone && ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
CMD ["/bin/bash"]
FROM python:3.10-alpine
MAINTAINER Ben K <ben@lokun.is>


# linux-headers: tipc.h
#

ARG UID=1337
RUN set -x && \
    adduser --disabled-password --uid ${UID} calibre-web && \
    apk add --update --no-cache gcc musl-dev build-base libxml2-dev libxslt-dev py3-netifaces py3-lxml py3-ldap linux-headers

#RUN python3 -m pip install --upgrade pip
ENV PATH "/home/calibre-web/.local/bin:$PATH"
ENV PYTHONPATH /usr/lib/python3.10/site-packages

USER calibre-web


RUN set -x && \
    python3 -m pip install cython && \
    python3 -m pip install calibreweb && \
    python3 -m pip install calibreweb[gmail,goodreads,ldap,oauth,metadata,kobo]

# https://github.com/pgaskin/kepubify/releases/latest
# place the binary starting with kepubify in /opt/kepubify

EXPOSE 8083
CMD ["cps"]

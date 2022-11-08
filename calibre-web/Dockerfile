FROM python:3.10-alpine
MAINTAINER Ben K <ben@lokun.is>


# calibreweb needs these to build wheels of dependencies:
#  gcc musl-dev build-base libxml2-dev libxslt-dev linux-headers
# linux-headers: tipc.h

ARG UID=1337

COPY apk/repositories /etc/apk/repositories

RUN set -x && \
  adduser --disabled-password --uid ${UID} calibre-web && \
  apk add --update --no-cache py3-netifaces py3-lxml py3-pyldap py3-cryptography py3-greenlet cython && \
  # not needed to avoid compiling a wheel, but speedier this way \
  apk add --update --no-cache py3-openssl py3-tqdm py3-werkzeug py3-tz py3-tzdata py3-pypdf2 py3-tornado py3-sqlalchemy py3-dateutil py3-jsonschema py3-soupsieve

# needed (edge/testing)
RUN apk add --update --no-cache py3-cchardet py3-levenshtein

# goes faster
#RUN apk add --update --no-cache py3-tzlocal


# py3-apscheduler py3-tzlocal
#RUN python3 -m pip install --upgrade pip
ENV PATH "/home/calibre-web/.local/bin:$PATH"
ENV PYTHONPATH /usr/lib/python3.10/site-packages:/home/calibre-web/.local/lib/python3.10

USER calibre-web

# python3 -m pip install python-Levenshtein && \
# python3 -m pip install cython && \

RUN set -x && \
    python3 -m pip install --no-binary=:all: calibreweb && \
    python3 -m pip install --no-binary=:all: calibreweb[gmail,goodreads,ldap,oauth,metadata,kobo]

# https://github.com/pgaskin/kepubify/releases/latest
# place the binary starting with kepubify in /opt/kepubify


# to print to console: docker run -e "FLASK_DEBUG=1"
#ENV FLASK_DEBUG "1"

ENV CALIBRE_PORT 8083
EXPOSE 8083

ENTRYPOINT ["/home/calibre-web/.local/bin/cps"]
# disable the ssl server, thats for reverse proxies
CMD ["-k", "", "-c", ""]

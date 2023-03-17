FROM mikebrady/shairport-sync:latest

ARG UID="1208"
ARG GID="1301"

# setting up a user with uid/gid we want
#
# the user shairport-sync is added to the pre-existing audio group,
# which has ID 29, for access to the ALSA stuff

RUN set -x && \
    deluser shairport-sync && \
    addgroup -g ${GID} media && \
    adduser --disabled-password -u ${UID} shairport-sync -G media && \
    addgroup shairport-sync docker_audio && \
    addgroup shairport-sync audio

# this doesnt work because the container wants to start a bunch
# services and stuff, which it needs root for.
#USER shairport-sync
#ENTRYPOINT [ "/usr/local/bin/shairport-sync" ]

# so we use a entrypoint script to switch down to the shairport-sync
# user.
COPY --chown=shairport-sync:media docker/entrypoint.sh /usr/local/bin/entrypoint.sh
# this script is just to print 'id' for the currently running user to show
# us that shairport-sync is not running as root
COPY --chown=shairport-sync:media docker/start-shairport-sync.sh /usr/local/bin/start-shairport-sync.sh
RUN chmod +s /usr/local/bin/start-shairport-sync.sh

ENTRYPOINT [ "/init", "/usr/local/bin/entrypoint.sh" ]

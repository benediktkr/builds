FROM rust:alpine as base

ARG UID=${UID}
RUN set -x && \
        adduser --disabled-password --uid ${UID} user

FROM base as chef
RUN set -x && \
        mkdir -p /usr/src/lldap && \
        chown -R user. /usr/src/lldap && \
        apk add --update --no-cache npm openssl-dev musl-dev make perl curl

USER user
WORKDIR /usr/src/lldap

RUN set -x && \
        cargo --quiet install wasm-pack cargo-chef && \
        npm install --quiet rollup && \
        rustup target add wasm32-unknown-unknown

# https://github.com/LukeMathWalker/cargo-chef
FROM chef as planner
COPY --chown=user lldap .
# recipe is like 'requirements.txt' in python
RUN set -x && \
        cargo --quiet chef prepare --recipe-path recipe.json

FROM chef as builder
COPY --from=planner /usr/src/lldap/recipe.json .
# installs the dependencies (before project files are copied)
RUN set -x && \
        cargo --quiet chef cook --release --target wasm32-unknown-unknown  -p lldap_app  && \
        cargo --quiet chef cook --release --target x86_64-unknown-linux-musl -p lldap && \
        cargo --quiet chef cook --release --target x86_64-unknown-linux-musl -p migration-tool

# then we copy the source and build lldap itself
COPY --chown=user lldap/ .
RUN set -x && \
        cargo --quiet build --release --target x86_64-unknown-linux-musl -p lldap -p migration-tool

# and the frontend
WORKDIR /usr/src/lldap/app
# this was in one && step, put it back like that when it works
RUN set -x && wasm-pack build --target web
# [INFO]: :-) Your wasm pkg is ready to publish at /usr/src/lldap/app/pkg.
RUN set -x && npm install --quiet rollup
# npm says: "up to date", so probably find it in parent ../node_modules ?
RUN set -x /usr/src/lldap/node_modules/rollup/dist/bin/rollup /main.js --format iife --file ./pkg/bundle.js --globals bootstrap:bootstrap



#FROM ubuntu:22.04
FROM base as final
COPY --from=builder /usr/src/lldap/target/x86_64-unknown-linux-musl/release/lldap /usr/local/bin/lldap
COPY --from=builder /usr/src/lldap/target/x86_64-unknown-linux-musl/release/migration-tool /usr/local/bin/migration-tool

# bind mount over this file
COPY lldap/lldap_config.docker_template.toml /etc/lldap/config.toml

# change home dir?
# or change the default config?
RUN mkdir /data && chown -R user. /data

# or set docker run --user
USER user

ENV LDAP_PORT=3890
ENV HTTP_PORT=17170
EXPOSE ${LDAP_PORT} ${HTTP_PORT}

CMD ["/usr/local/bin/lldap", "run", "--config-file", "/etc/lldap/config.toml"]

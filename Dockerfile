FROM ubuntu:24.04 as build
RUN apt-get update \
    && apt-get install -yq git curl build-essential libssl-dev zlib1g-dev
WORKDIR /usr/src
COPY . .
RUN make
RUN chmod 755 objs/bin/mtproto-proxy

FROM ubuntu:24.04 as release
COPY --from=build --chmod=755 /usr/src/objs/bin/mtproto-proxy /usr/bin/mtproto-proxy
RUN /usr/bin/mtproto-proxy --help
CMD ["/usr/bin/mtproto-proxy", "--help"]

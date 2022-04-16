FROM debian:stable-slim AS builder
ARG VERSION
ENV VERSION=${VERSION:-0.7.5}
WORKDIR /src/app
RUN apt update && apt upgrade -y \
    && apt install -y build-essential cmake git libfreetype6-dev libsdl2-dev libpnglite-dev libwavpack-dev python3
ADD https://github.com/teeworlds/teeworlds/archive/refs/tags/${VERSION}.tar.gz .
RUN tar -xf ${VERSION}.tar.gz \
    && cd teeworlds-${VERSION} \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && make \
    && mkdir -p dist \
    && mv data teeworlds teeworlds_srv dist/

FROM debian:stable-slim
ARG VERSION
ENV VERSION=${VERSION:-0.7.5}
WORKDIR /src/app
COPY --from=builder /src/app/teeworlds-${VERSION}/build/dist ./
COPY ./config/ config/
VOLUME [ "/src/app/data/", "/src/app/config/"]
EXPOSE 8303/udp
CMD ./teeworlds_srv -f config/serverconfig.cfg
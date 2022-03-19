FROM ubuntu
ARG VERSION
ENV VERSION=${VERSION:-0.7.5}
WORKDIR /src/app
ADD https://github.com/teeworlds/teeworlds/releases/download/${VERSION}/teeworlds-${VERSION}-linux_x86_64.tar.gz .
RUN tar -xf teeworlds-${VERSION}-linux_x86_64.tar.gz \
    && mv teeworlds-${VERSION}-linux_x86_64 teeworlds \
    && rm teeworlds-${VERSION}-linux_x86_64.tar.gz
WORKDIR /src/app/teeworlds
COPY ./config/ config/
VOLUME [ "/src/app/teeworlds/data/" ]
EXPOSE 8303
CMD /src/app/teeworlds/teeworlds_srv -f config/serverconfig.cfg
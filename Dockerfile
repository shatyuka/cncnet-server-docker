FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine-aot AS build
WORKDIR /src

RUN apk add --no-cache git

ARG VERSION=4.0.36

RUN git clone --depth 1 -b v$VERSION https://github.com/Rans4ckeR/cncnet-server.git
WORKDIR /src/cncnet-server

ARG TARGETARCH
RUN ARCH=${TARGETARCH} && [ "$ARCH" = "amd64" ] && ARCH="x64" ; \
    dotnet restore -r linux-musl-${ARCH} ; \
    dotnet publish -c V2AndV3Release -r linux-musl-${ARCH} -p:PublishAot=true -p:UseAppHost=true -p:SatelliteResourceLanguages=en -p:AssemblyVersion=$VERSION --no-restore -o /app/out

FROM mcr.microsoft.com/dotnet/runtime-deps:10.0-alpine AS runtime
WORKDIR /app
COPY --from=build /app/out .

RUN adduser -D cncnet && chown -R cncnet:cncnet /app
USER cncnet

ENV SERVER_NAME="My CnCNet tunnel"
ENV MAX_CLIENTS=200
ENV PORT1=50001
ENV PORT2=50000

EXPOSE 50000/tcp 50000/udp 50001/udp 3478/udp 8054/udp

ENTRYPOINT ["/bin/sh", "-c", "exec ./cncnet-server --name \"$SERVER_NAME\" -2 -3 -m $MAX_CLIENTS -p $PORT1 -p2 $PORT2"]

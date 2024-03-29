FROM openjdk:8u332-jre-buster as base_image
ARG SB_BUILD_VERSION=5.0.6       #default scoreboard version 
ENV ENV_SB_VERSION=${SB_BUILD_VERSION}

FROM base_image as builder
# download precomiled file and extract to temp directory
WORKDIR /
RUN wget -q "https://github.com/rollerderby/scoreboard/releases/download/v${ENV_SB_VERSION}/crg-scoreboard_v${ENV_SB_VERSION}.zip" \
  && unzip -oq crg-scoreboard_v${ENV_SB_VERSION}.zip

FROM base_image
# copy required files into base image
WORKDIR /app
COPY --from=builder /crg-scoreboard_v${ENV_SB_VERSION}/ .
EXPOSE 8000/tcp

ENTRYPOINT [ "java", "-Done-jar.silent=true", "-Dorg.eclipse.jetty.server.LEVEL=WARN", "-jar", "lib/crg-scoreboard.jar" ]

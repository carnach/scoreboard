FROM openjdk:8-jdk-oraclelinux7 as base_image
ARG SB_BUILD_VERSION=5.0.4        #default scoreboard version 
ENV ENV_SB_VERSION=${SB_BUILD_VERSION}

FROM base_image as builder
# download precomiled file and extract to temp directory
WORKDIR /
RUN yum install -y wget unzip 
RUN wget -q "https://github.com/rollerderby/scoreboard/releases/download/v${ENV_SB_VERSION}/crg-scoreboard_v${ENV_SB_VERSION}.zip" \
  && unzip -oq crg-scoreboard_v${ENV_SB_VERSION}.zip

FROM base_image
# copy required files into base image
WORKDIR /app
COPY --from=builder /crg-scoreboard_v${ENV_SB_VERSION}/ .

EXPOSE 8000/tcp

ENTRYPOINT [ "java", "-Done-jar.silent=true", "-Dorg.eclipse.jetty.server.LEVEL=WARN", "-jar", "lib/crg-scoreboard.jar" ]

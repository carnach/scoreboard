FROM openjdk:8-jdk-oraclelinux7

WORKDIR /app
COPY ./build .

EXPOSE 8000/tcp

ENTRYPOINT [ "java", "-Done-jar.silent=true", "-Dorg.eclipse.jetty.server.LEVEL=WARN", "-jar", "lib/crg-scoreboard.jar" ]
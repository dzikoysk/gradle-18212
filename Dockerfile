FROM openjdk:16 AS build
COPY . /home/gradle-build
WORKDIR /home/gradle-build
RUN chmod +x /usr/java/openjdk-16/lib/jspawnhelper && chmod +x gradlew && ./gradlew build --no-daemon --stacktrace --debug

# Run stage
FROM openjdk:16
WORKDIR /app
COPY --from=build /home/gradle-build/build/libs/*.jar ./application.jar
ENTRYPOINT exec java -jar application.jar

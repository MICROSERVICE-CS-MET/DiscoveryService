# 1. Build stage
FROM gradle:8.1.1-jdk17 AS build

WORKDIR /discovery_service

# Copy the rest of the source code
COPY . .

# Build the application
RUN gradle build --no-daemon

# 2. Runtime stage
FROM openjdk:17-jdk-slim

WORKDIR /discovery_service

COPY --from=build /discovery_service/build/libs/discovery-service-0.0.1-SNAPSHOT.jar .

ENTRYPOINT ["java", "-jar", "discovery-service-0.0.1-SNAPSHOT.jar"]

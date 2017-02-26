FROM java:8-alpine
MAINTAINER Your Name <you@example.com>

ADD target/uberjar/my-auditorium.jar /my-auditorium/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/my-auditorium/app.jar"]

FROM alpine:3.19

RUN apk --no-cache add openjdk21-jre
RUN wget https://piston-data.mojang.com/v1/objects/45810d238246d90e811d896f87b14695b7fb6839/server.jar
RUN java -Xmx512M -Xms512M -jar /server.jar nogui
RUN sed -i 's/false/true/g' eula.txt
RUN sed -i 's/.*server-ip=.*/server-ip=0.0.0.0/g' /server.properties
RUN sed -i 's/.*online-mode.*/online-mode=false/g' /server.properties

CMD java -Xmx512M -Xms512M -jar /server.jar nogui

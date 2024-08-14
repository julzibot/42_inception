FROM alpine:3.19
RUN apk update && apk upgrade
RUN apk add --no-cache nginx openssl
RUN mkdir -p /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/server.crt \
	-keyout /etc/nginx/ssl/server.key \
	-subj "/C=FR/ST=PACA/L=NICE/O=42/OU=STUDENT/CN=jibot.42.fr/UID=jibot@student.42nice.fr"

COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/http.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]


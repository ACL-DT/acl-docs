FROM alpine:latest 
COPY . /app 
WORKDIR /app
RUN apk add --no-cache wget
ENTRYPOINT [ "sh" ]  
CMD ["hello_world.sh"]
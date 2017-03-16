FROM    frolvlad/alpine-glibc
LABEL   maintainer "Arvid E. Picciani <aep@hy5.berlin>"

RUN     mkdir /app
ADD     ./build/rustfmt /app/
ADD     ./main.sh /app/
ADD     ./json.sh /app/

RUN     adduser -u 9000 -D -h /app app
RUN     chown -R app:app /app

USER    app

VOLUME  /code
WORKDIR /code
CMD     ["/app/main.sh"]

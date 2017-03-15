FROM    base/devel
LABEL   maintainer "Arvid E. Picciani <aep@hy5.berlin>"
RUN     pacman -Sy --noconfirm rust cargo ruby ruby-bundler
ENV     GEM_HOME /usr/local/bundle
ENV     BUNDLE_PATH="$GEM_HOME" \
	    BUNDLE_BIN="$GEM_HOME/bin" \
	    BUNDLE_SILENCE_ROOT_WARNING=1 \
	    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV     PATH $BUNDLE_BIN:$PATH
RUN     mkdir -p "$GEM_HOME" "$BUNDLE_BIN" && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"


RUN     mkdir /app
RUN     useradd -u 9000 -d /app app
RUN     chown -R app:app /app

RUN     su app -c 'cargo install rustfmt --verbose'

ADD     Gemfile /app/
WORKDIR /app/
RUN     bundle install


ADD     main.rb /app/
RUN     chmod +x /app/main.rb
RUN     chown -R app:app /app

USER    app
CMD     ["/app/main.rb"]



VOLUME  /code
WORKDIR /code

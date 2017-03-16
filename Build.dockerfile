FROM    base/devel
RUN     pacman -Sy --noconfirm rust cargo
ADD     rustfmt .
WORKDIR rustfmt
RUN     cargo build --release

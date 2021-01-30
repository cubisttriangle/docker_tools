FROM archlinux
WORKDIR /esp
RUN pacman -Syu --noconfirm
RUN pacman -S --needed --noconfirm gcc git make flex bison gperf python-pip cmake ninja ccache dfu-util libusb which
RUN git clone --recursive https://github.com/espressif/esp-idf.git .
RUN ./install.sh
RUN source ./export.sh

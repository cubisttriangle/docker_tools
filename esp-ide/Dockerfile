FROM archlinux
WORKDIR /esp
RUN pacman -Sy --needed --noconfirm gcc git make flex bison gperf python-pip cmake ninja ccache dfu-util libusb which
RUN pacman -Scc
RUN git clone --recursive https://github.com/espressif/esp-idf.git .
RUN ./install.sh
RUN echo "source /esp/export.sh" > ~/.bashrc

FROM ubuntu
WORKDIR /workspace
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Denver
ENV SKIP_VSCODE=1
ENV SKIP_UART=1
RUN apt-get update && apt-get install -y apt-utils libusb-1.0-0-dev pkg-config python3 wget
RUN wget https://raw.githubusercontent.com/raspberrypi/pico-setup/master/pico_setup.sh
RUN sed -i 's/sudo //g' ./pico_setup.sh
RUN chmod +x ./pico_setup.sh
RUN ./pico_setup.sh

FROM ubuntu:16.04

MAINTAINER Yuriy Miroshnyk <y.miroshnyk@gmail.com>

RUN apt-get update && apt-get install -y \
	curl \
	libnss3 \
	build-essential \
	mesa-common-dev \
	libglu1-mesa-dev \
	libglib2.0-0 \
	git

# BEGIN X-SERVER IN DOCKER CONTAINER --------------------------------
# Setup mesa drivers
RUN apt update && apt install -y \
  libgl1-mesa-dev \
  libglew-dev \
  libsdl2-dev \
  libsdl2-image-dev \
  libglm-dev \
  libfreetype6-dev \
  mesa-utils \
  xdotool

# Setup xvfb
RUN DEBIAN_FRONTEND=noninteractive \
  apt install -y \
  xvfb \
  x11-xkb-utils \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-scalable \
  xfonts-cyrillic \
  xorg \
  openbox \
  xserver-xorg-core

# Setup our environment variables.
ENV XVFB_WHD="1920x1080x24"\
  DISPLAY=":99" \
  LIBGL_ALWAYS_SOFTWARE="1" \
  GALLIUM_DRIVER="llvmpipe" \
  LP_NO_RAST="false" \
  LP_DEBUG="" \
  LP_PERF="" \
  LP_NUM_THREADS=""

# Copy our entrypoint into the container.
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Set the default command.
ENTRYPOINT ["/entrypoint.sh"]

# END X-SERVER IN DOCKER CONTAINER --------------------------------

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install -y nodejs

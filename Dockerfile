ARG CONAN_IMAGE_VERSION

FROM conanio/${CONAN_IMAGE_VERSION}

RUN conan remote add bincrafters https://bincrafters.jfrog.io/artifactory/api/conan/public-conan

RUN conan config set general.revisions_enabled=1

# SDL2 dependencies

# Window/MinGW
# RUN sudo apt-get update && \
# sudo apt-get install --yes \
# libgl1-mesa-dev

# Linux
RUN sudo apt-get update && \
sudo apt-get install --yes \
libaudio-dev \
libfontenc-dev \
libgl1-mesa-dev \
libice-dev \
libjack-dev \
libsm-dev \
libx11-xcb-dev \
libxaw7-dev \
libxcb-icccm4-dev \
libxcb-image0-dev \
libxcb-keysyms1-dev \
libxcb-render-util0-dev \
libxcb-shm0-dev \
libxcb-util-dev \
libxcb-xinerama0-dev \
libxcb-xkb-dev \
libxcomposite-dev \
libxcursor-dev \
libxft-dev \
libxi-dev \
libxinerama-dev \
libxkbfile-dev \
libxmu-dev \
libxmuu-dev \
libxpm-dev \
libxrandr-dev \
libxrender-dev \
libxres-dev \
libxss-dev \
libxt-dev \
libxtst-dev \
libxv-dev \
libxvmc-dev

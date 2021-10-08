FROM ubuntu:latest
RUN apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install python3.8 python3.8-dev python3-pip libssl-dev libxinerama-dev libsdl2-dev curl libblas-dev liblapack-dev gfortran libssl-dev git cmake libusb-1.0-0-dev && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean
RUN cd / && \
  git clone --depth 1 --branch v2.49.0 https://github.com/IntelRealSense/librealsense.git && \
  cd librealsense && \
  mkdir build && \
  cd build && \
  cmake ../ -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python3.8 -DCMAKE_BUILD_TYPE=Release -DFORCE_RSUSB_BACKEND=ON && \
  make -j4 && \
  make install && \
  cd ../.. && \
  rm -rf librealsense
ENV PYTHONPATH /usr/lib/python3/dist-packages/pyrealsense2

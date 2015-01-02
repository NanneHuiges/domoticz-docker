#
# Dockerfile for Domoticz
#
# Based on version by LBTM
#
# Base image.
FROM ubuntu

MAINTAINER Nanne Huiges

# Install Domoticz from sources.
RUN \
  apt-get update && \
  apt-get install -y cmake apt-utils build-essential && \
  apt-get install -y libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev subversion curl libcurl4-openssl-dev libusb-dev zlib1g-dev

# Define working directory.
WORKDIR /root/

# Getting the source code
RUN \
  svn checkout svn://svn.code.sf.net/p/domoticz/code/trunk domoticz && \
  cd domoticz && cmake CMakeLists.txt && \
  make

# cp database (if present, otherwise gives info message)
ADD domoticz.db /root/domoticz/domoticz.db

# mountable backup dir
VOLUME /root/domoticz/backup

# Clean up APT when done.
RUN apt-get clean

# Expose port.
EXPOSE 8080

#CMD ["service domoticz start"]]
CMD ["/root/domoticz/domoticz", "-www 8080"]

# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    debhelper \
    libcapture-tiny-perl \
    libconfig-inifiles-perl \
    pv \
    lzop \
    mbuffer \
    build-essential \
    git \
    && apt-get clean

# Set the working directory
WORKDIR /workdir/sanoid

# Create a symbolic link to the debian package directory
RUN ln -s packages/debian .

# Build the Debian package and move it to the output directory
CMD dpkg-buildpackage -uc -us && mv ../sanoid_*_all.deb /workdir/sanoid/output/

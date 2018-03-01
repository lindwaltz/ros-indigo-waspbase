FROM lindwaltz/ros-indigo-desktop-full-nvidia

ARG DEBIAN_FRONTEND=noninteractive

# basic packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y screen tree \
    sudo synaptic nano bash-completion git \
    software-properties-common build-essential python-pip

# --------------------------------
# ROS stuff from WASP_VM install.sh

RUN apt-get install -y ros-indigo-rqt-graph ros-indigo-rqt-gui ros-indigo-rqt-plot \
    ros-indigo-kobuki-soft ros-indigo-kobuki-keyop ros-indigo-roscpp-tutorials \
    ros-indigo-rosserial-arduino ros-indigo-rosserial-server ros-indigo-openni2-launch \
    ros-indigo-openni2-camera ros-indigo-rgbd-launch ros-indigo-cmake-modules \
    ros-indigo-phidgets* ros-indigo-imu-filter*

# ROS TurtleBot installation
RUN apt-get install -y ros-indigo-turtlebot ros-indigo-turtlebot-apps \
  ros-indigo-turtlebot-interactions ros-indigo-turtlebot-simulator ros-indigo-kobuki-ftdi \
  ros-indigo-rocon-remocon ros-indigo-rocon-qt-library ros-indigo-ar-track-alvar-msgs \
  flex ros-indigo-mongodb-store ros-indigo-tf2-bullet \
  ros-indigo-audio-common ros-indigo-sound-play ros-indigo-adhoc-communication

# dev tools
RUN pip install wstool

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections

RUN apt-get install -y wget openjdk-7-jre ipython libblas-dev liblapack-dev gfortran \
    daemontools libudev-dev libiw-dev freeglut3-dev \
    libdc1394-22 libdc1394-22-dev \
    libjansson-dev nodejs npm libboost-dev imagemagick libtinyxml-dev \
    mercurial cmake libgts-dev libcanberra-gtk-module && \
    sudo ln -s /usr/bin/nodejs /usr/bin/node

# add FFMPEG repository
RUN add-apt-repository -y ppa:mc3man/trusty-media && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install ffmpeg -y

# add osrf repository (newer gazebo)
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu trusty main" > /etc/apt/sources.list.d/gazebo-latest.list' && \
    wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add - && \
    apt-get update && apt-get upgrade -y

# More utils (add utils here)
RUN apt-get update && \
    apt-get install -y tmux vim emacs mc fish zsh mesa-utils x11-apps jstest-gtk


FROM ubuntu:16.04
MAINTAINER Ahmad Haris

# Install apt packages
RUN apt update && apt install --yes curl
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash -
RUN apt install -y unzip git lib32stdc++6 lib32z1 nodejs s3cmd build-essential openjdk-8-jdk-headless sendemail libio-socket-ssl-perl libnet-ssleay-perl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install gradle
RUN curl -L https://services.gradle.org/distributions/gradle-4.10.2-bin.zip -o gradle-4.10.2-bin.zip
RUN unzip gradle-4.10.2-bin.zip -d /usr/local/
ENV GRADLE_HOME=/usr/local/gradle-4.10.2/
ENV PATH=$PATH:$GRADLE_HOME/bin 

# Install android SDK, tools and platforms
RUN mkdir /opt/android-sdk-linux
RUN cd /opt/android-sdk-linux && curl https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o android-sdk.zip && unzip android-sdk.zip && rm android-sdk.zip
ENV ANDROID_HOME /opt/android-sdk-linux
RUN echo 'y' | /opt/android-sdk-linux/tools/bin/sdkmanager "platform-tools" "platforms;android-21" "platforms;android-22" "platforms;android-23" "platforms;android-24" "platforms;android-25" "platforms;android-26" "platforms;android-27" "build-tools;28.0.3"

# Install npm packages
RUN npm i -g cordova@latest ionic@latest && npm cache clean --force

# Create dummy app to build and preload gradle and maven dependencies
# RUN git config --global user.email "you@example.com" && git config --global user.name "Your Name"
# RUN cd / && echo 'n' | ionic start --no-interactive --no-link app blank && cd /app && ionic --no-interactive platform add android && ionic --no-interactive build android && rm -rf * .??*

WORKDIR /app

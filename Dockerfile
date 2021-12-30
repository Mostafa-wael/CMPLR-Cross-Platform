#Stage 1 
#----------------------------------------------------------------
# Install the base image
FROM debian:latest AS build-env

# Install flutter dependencies
RUN apt-get update  -y && \
    apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 && \
    apt-get clean

# Clone the flutter repo -latest version-
RUN git clone -b flutter-2.5-candidate.3 https://github.com/flutter/flutter.git /usr/local/flutter



# Set flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter --version

# Enable flutter web
RUN flutter channel master  && flutter upgrade  && flutter config --enable-web 

# Copy files to container
WORKDIR /app
COPY ./cmplr .
# Build the web app
RUN flutter build web

# Stage 2 
#----------------------------------------------------------------
# Configure the server
FROM nginx:1.21.1-alpine

COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build-env /app/build/web /usr/share/nginx/html